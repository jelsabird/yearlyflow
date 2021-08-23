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
      key: fields[0] as String,
      month: fields[2] as Month,
      timeOfMonth: fields[3] as TimeOfMonth,
      title: fields[4] as String,
      bulletPoints: (fields[5] as List).cast<String>(),
    )..inspirationType = fields[1] as InspirationType;
  }

  @override
  void write(BinaryWriter writer, BulletList obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.inspirationType)
      ..writeByte(2)
      ..write(obj.month)
      ..writeByte(3)
      ..write(obj.timeOfMonth)
      ..writeByte(4)
      ..write(obj.title)
      ..writeByte(5)
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
