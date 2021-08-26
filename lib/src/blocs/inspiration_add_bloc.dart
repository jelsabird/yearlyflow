import 'package:uuid/uuid.dart';
import 'package:yearly_flow/src/models/birthday_model.dart';
import 'package:yearly_flow/src/models/bullet_list_model.dart';
import 'package:yearly_flow/src/models/enums/inspiration_type.dart';
import 'package:yearly_flow/src/models/inspiration_model.dart';
import 'package:yearly_flow/src/models/note_model.dart';
import 'package:yearly_flow/src/models/recipe_model.dart';
import 'package:yearly_flow/src/resources/data_controller.dart';

abstract class IInspirationAddBloc {
  save();

  changeTo(InspirationType inspirationType);
}

class InspirationAddBloc implements IInspirationAddBloc {
  InspirationAddBloc(this._service, this._uuid);

  IDataController _service;
  Uuid _uuid;
  InspirationModel model = NoteModel();

  void save() {
    model.key = _uuid.v4();
    _service.save(model);
  }

  void changeTo(InspirationType inspirationType) {
    switch (inspirationType) {
      case InspirationType.Note:
        model = NoteModel(key: _uuid.v4());
        break;
      case InspirationType.BulletList:
        model = BulletListModel(key: _uuid.v4());
        break;
      case InspirationType.Recipe:
        model = RecipeModel(key: _uuid.v4());
        break;
      case InspirationType.Birthday:
        model = BirthdayModel(key: _uuid.v4(), date: DateTime.now());
        break;
    }
  }
}
