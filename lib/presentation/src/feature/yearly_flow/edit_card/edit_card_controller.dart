import 'package:yearly_flow/data/src/repository/data_controller.dart';
import 'package:yearly_flow/domain/src/entity/inspiration.dart';

class EditCardController{

  void save(Inspiration inspiration) {
    DataController.instance.save(inspiration);
  }
}