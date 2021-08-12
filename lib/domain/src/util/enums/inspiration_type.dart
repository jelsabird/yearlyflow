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
      case InspirationType.Note: return 'Notat';
      case InspirationType.BulletList: return 'Liste';
      case InspirationType.CheckList: return 'Sjekkliste';
      case InspirationType.Recipe: return 'Oppskrift';
      case InspirationType.Birthday: return 'Bursdag';
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