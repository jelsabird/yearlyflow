import 'package:hive/hive.dart';

import 'enums/inspiration_type.dart';
import 'enums/month.dart';
import 'enums/time_of_month.dart';
import 'inspiration.dart';
part 'bullet_list.g.dart';

@HiveType(typeId: 1)
class BulletList extends Inspiration {
  BulletList({
    this.month = Month.January,
    this.timeOfMonth = TimeOfMonth.Any,
    this.title = '',
    this.bulletPoints = const <String>[],
  }) : super(
          inspirationType: InspirationType.BulletList,
          month: month,
          timeOfMonth: timeOfMonth,
        );

  @override
  String get getTitle => title;

  @HiveField(0)
  @override
  InspirationType inspirationType = InspirationType.BulletList;

  @HiveField(1)
  @override
  Month month;

  @HiveField(2)
  @override
  TimeOfMonth timeOfMonth;

  @HiveField(3)
  String title = '';

  @HiveField(4)
  List<String> bulletPoints = <String>[];
}
