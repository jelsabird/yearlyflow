import 'package:event_bus/event_bus.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yearly_flow/src/models/inspiration_model.dart';
import 'package:yearly_flow/src/models/note_model.dart';
import 'package:yearly_flow/src/resources/inspiration_service.dart';
import 'package:yearly_flow/src/ui/events/Inspiration_created_event.dart';

abstract class IInspirationEditBloc {

  InspirationModel model = NoteModel();

  Stream<InspirationModel> get inspirationStream;

  update();

  dispose();
}

class InspirationEditBloc implements IInspirationEditBloc {
  InspirationEditBloc(
      InspirationModel model,
      this._service,
      this._eventBus)
      : _inspirationSubject = BehaviorSubject<InspirationModel>.seeded(model);

  InspirationModel model = NoteModel();
  final IInspirationService _service;
  final EventBus _eventBus;
  final BehaviorSubject<InspirationModel> _inspirationSubject;

  Stream<InspirationModel> get inspirationStream => _inspirationSubject.stream;

  void update() {
    _inspirationSubject.add(model);

    _service.update(_inspirationSubject.value);

    _eventBus.fire(CardUpdatedEvent(model.month));
  }

  void dispose() {
    _inspirationSubject.close();
  }
}
