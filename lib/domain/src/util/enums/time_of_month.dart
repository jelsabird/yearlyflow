import 'package:yearly_flow/presentation/src/core/strings.dart';

enum TimeOfMonth {
  Any,
  Start,
  Middle,
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