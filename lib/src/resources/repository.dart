import 'package:yearly_flow/data/src/repository/data_controller.dart';
import 'package:yearly_flow/src/models/month_section_model.dart';

class Repository{
  Future<MonthSectionModel> fetchAllInspirations() => DataController.instance
      .fetchAllInspirations();
}