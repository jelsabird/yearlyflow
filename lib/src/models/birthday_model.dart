import 'package:hive/hive.dart';

import 'package:yearly_flow/src/models/enums/inspiration_type.dart';
import 'package:yearly_flow/src/models/enums/month.dart';
import 'package:yearly_flow/src/models/enums/time_of_month.dart';
import 'package:yearly_flow/src/models/inspiration_model.dart';

part 'birthday_model.g.dart';

@HiveType(typeId: 3)
class BirthdayModel implements InspirationModel {
  BirthdayModel({
    this.key = '',
    this.month = Month.January,
    this.timeOfMonth = TimeOfMonth.Any,
    this.name = '',
    this.date,
  });

  @HiveField(0)
  @override
  final String key;

  @HiveField(1)
  @override
  InspirationType get inspirationType => InspirationType.Birthday;

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
  String name;

  @HiveField(5)
  DateTime? date;
}
