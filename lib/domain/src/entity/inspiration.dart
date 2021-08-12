import 'package:yearly_flow/domain/src/util/parser.dart';
import 'package:yearly_flow/domain/src/entity/inspiration_content.dart';
import 'package:yearly_flow/domain/src/util/enums/inspiration_type.dart';
import 'package:yearly_flow/domain/src/util/enums/month.dart';
import 'package:yearly_flow/domain/src/util/enums/time_of_month.dart';
import 'package:yearly_flow/domain/src/entity/note.dart';
import 'package:yearly_flow/domain/src/entity/birthday.dart';
import 'package:yearly_flow/domain/src/entity/bullet_list.dart';
import 'package:yearly_flow/domain/src/entity/check_list.dart';
import 'package:yearly_flow/domain/src/entity/recipe.dart';

class Inspiration {
  Inspiration(
    this.inspirationType,
    this.month, {
    this.content,
    this.timeOfMonth = TimeOfMonth.Any,
  });

  factory Inspiration.fromJson(Map<String, dynamic> json) {
    final String? inspirationTypeString =
        Parser.getString(json, 'inspirationType');
    final InspirationType parsedInspirationType =
        InspirationTypeExtension.fromRaw(inspirationTypeString);

    final String? timeOfMonthString = Parser.getString(json, 'timeOfMonth');
    final TimeOfMonth parsedTimeOfMonth =
        TimeOfMonthExtension.fromRaw(timeOfMonthString);

    final int? monthNumber = Parser.getInt(json, 'month');
    Month parsedMonth;
    if (monthNumber != null) {
      parsedMonth = Month.values.elementAt(monthNumber - 1);
    } else {
      parsedMonth = Month.January;
    }

    final Inspiration inspiration = Inspiration(
        parsedInspirationType, parsedMonth,
        timeOfMonth: parsedTimeOfMonth);

    final dynamic inspirationContentJson = json['content'];
    if (inspirationContentJson != null &&
        inspirationContentJson is Map<String, dynamic>) {
      switch (parsedInspirationType) {
        case InspirationType.Note:
          inspiration.content = Note.fromJson(inspirationContentJson);
          break;
        case InspirationType.Birthday:
          inspiration.content = Birthday.fromJson(inspirationContentJson);
          break;
        case InspirationType.BulletList:
          inspiration.content = BulletList.fromJson(inspirationContentJson);
          break;
        case InspirationType.CheckList:
          inspiration.content = CheckList.fromJson(inspirationContentJson);
          break;
        case InspirationType.Recipe:
          inspiration.content = Recipe.fromJson(inspirationContentJson);
          break;
      }
    }

    return inspiration;
  }

  Month month;
  InspirationType inspirationType;
  InspirationContent? content;
  TimeOfMonth timeOfMonth;
}
