import 'package:hive/hive.dart';

import 'enums/inspiration_type.dart';
import 'enums/month.dart';
import 'enums/time_of_month.dart';
import 'inspiration.dart';

part 'recipe.g.dart';

@HiveType(typeId: 2)
class Recipe implements Inspiration {
  Recipe({
    this.key = '',
    this.month = Month.January,
    this.timeOfMonth = TimeOfMonth.Any,
    this.title = '',
    this.introduction = '',
    this.ingredients = const <String>[],
    this.instructions = '',
      });

  @HiveField(0)
  @override
  String key;

  @HiveField(1)
  @override
  InspirationType inspirationType = InspirationType.Recipe;

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
  String introduction = '';

  @HiveField(6)
  List<String> ingredients = <String>[];
  
  @HiveField(7)
  String instructions = '';
}
