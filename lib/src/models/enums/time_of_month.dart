import 'package:hive/hive.dart';

import 'package:yearly_flow/src/ui/core/strings.dart';

part 'time_of_month.g.dart';

@HiveType(typeId: 6)
enum TimeOfMonth {
@HiveField(0)
  Any,
@HiveField(1)
  Start,
@HiveField(2)
  Middle,
@HiveField(3)
  End
}

extension TimeOfMonthExtension on TimeOfMonth {
  String get displayTitle {
    switch (this) {
      case TimeOfMonth.Any: return Strings.timeOfMonth_any;
      case TimeOfMonth.Start: return Strings.timeOfMonth_start;
      case TimeOfMonth.Middle: return Strings.timeOfMonth_middle;
      case TimeOfMonth.End: return Strings.timeOfMonth_end;
    }
  }

  String get displayString {
    switch (this) {
      case TimeOfMonth.Any: return Strings.timeOfMonthString_any;
      case TimeOfMonth.Start: return Strings.timeOfMonthString_start;
      case TimeOfMonth.Middle: return Strings.timeOfMonthString_middle;
      case TimeOfMonth.End: return Strings.timeOfMonthString_end;
    }
  }

  static TimeOfMonth fromRaw(String? raw) {
    switch (raw) {
      case 'any': return TimeOfMonth.Any;
      case 'start': return TimeOfMonth.Start;
      case 'middle': return TimeOfMonth.Middle;
      case 'end': return TimeOfMonth.End;
      default: return TimeOfMonth.Any;
    }
  }
}