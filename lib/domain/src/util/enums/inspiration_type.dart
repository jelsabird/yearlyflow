import 'package:yearly_flow/presentation/src/core/strings.dart';

enum InspirationType {
  Note,
  BulletList,
  CheckList,
  Recipe,
  Birthday
}

extension InspirationTypeExtension on InspirationType {
  String get displayTitle {
    switch (this) {
      case InspirationType.Note: return Strings.inspirationType_note;
      case InspirationType.BulletList: return Strings.inspirationType_bulletList;
      case InspirationType.CheckList: return Strings.inspirationType_checkList;
      case InspirationType.Recipe: return Strings.inspirationType_recipe;
      case InspirationType.Birthday: return Strings.inspirationType_birthday;
    }
  }

  static InspirationType fromRaw(String? raw) {
    switch (raw) {
      case 'note': return InspirationType.Note;
      case 'bulletList': return InspirationType.BulletList;
      case 'checkList': return InspirationType.CheckList;
      case 'recipe': return InspirationType.Recipe;
      case 'birthday': return InspirationType.Birthday;
      default: return InspirationType.Note;
    }
  }
}