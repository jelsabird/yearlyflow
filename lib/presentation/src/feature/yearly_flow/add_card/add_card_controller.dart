import 'package:yearly_flow/data/src/repository/data_controller.dart';
import 'package:yearly_flow/domain/src/entity/birthday.dart';
import 'package:yearly_flow/domain/src/entity/bullet_list.dart';
import 'package:yearly_flow/domain/src/entity/enums/inspiration_type.dart';
import 'package:yearly_flow/domain/src/entity/inspiration.dart';
import 'package:yearly_flow/domain/src/entity/note.dart';
import 'package:yearly_flow/domain/src/entity/recipe.dart';

class AddCardController{
  late Inspiration inspiration = Note();

  void save() {
    switch (inspiration.inspirationType) {
      case InspirationType.Note:
        DataController.instance.noteBox.add(inspiration as Note);
        break;
      case InspirationType.BulletList:
        DataController.instance.bulletListBox.add(inspiration as BulletList);
        break;
      case InspirationType.Recipe:
        DataController.instance.recipeBox.add(inspiration as Recipe);
        break;
      case InspirationType.Birthday:
        DataController.instance.birthdayBox.add(inspiration as Birthday);
        break;
    }
  }
}