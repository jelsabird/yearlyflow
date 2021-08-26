import 'package:yearly_flow/src/models/inspiration_model.dart';
import 'package:yearly_flow/src/models/note_model.dart';
import 'package:yearly_flow/src/resources/data_controller.dart';

abstract class IInspirationEditBloc {
  void save();
  InspirationModel model = NoteModel();
}

class InspirationEditBloc implements IInspirationEditBloc {
  InspirationEditBloc(this._dataController, this.model);

  IDataController _dataController;
  InspirationModel model;

  void save(){
    _dataController.save(model);
  }
}