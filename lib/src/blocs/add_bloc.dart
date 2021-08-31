import 'package:event_bus/event_bus.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yearly_flow/src/models/birthday_model.dart';
import 'package:yearly_flow/src/models/bullet_list_model.dart';
import 'package:yearly_flow/src/models/enums/inspiration_type.dart';
import 'package:yearly_flow/src/models/inspiration_model.dart';
import 'package:yearly_flow/src/models/note_model.dart';
import 'package:yearly_flow/src/models/recipe_model.dart';
import 'package:yearly_flow/src/resources/inspiration_service.dart';
import 'package:yearly_flow/src/ui/events/Inspiration_created_event.dart';

abstract class IInspirationAddBloc {
  InspirationModel model = NoteModel();

  Stream<InspirationModel> get inspirationStream;

  add();

  changeTo(InspirationType inspirationType);

  dispose();
}

class InspirationAddBloc implements IInspirationAddBloc {
  InspirationAddBloc(
      this._service,
      this._eventBus)
      : _inspirationSubject = BehaviorSubject<InspirationModel>();

  InspirationModel model = NoteModel();
  final IInspirationService _service;
  final EventBus _eventBus;
  final BehaviorSubject<InspirationModel> _inspirationSubject;

  Stream<InspirationModel> get inspirationStream => _inspirationSubject.stream;

  void add() {
    _inspirationSubject.add(model);

    _service.add(model);

    _eventBus.fire(CardUpdatedEvent(model.month));
  }

  void changeTo(InspirationType inspirationType) {
    switch (inspirationType) {
      case InspirationType.Note:
        model = NoteModel();
        break;
      case InspirationType.BulletList:
        model = BulletListModel();
        break;
      case InspirationType.Recipe:
        model = RecipeModel();
        break;
      case InspirationType.Birthday:
        model = BirthdayModel(date: DateTime.now());
        break;
    }
  }

  void dispose() {
    _inspirationSubject.close();
  }
}
