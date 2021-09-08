
import 'package:yearly_flow/src/models/inspiration_model.dart';
import 'package:yearly_flow/src/resources/data_provider.dart';
import 'package:yearly_flow/src/models/models.dart';

abstract class IRepository {
  Future<Year> fetchAllInspirations();

  delete(InspirationModel inspiration);

  save(InspirationModel inspiration);
}

class Repository implements IRepository {
  Repository(this._inspirationService);

  IDataProvider _inspirationService;

  @override
  Future<Year> fetchAllInspirations() async {
    var inspirations = await _inspirationService
        .getAll();

    return Year(inspirations);
  }

  @override
  void delete(InspirationModel inspiration){
    _inspirationService.delete(inspiration);
  }

  @override
  void save(InspirationModel inspiration) {
    _inspirationService.addOrUpdate(inspiration);
  }

}