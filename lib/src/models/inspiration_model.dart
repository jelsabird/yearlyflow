import 'package:yearly_flow/src/models/enums/inspiration_type.dart';
import 'package:yearly_flow/src/models/enums/month.dart';
import 'package:yearly_flow/src/models/enums/time_of_month.dart';

abstract class InspirationModel{
  InspirationModel(
      {this.key = '',
      this.inspirationType = InspirationType.Note,
      this.month = Month.January,
      this.timeOfMonth = TimeOfMonth.Any,
      });

  String key;
  InspirationType inspirationType;
  Month month;
  TimeOfMonth timeOfMonth;
  String get title;
}
