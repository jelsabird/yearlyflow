import 'package:hive/hive.dart';

import 'package:yearly_flow/src/models/enums/inspiration_type.dart';
import 'package:yearly_flow/src/models/enums/month.dart';
import 'package:yearly_flow/src/models/enums/time_of_month.dart';
import 'package:yearly_flow/src/models/inspiration_model.dart';

part 'recipe_model.g.dart';

@HiveType(typeId: 2)
class RecipeModel implements InspirationModel {
  RecipeModel({
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
  final String key;

  @HiveField(1)
  @override
  InspirationType get inspirationType => InspirationType.Recipe;

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
  String introduction;

  @HiveField(6)
  List<String> ingredients;
  
  @HiveField(7)
  String instructions;
}
