import 'package:hive/hive.dart';

import 'enums/inspiration_type.dart';
import 'enums/month.dart';
import 'enums/time_of_month.dart';
import 'inspiration.dart';

part 'birthday.g.dart';

@HiveType(typeId: 3)
class Birthday extends Inspiration {
  Birthday({
    this.month = Month.January,
    this.timeOfMonth = TimeOfMonth.Any,
    this.name = '',
    this.date,
  }) : super(
    inspirationType: InspirationType.Birthday,
    month: month,
    timeOfMonth: timeOfMonth,
  );

  @override
  String get getTitle {
    if (date == null) return '';
  int age = DateTime.now().year - date!.year;
  return '$name fyller ${age.toString()} år den ${date!.day
      .toString()}.${date!.month.toString()}';
  }

  @HiveField(0)
  @override
  InspirationType inspirationType = InspirationType.Birthday;

  @HiveField(1)
  @override
  Month month;

  @HiveField(2)
  @override
  TimeOfMonth timeOfMonth;

  @HiveField(3)
  String name = '';

  @HiveField(4)
  DateTime? date = DateTime.now();
}
