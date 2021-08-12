import 'package:flutter/foundation.dart';

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
      case Month.January: return 'Januar';
      case Month.February: return 'Februar';
      case Month.March: return 'Mars';
      case Month.April: return 'April';
      case Month.May: return 'Mai';
      case Month.June: return 'Juni';
      case Month.July: return 'Juli';
      case Month.August: return 'August';
      case Month.September: return 'September';
      case Month.October: return 'Oktober';
      case Month.November: return 'November';
      case Month.December: return 'Desember';
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
