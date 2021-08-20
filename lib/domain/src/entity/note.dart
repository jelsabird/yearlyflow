import 'package:hive/hive.dart';

import 'enums/inspiration_type.dart';
import 'enums/month.dart';
import 'enums/time_of_month.dart';
import 'inspiration.dart';

part 'note.g.dart';

@HiveType(typeId: 0)
class Note extends Inspiration {
  Note({
    this.month = Month.January,
    this.timeOfMonth = TimeOfMonth.Any,
    this.title = '',
    this.text = '',
  }) : super(
          inspirationType: InspirationType.Note,
          month: month,
          timeOfMonth: timeOfMonth,
        );

  @override
  String get getTitle => title;

  @HiveField(0)
  @override
  InspirationType inspirationType = InspirationType.Note;

  @HiveField(1)
  @override
  Month month;

  @HiveField(2)
  @override
  TimeOfMonth timeOfMonth;

  @HiveField(3)
  String title = '';

  @HiveField(4)
  String text = '';
}
