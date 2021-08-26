import 'package:yearly_flow/src/resources/data_controller.dart';

abstract class ISplashBloc {
  Future<void> init();
}

class SplashBloc implements ISplashBloc {
  SplashBloc(this._dataController);

  IDataController _dataController;

  Future<void> init() async {
    await _dataController.initDatabase();
    return Future.value();
  }
}
