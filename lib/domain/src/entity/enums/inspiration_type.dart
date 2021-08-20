import 'package:hive/hive.dart';

import 'package:yearly_flow/presentation/src/core/strings.dart';

part 'inspiration_type.g.dart';

@HiveType(typeId: 4)
enum InspirationType {
  @HiveField(0)
  Note,
  @HiveField(1)
  BulletList,
  @HiveField(2)
  Recipe,
  @HiveField(3)
  Birthday
}

extension InspirationTypeExtension on InspirationType {
  String get displayTitle {
    switch (this) {
      case InspirationType.Note:
        return Strings.inspirationType_note;
      case InspirationType.BulletList:
        return Strings.inspirationType_bulletList;
      case InspirationType.Recipe:
        return Strings.inspirationType_recipe;
      case InspirationType.Birthday:
        return Strings.inspirationType_birthday;
    }
  }

  static InspirationType fromRaw(String? raw) {
    switch (raw) {
      case 'note':
        return InspirationType.Note;
      case 'bulletList':
        return InspirationType.BulletList;
      case 'recipe':
        return InspirationType.Recipe;
      case 'birthday':
        return InspirationType.Birthday;
      default:
        return InspirationType.Note;
    }
  }
}
