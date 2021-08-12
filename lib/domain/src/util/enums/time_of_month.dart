enum TimeOfMonth {
  Any,
  Start,
  Middle,
  End
}

extension TimeOfMonthExtension on TimeOfMonth {
  String get displayTitle {
    switch (this) {
      case TimeOfMonth.Any: return 'Når som helst';
      case TimeOfMonth.Start: return 'Begynnelsen';
      case TimeOfMonth.Middle: return 'Midten';
      case TimeOfMonth.End: return 'Slutten';
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