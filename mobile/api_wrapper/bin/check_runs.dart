import 'dart:convert';

import 'package:dotenv/dotenv.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';
import 'package:slack_notifier/slack_notifier.dart';
import 'package:timezone/timezone.dart';

import '../db/models/db_run.dart';
import '../db/queries/get_all_customers.dart';
import '../db/queries/get_controllers_by_customer_id.dart';
import '../db/queries/get_programs_by_customer.dart';
import 'postgres_extensions.dart';

class CheckRuns {
  CheckRuns(this.db, this._env)
      : _getProgramsByCustomer = GetProgramsByCustomer(db),
        _getControllersByCustomerId = GetControllersByCustomerId(db),
        _getAllCustomers = GetAllCustomers(db);

  final PostgreSQLConnection Function() db;
  final GetAllCustomers _getAllCustomers;
  final GetProgramsByCustomer _getProgramsByCustomer;
  final GetControllersByCustomerId _getControllersByCustomerId;
  final DotEnv _env;

  Future<Response> call(Request request) async {
    return db().use((connection) async {
      final currentServerTime = TZDateTime.now(UTC);
      print('Running /check_runs at server time: $currentServerTime');
      final notifier = SlackNotifier(_env['SLACK_WEBHOOK_URL']!);
      final customers = await _getAllCustomers();
      for (final customer in customers) {
        final controllers = await _getControllersByCustomerId(customer.id);
        // TODO(brandon): Add `controller_id` to `program` table so we can use correct
        // timezone when determining programs that should run. For now, use the timezone
        // of the activeControllerId
        final activeController = controllers.singleWhere((c) => c.id == customer.activeControllerId);
        final controllerTimezone = activeController.timezone;
        final controllerLocation = getLocation(controllerTimezone);
        final controllerCurrentTime = TZDateTime.now(controllerLocation);
        final programs = await _getProgramsByCustomer(customer);
        print('Checking customer: ${customer.id}');
        print('Controller is in timezone: $controllerTimezone');
        print('Controller current time is: $controllerCurrentTime');

        for (final program in programs) {
          final programLastRunStartTime = TZDateTime.from(program.lastRunTime, controllerLocation);
          final programDuration = program.runs.fold<int>(0, (prev, curr) => prev + curr.durationSec);
          final programLastRunEndTime = programLastRunStartTime.add(Duration(seconds: programDuration));
          final programFrequency = program.frequency;

          print('Checking program: ${program.name}');
          print('Program last run start time is: $programLastRunStartTime');
          print('Program duration is: $programDuration');
          print('Program calculated last run end time: $programLastRunEndTime');
          print('Program frequency is: $programFrequency');
          print('Today is day: ${controllerCurrentTime.weekday}');

          final isAfterLastStartTime = controllerCurrentTime.isAfter(programLastRunStartTime);
          final isBeforeLastEndTime = controllerCurrentTime.isBefore(programLastRunEndTime);
          print('isAfterLastStartTime: $isAfterLastStartTime');
          print('isBeforeLastEndTime: $isBeforeLastEndTime');

          if (isAfterLastStartTime && isBeforeLastEndTime) {
            print(
              'Controller current time is between last run start time '
              'and calculated last run end time; i.e we are currently running...',
            );
            final remainingRuns = program.runs.where((r) => r.lastRunTime.isBefore(programLastRunStartTime));
            final hasRemainingRuns = remainingRuns.isNotEmpty;
            // TODO(brandon): We should be able to check if any zones associated with runs in this
            // program are running.
            final currentlyRunningRuns = program.runs.where((r) {
              return r.lastRunTime.add(Duration(seconds: r.durationSec)).isAfter(currentServerTime);
            });
            final hasCurrentlyRunningRuns = currentlyRunningRuns.isNotEmpty;
            if (hasRemainingRuns) {
              print('Program has remaining runs: ${remainingRuns.map((e) => e.id).toList()}');
              if (hasCurrentlyRunningRuns) {
                print('Not running another run, program has currently running runs');
              } else {
                // TODO(brandon): Create _runNextRun(DbProgram program)
                final runs = remainingRuns.toList()
                  ..sort((a, b) {
                    final aStartTime = a.startTime(controllerLocation, controllerCurrentTime).millisecondsSinceEpoch;
                    final bStartTime = b.startTime(controllerLocation, controllerCurrentTime).millisecondsSinceEpoch;
                    return aStartTime.compareTo(bStartTime);
                  });
                final nextRun = runs.first;
                await notifier.send('Running ${nextRun.id} for ${nextRun.durationSec / 60} minutes');
                print('Setting run last_run_time to $currentServerTime');
                await connection.query(
                  'UPDATE run SET last_run_time=\'$currentServerTime\' WHERE run_id=${nextRun.id}',
                );
              }
            }
          } else if (controllerCurrentTime.isAfter(programLastRunEndTime) &&
              // TODO(brandon): This check should really be checking whether it's a different *day*, not
              // that it's been an entire day. This will resolve an edge case where you change a program
              // to start at an earlier time for the next day.
              programLastRunEndTime.difference(controllerCurrentTime).abs() > const Duration(days: 1)) {
            print(
              'Controller current time is is after '
              'calculated last run end time; i.e we are not running...',
            );
            if (programFrequency.contains(controllerCurrentTime.weekday)) {
              print('Program should run today');
              final shouldProgramStart = program.runs.any(
                (run) {
                  final runStartTime = run.startTime(controllerLocation, controllerCurrentTime);
                  print('Run start for zone ${run.zoneId} is $runStartTime');
                  // TODO(brandon): Refine this to ensure we are AFTER the first run start time so
                  // program doesn't start early. I.e for 8:00am, anything between 8:00:00 and 8:00:30
                  // is acceptable.
                  final isIn30Seconds = runStartTime.isWithin(
                    const Duration(seconds: 30),
                    controllerCurrentTime,
                  );
                  print('Run start for zone ${run.zoneId} within a minute of current time: $isIn30Seconds');
                  return isIn30Seconds;
                },
              );
              print('Program should start: $shouldProgramStart');
              if (shouldProgramStart) {
                print('Setting program last_run_time to $currentServerTime');
                await notifier.send('Starting program ${program.name} at $currentServerTime');
                await connection.query(
                  'UPDATE program SET last_run_time=\'$currentServerTime\' WHERE program_id=${program.id};',
                );
                // TODO(brandon): Create _runNextRun(DbProgram program)
                final runs = program.runs
                  ..sort((a, b) {
                    final aStartTime = a.startTime(controllerLocation, controllerCurrentTime).millisecondsSinceEpoch;
                    final bStartTime = b.startTime(controllerLocation, controllerCurrentTime).millisecondsSinceEpoch;
                    return aStartTime.compareTo(bStartTime);
                  });
                final nextRun = runs.first;
                print('Setting run last_run_time to $currentServerTime');
                await notifier.send('Running ${nextRun.id} for ${nextRun.durationSec / 60} minutes');
                await connection.query(
                  'UPDATE run SET last_run_time=\'$currentServerTime\' WHERE run_id=${nextRun.id}',
                );
              }
            }
          } else {
            print('Program ${program.name} should not run');
          }
        }
      }

      return Response.ok(jsonEncode({'status': 'healthy'}));
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
