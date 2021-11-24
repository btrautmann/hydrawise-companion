import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hydrawise/features/programs/programs.dart';

class RunProgramsInBackground {
  Future<bool> call({
    required Map<String, dynamic> inputData,
    required ValueSetter<String> onPrint,
  }) async {
    final programsString = inputData['programs'] as String;
    final programsJson = json.decode(programsString) as List<dynamic>;
    final programs = programsJson.map((e) => ProgramX.fromJson(e));
    onPrint('Input programs: $programs');
    return true;
  }
}
