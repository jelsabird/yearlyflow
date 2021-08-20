// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NoteAdapter extends TypeAdapter<Note> {
  @override
  final int typeId = 0;

  @override
  Note read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Note(
      month: fields[1] as Month,
      timeOfMonth: fields[2] as TimeOfMonth,
      title: fields[3] as String,
      text: fields[4] as String,
    )..inspirationType = fields[0] as InspirationType;
  }

  @override
  void write(BinaryWriter writer, Note obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.inspirationType)
      ..writeByte(1)
      ..write(obj.month)
      ..writeByte(2)
      ..write(obj.timeOfMonth)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.text);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NoteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
