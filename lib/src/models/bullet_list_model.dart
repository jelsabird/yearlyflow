import 'package:hive/hive.dart';

import 'enums/inspiration_type.dart';
import 'enums/month.dart';
import 'enums/time_of_month.dart';
import 'inspiration_model.dart';

part 'bullet_list_model.g.dart';

@HiveType(typeId: 1)
class BulletListModel implements InspirationModel {
  BulletListModel({
    this.key = '',
    this.month = Month.January,
    this.timeOfMonth = TimeOfMonth.Any,
    this.title = '',
    this.bulletPoints = const <String>[],
  });

  @HiveField(0)
  @override
  final String key;

  @HiveField(1)
  @override
  InspirationType get inspirationType => InspirationType.BulletList;

  @HiveField(2)
  @override
  Month month;

  @HiveField(3)
  @override
  TimeOfMonth timeOfMonth;

  @HiveField(4)
  @override
  String title;

  @HiveField(5)
  List<String> bulletPoints;
}
