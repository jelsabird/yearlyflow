// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inspiration_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InspirationTypeAdapter extends TypeAdapter<InspirationType> {
  @override
  final int typeId = 4;

  @override
  InspirationType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return InspirationType.Note;
      case 1:
        return InspirationType.BulletList;
      case 2:
        return InspirationType.Recipe;
      case 3:
        return InspirationType.Birthday;
      default:
        return InspirationType.Note;
    }
  }

  @override
  void write(BinaryWriter writer, InspirationType obj) {
    switch (obj) {
      case InspirationType.Note:
        writer.writeByte(0);
        break;
      case InspirationType.BulletList:
        writer.writeByte(1);
        break;
      case InspirationType.Recipe:
        writer.writeByte(2);
        break;
      case InspirationType.Birthday:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InspirationTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
