import 'package:yearly_flow/domain/src/entity/enums/inspiration_type.dart';
import 'package:yearly_flow/domain/src/entity/enums/month.dart';
import 'package:yearly_flow/domain/src/entity/enums/time_of_month.dart';

abstract class Inspiration{
  Inspiration(
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
