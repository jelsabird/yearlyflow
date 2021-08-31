import 'package:yearly_flow/src/models/inspiration_model.dart';
import 'package:yearly_flow/src/resources/inspiration_service.dart';
import 'package:yearly_flow/src/models/month_section.dart';

abstract class IRepository {
  Future<List<InspirationModel>> fetchAllInspirations();

  delete(InspirationModel inspiration);
}

class Repository implements IRepository {
  Repository(this._inspirationService);

  IInspirationService _inspirationService;

  Future<List<InspirationModel>> fetchAllInspirations() async => _inspirationService
      .getAll();

  void delete(InspirationModel inspiration){
    _inspirationService.delete(inspiration);
  }
}