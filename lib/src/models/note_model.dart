import 'package:hive/hive.dart';

import 'enums/inspiration_type.dart';
import 'enums/month.dart';
import 'enums/time_of_month.dart';
import 'inspiration_model.dart';

part 'note_model.g.dart';

@HiveType(typeId: 0)
class NoteModel implements InspirationModel {
  NoteModel({
    this.key = '',
    this.month = Month.January,
    this.timeOfMonth = TimeOfMonth.Any,
    this.title = '',
    this.text = '',
  });

  @HiveField(0)
  @override
  final String key;

  @HiveField(1)
  @override
  InspirationType get inspirationType => InspirationType.Note;

  @HiveField(2)
  @override
  final Month month;

  @HiveField(3)
  @override
  final TimeOfMonth timeOfMonth;

  @HiveField(4)
  @override
  String title;

  @HiveField(5)
  String text;
}
