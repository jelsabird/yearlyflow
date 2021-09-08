// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'birthday_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BirthdayModelAdapter extends TypeAdapter<BirthdayModel> {
  @override
  final int typeId = 3;

  @override
  BirthdayModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BirthdayModel(
      key: fields[0] as String,
      month: fields[2] as Month,
      timeOfMonth: fields[3] as TimeOfMonth,
      name: fields[4] as String,
      date: fields[5] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, BirthdayModel obj) {
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
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BirthdayModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
