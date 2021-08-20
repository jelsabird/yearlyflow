// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bullet_list.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BulletListAdapter extends TypeAdapter<BulletList> {
  @override
  final int typeId = 1;

  @override
  BulletList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BulletList(
      month: fields[1] as Month,
      timeOfMonth: fields[2] as TimeOfMonth,
      title: fields[3] as String,
      bulletPoints: (fields[4] as List).cast<String>(),
    )..inspirationType = fields[0] as InspirationType;
  }

  @override
  void write(BinaryWriter writer, BulletList obj) {
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
      ..write(obj.bulletPoints);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BulletListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
