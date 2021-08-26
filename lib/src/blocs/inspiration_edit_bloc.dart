import 'package:yearly_flow/src/models/inspiration_model.dart';
import 'package:yearly_flow/src/models/note_model.dart';
import 'package:yearly_flow/src/resources/data_controller.dart';
import 'package:yearly_flow/src/ui/events/Inspiration_created_event.dart';
import 'package:yearly_flow/src/ui/util/event_bus_utils.dart';

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

    EventBusUtils.instance.fire(CardUpdatedEvent(model.month));
  }
}