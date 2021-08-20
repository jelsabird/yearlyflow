import 'package:yearly_flow/data/src/repository/data_controller.dart';

class SplashController {

  DataController dataController = DataController.instance;

  Future<void> init() async {
    await dataController.initDatabase();
  }

}