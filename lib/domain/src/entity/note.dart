import 'package:hive/hive.dart';

import 'enums/inspiration_type.dart';
import 'enums/month.dart';
import 'enums/time_of_month.dart';
import 'inspiration.dart';

part 'note.g.dart';

@HiveType(typeId: 0)
class Note implements Inspiration {
  Note({
    this.key = '',
    this.month = Month.January,
    this.timeOfMonth = TimeOfMonth.Any,
    this.title = '',
    this.text = '',
  });

  @HiveField(0)
  @override
  String key = '';

  @HiveField(1)
  @override
  InspirationType inspirationType = InspirationType.Note;

  @HiveField(2)
  @override
  Month month;

  @HiveField(3)
  @override
  TimeOfMonth timeOfMonth;

  @HiveField(4)
  @override
  String title = '';

  @HiveField(5)
  String text = '';
}
