import 'package:flutter/foundation.dart';
import 'package:yearly_flow/presentation/src/core/strings.dart';

enum Month {
  January,
  February,
  March,
  April,
  May,
  June,
  July,
  August,
  September,
  October,
  November,
  December
}

extension MonthExtension on Month {
  String get name => describeEnum(this);

  String get displayTitle {
    switch (this) {
      case Month.January: return Strings.month_january;
      case Month.February: return Strings.month_february;
      case Month.March: return Strings.month_march;
      case Month.April: return Strings.month_april;
      case Month.May: return Strings.month_may;
      case Month.June: return Strings.month_june;
      case Month.July: return Strings.month_july;
      case Month.August: return Strings.month_august;
      case Month.September: return Strings.month_september;
      case Month.October: return Strings.month_october;
      case Month.November: return Strings.month_november;
      case Month.December: return Strings.month_december;
    }
  }

  int get monthNumber {
    switch (this) {
      case Month.January: return 1;
      case Month.February: return 2;
      case Month.March: return 3;
      case Month.April: return 4;
      case Month.May: return 5;
      case Month.June: return 6;
      case Month.July: return 7;
      case Month.August: return 8;
      case Month.September: return 9;
      case Month.October: return 10;
      case Month.November: return 11;
      case Month.December: return 12;
    }
  }
}
