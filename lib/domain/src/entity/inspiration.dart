import 'package:yearly_flow/domain/src/entity/enums/inspiration_type.dart';
import 'package:yearly_flow/domain/src/entity/enums/month.dart';
import 'package:yearly_flow/domain/src/entity/enums/time_of_month.dart';

class Inspiration {
  Inspiration({
    this.inspirationType = InspirationType.Note,
    this.month = Month.January,
    this.timeOfMonth = TimeOfMonth.Any,
  });

  InspirationType inspirationType;
  Month month;
  TimeOfMonth timeOfMonth;
  String get getTitle { return ''; }
}
