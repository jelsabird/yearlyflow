import 'package:yearly_flow/src/models/enums/inspiration_type.dart';
import 'package:yearly_flow/src/models/enums/month.dart';
import 'package:yearly_flow/src/models/enums/time_of_month.dart';
import 'package:yearly_flow/src/models/models.dart';

abstract class InspirationModel {
  InspirationModel({
    this.key = '',
    this.month = Month.January,
    this.timeOfMonth = TimeOfMonth.Any,
  });

  final String key;

  InspirationType get inspirationType;

  final Month month;
  final TimeOfMonth timeOfMonth;

  String get title;

  static InspirationModel copyWith(InspirationModel inspiration, {Month?
  editedMonth, TimeOfMonth? editedTimeOfMonth}) {
    var month = editedMonth ?? inspiration.month;
    var timeOfMonth = editedTimeOfMonth ?? inspiration.timeOfMonth;
    switch (inspiration.inspirationType) {
      case InspirationType.Note:
        var note = inspiration as NoteModel;
        return copyWithNote(inspiration.key, month,
            timeOfMonth, inspiration.title, note.text);
      case InspirationType.BulletList:
        var bulletList = inspiration as BulletListModel;
        return copyWithBulletList(
            inspiration.key,
            month,
            timeOfMonth,
            inspiration.title,
            bulletList.bulletPoints);
      case InspirationType.Recipe:
        var recipe = inspiration as RecipeModel;
        return copyWithRecipe(
            inspiration.key,
            month,
            timeOfMonth,
            inspiration.title,
            recipe.introduction,
            recipe.ingredients,
            recipe.instructions);
      case InspirationType.Birthday:
        var birthday = inspiration as BirthdayModel;
        return copyWithBirthday(inspiration.key, birthday.name, birthday.date);
    }
  }

  static NoteModel copyWithNote(String key, Month month,
      TimeOfMonth timeOfMonth, String title, String text) {
    return NoteModel(
        key: key,
        month: month,
        timeOfMonth: timeOfMonth,
        title: title,
        text: text);
  }

  static BulletListModel copyWithBulletList(String key, Month month,
      TimeOfMonth timeOfMonth, String title, List<String> bulletPoints) {
    return BulletListModel(
        key: key,
        month: month,
        timeOfMonth: timeOfMonth,
        title: title,
        bulletPoints: bulletPoints);
  }

  static RecipeModel copyWithRecipe(
      String key,
      Month month,
      TimeOfMonth timeOfMonth,
      String title,
      String introduction,
      List<String> ingredients,
      String instructions) {
    return RecipeModel(
        key: key,
        month: month,
        timeOfMonth: timeOfMonth,
        title: title,
        introduction: introduction,
        ingredients: ingredients,
        instructions: instructions);
  }

  static BirthdayModel copyWithBirthday(
      String key, String name, DateTime? date) {
    return BirthdayModel(key: key, name: name, date: date);
  }
}
