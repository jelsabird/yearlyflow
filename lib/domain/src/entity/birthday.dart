import 'package:hive/hive.dart';

import 'enums/inspiration_type.dart';
import 'enums/month.dart';
import 'enums/time_of_month.dart';
import 'inspiration.dart';

part 'birthday.g.dart';

@HiveType(typeId: 3)
class Birthday implements Inspiration {
  Birthday({
    this.key = '',
    this.month = Month.January,
    this.timeOfMonth = TimeOfMonth.Any,
    this.name = '',
    this.date,
  });

  @HiveField(0)
  @override
  String key;

  @HiveField(1)
  @override
  InspirationType inspirationType = InspirationType.Birthday;

  @HiveField(2)
  @override
  Month month;

  @HiveField(3)
  @override
  TimeOfMonth timeOfMonth;

  @override
  String get title {
    if (date == null) return '';
  int age = DateTime.now().year - date!.year;
  return '$name fyller ${age.toString()} år den ${date!.day
      .toString()}.${date!.month.toString()}';
  }

  @HiveField(4)
  String name = '';

  @HiveField(5)
  DateTime? date = DateTime.now();
}
