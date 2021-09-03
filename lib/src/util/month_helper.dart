import 'package:yearly_flow/src/models/enums/month.dart';
import 'package:yearly_flow/src/models/enums/time_of_month.dart';

class MonthHelper{
  static Month getMonth(DateTime date){
    return Month.values.singleWhere((month) => month
        .monthNumber == date.month);
  }

  static TimeOfMonth getTimeOfMonth(DateTime date){
    if (date.day > 19){
      return TimeOfMonth.End;
    }
    if (date.day > 9){
      return TimeOfMonth.Middle;
    }
      return TimeOfMonth.Start;
  }
}