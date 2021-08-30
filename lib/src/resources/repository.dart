import 'package:yearly_flow/src/models/inspiration_model.dart';
import 'package:yearly_flow/src/resources/data_controller.dart';
import 'package:yearly_flow/src/models/item_model.dart';

abstract class IRepository {
  Future<ItemModel> fetchAllInspirations();

  delete(InspirationModel inspiration);
}

class Repository implements IRepository {
  Repository(this._dataController);

  IDataController _dataController;

  Future<ItemModel> fetchAllInspirations() async => _dataController
      .fetchAllInspirations();

  void delete(InspirationModel inspiration){
    DataController.instance.delete(inspiration);
  }
}