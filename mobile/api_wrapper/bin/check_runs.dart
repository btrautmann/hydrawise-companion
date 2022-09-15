import 'dart:convert';

import 'package:api_models/api_models.dart';
import 'package:postgres/postgres.dart';
import 'package:shelf/shelf.dart';
import 'package:timezone/timezone.dart';

import '../db/models/db_customer.dart';
import 'postgres_extensions.dart';

class CheckRuns {
  CheckRuns(this.db);

  final PostgreSQLConnection Function() db;

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
      Future<List<Program>> getRunnablePrograms(List<DbCustomer> customers) async {
        final runnablePrograms = <Program>[];
        for (final customer in customers) {
          // Get the timezone of the user's active controller id
          // TODO(brandon): We should actually do this for all the customer's controllers
          final timezoneResult = await connection.query(
            'SELECT timezone FROM controller WHERE controller.controller_id=${customer.activeControllerId};',
          );
          final timezone = timezoneResult.single.toColumnMap()['timezone'];
          final location = getLocation(timezone);
          final adjustedTime = TZDateTime.now(location);
          print('Customer time is $adjustedTime');
          final weekday = adjustedTime.weekday;
          // Get all programs whose frequency contains today (and their runs).
          // TODO(brandon): This is problematic, because a program's runs may
          // START on "today", but any runs that start on the following day
          // (i.e if the runs pass midnight), they won't be picked up.
          final programsResult = await connection.query(
            'SELECT * FROM program WHERE $weekday=ANY(frequency);',
          );

          final programs = <Program>[];
          for (final row in programsResult) {
            final map = row.toColumnMap();
            final program = Program(
              id: map['program_id'],
              name: map['name'],
              frequency: map['frequency'],
              runs: List.empty(),
            );

            final runsResult = await connection.query(
              'SELECT * FROM run WHERE program_id=${program.id};',
            );
            final runs = <Run>[];
            for (final row in runsResult) {
              final map = row.toColumnMap();
              final run = Run(
                id: map['run_id'],
                programId: map['program_id'],
                zoneId: map['zone_id'],
                durationSeconds: map['duration_sec'],
                startHour: map['start_hour'],
                startMinute: map['start_minute'],
                lastRunTime: map['last_run_time'],
              );
              runs.add(run);
            }
            programs.add(program.copyWith(runs: runs));
          }
          for (final program in programs) {
            bool shouldProgramRun(Program program) {
              print('Checking program "${program.name}"');
              print('Today is day $weekday');

              final programFrequency = program.frequency;
              print('programFrequency is $programFrequency');

              final indexOfToday = programFrequency.indexOf(weekday);
              assert(
                indexOfToday >= 0,
                'Program ${program.name} expected to include $weekday in '
                'frequency, but it didn\'t',
              );

              var indexOfPreviousRun = indexOfToday - 1;
              if (indexOfToday == 0 || indexOfPreviousRun < 0) {
                indexOfPreviousRun = programFrequency.length - 1;
              }
              final previousRunDay = programFrequency[indexOfPreviousRun];
              print('previousRunDay is day $previousRunDay');
              return true;
            }

            if (shouldProgramRun(program)) {
              runnablePrograms.add(program);
            }
          }
        }
        return runnablePrograms;
      }

      final allCustomers = await getAllCustomers();

      final resultPrograms = await getRunnablePrograms(allCustomers);

      return Response.ok(jsonEncode({'runnablePrograms': resultPrograms.length}));
    });
  }
}
