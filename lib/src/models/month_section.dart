import 'package:yearly_flow/src/models/enums/month.dart';
import 'package:yearly_flow/src/models/inspiration_model.dart';

class MonthSection {
  MonthSection(this.month);

  final Month month;

  List<InspirationModel> _inspirations = [];

  List<InspirationModel> get inspirations => _inspirations;
}