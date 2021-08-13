import 'package:yearly_flow/domain/src/util/parser.dart';

import 'inspiration_content.dart';

class Birthday implements InspirationContent {
  Birthday(
    this.name,
    this.date,
  );

  factory Birthday.fromJson(Map<String, dynamic> json) {
    final String? parsedName = Parser.getString(json, 'name');
    final DateTime? parsedDate = Parser.getTime(json, 'date');
    if (parsedName == null) {
      throw Exception('Birthday.name cannot be null.');
    }
    if (parsedDate == null) {
      throw Exception('Birthday.date cannot be null');
    }

    return Birthday(
      parsedName,
      parsedDate,
    );
  }

  String name;
  DateTime date;
}
