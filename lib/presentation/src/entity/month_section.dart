import 'package:yearly_flow/domain/src/util/enums/month.dart';

class MonthSection {

  MonthSection(this.month);

  final Month month;

  String get title => month.displayTitle;
  int get number => month.monthNumber;
}