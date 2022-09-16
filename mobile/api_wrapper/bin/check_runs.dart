import 'dart:convert';

import 'package:dotenv/dotenv.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';
import 'package:slack_notifier/slack_notifier.dart';
import 'package:timezone/timezone.dart';

import '../db/models/db_customer.dart';
import '../db/models/db_program.dart';
import '../db/models/db_run.dart';
import '../db/queries/get_programs_by_customer.dart';
import 'postgres_extensions.dart';

class CheckRuns {
  CheckRuns(this.db, this._env) : _getProgramsByCustomer = GetProgramsByCustomer(db);

  final PostgreSQLConnection Function() db;
  final GetProgramsByCustomer _getProgramsByCustomer;
  final DotEnv _env;

  Future<Response> call(Request request) async {
    return db().use((connection) async {
      // Query all customers from the database
      Future<List<DbCustomer>> getAllCustomers() async {
        final customersResult = await connection.query(
          'SELECT * FROM customer;',
        );
        final customers = <DbCustomer>[];
        for (final row in customersResult) {
          final map = row.toColumnMap();
          final customer = DbCustomer(
            id: map['customer_id'],
            activeControllerId: map['active_controller_id'],
          );
          customers.add(customer);
        }
        return customers;
      }

      // Get programs eligible to run
      Future<List<DbRun>> getRuns(DbCustomer customer) async {
        // Get the timezone of the user's active controller id
        // TODO(brandon): We should actually do this for all the customer's controllers
        final timezoneResult = await connection.query(
          'SELECT timezone FROM controller WHERE controller.controller_id=${customer.activeControllerId};',
        );
        final timezone = timezoneResult.single.toColumnMap()['timezone'];
        final location = getLocation(timezone);
        final currentTime = TZDateTime.now(location);
        final programs = await _getProgramsByCustomer(customer);
        final resultingRuns = <DbRun>[];
        for (final program in programs) {
          bool shouldProgramRun(DbProgram program) {
            print('Current customer time is $currentTime');
            final lastRunStartTime = TZDateTime.from(
              program.lastRunTime,
              location,
            );
            print('lastRunTime of ${program.name} is $lastRunStartTime');
            final programDuration = program.runs.fold<int>(
              0,
              (prev, curr) => prev + curr.durationSec,
            );
            print('duration of ${program.name} is $programDuration seconds');
            final calculatedLastRunEndTime = lastRunStartTime.add(
              Duration(seconds: programDuration),
            );
            print('Last run end time is $calculatedLastRunEndTime');

            final frequency = program.frequency;

            if (currentTime.isAfter(lastRunStartTime) && currentTime.isBefore(calculatedLastRunEndTime)) {
              print('currentTime is in middle of run');
              // We're in the middle of a program run, check to see if any runs are left
              final hasRemainingRuns = program.runs.any(
                (run) => run.lastRunTime.isBefore(lastRunStartTime),
              );
              if (hasRemainingRuns) {
                return true;
              }
            } else if (currentTime.isAfter(calculatedLastRunEndTime)) {
              print('currentTime is after last run end time');
              if (frequency.contains(currentTime.weekday)) {
                print('program ${program.name} should run today');
                final shouldRun = program.runs.any(
                  (run) {
                    final runStart = run.startTime(location, currentTime);
                    print('runStart for zone ${run.zoneId} is $runStart');
                    final isInMinute = runStart.isWithin(
                      const Duration(minutes: 1),
                      currentTime,
                    );
                    print('runStart within a minute of current time: $isInMinute');
                    return isInMinute;
                  },
                );
                print('program ${program.name} shouldRun? $shouldRun');
                return shouldRun;
              }
            }
            print('program ${program.name} should not run');
            return false;
          }

          if (shouldProgramRun(program)) {
            final runs = program.runs
              ..sort(
                (a, b) => a
                    .startTime(location, currentTime)
                    .millisecondsSinceEpoch
                    .compareTo(b.startTime(location, currentTime).millisecondsSinceEpoch),
              );
            resultingRuns.add(runs.first);
          }
        }
        return resultingRuns;
      }

      final allCustomers = await getAllCustomers();

      final runsRun = <DbRun>[];
      for (final customer in allCustomers) {
        final runs = await getRuns(customer);
        if (runs.isNotEmpty) {
          for (final run in runs) {
            print('Running $run');
            runsRun.add(run);
          }
        }
      }
      // ignore: do_not_use_environment
      final token = _env['SLACK_WEBHOOK_URL']!;
      print(token);
      final notifier = SlackNotifier(token);
      final messages = runsRun
          .map(
            (e) => 'Running zone with id ${e.zoneId} '
                'for ${e.durationSec} seconds',
          )
          .toList();

      if (messages.isNotEmpty) {
        for (final message in messages) {
          await notifier.send(message);
        }
      }

      return Response.ok(
        jsonEncode(
          {
            'zones': runsRun.map((e) => e.zoneId).toList(),
          },
        ),
      );
    });
  }
}

extension on DateTime {
  bool isWithin(Duration duration, DateTime other) {
    return isAtSameMomentAs(other) || difference(other).inMilliseconds.abs() < duration.inMilliseconds;
  }
}

extension on DbRun {
  DateTime startTime(
    Location location,
    DateTime currentTime,
  ) {
    return TZDateTime(
      location,
      currentTime.year,
      currentTime.month,
      currentTime.day,
      startHour,
      startMinute,
    );
  }
}
