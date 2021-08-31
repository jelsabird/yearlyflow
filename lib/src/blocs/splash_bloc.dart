import 'package:yearly_flow/src/resources/inspiration_service.dart';

abstract class ISplashBloc {
  Future<void> init();
}

class SplashBloc implements ISplashBloc {
  SplashBloc(this._dataController);

  IInspirationService _dataController;

  Future<void> init() async {
    return await _dataController.initDatabase();
  }
}
