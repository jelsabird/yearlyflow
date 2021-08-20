import 'package:hive/hive.dart';

import 'enums/inspiration_type.dart';
import 'enums/month.dart';
import 'enums/time_of_month.dart';
import 'inspiration.dart';

part 'recipe.g.dart';

@HiveType(typeId: 2)
class Recipe extends Inspiration {
  Recipe({
    this.month = Month.January,
    this.timeOfMonth = TimeOfMonth.Any,
    this.title = '',
    this.introduction = '',
    this.ingredients = const <String>[],
    this.instructions = '',
      }) : super(
    inspirationType: InspirationType.Recipe,
    month: month,
    timeOfMonth: timeOfMonth,
  );

  @override
  String get getTitle => title;

  @HiveField(0)
  @override
  InspirationType inspirationType = InspirationType.Recipe;

  @HiveField(1)
  @override
  Month month;

  @HiveField(2)
  @override
  TimeOfMonth timeOfMonth;

  String title = '';
  String introduction = '';
  List<String> ingredients = <String>[];
  String instructions = '';
}
