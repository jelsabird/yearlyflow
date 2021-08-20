// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'birthday.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BirthdayAdapter extends TypeAdapter<Birthday> {
  @override
  final int typeId = 3;

  @override
  Birthday read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Birthday(
      month: fields[1] as Month,
      timeOfMonth: fields[2] as TimeOfMonth,
      name: fields[3] as String,
      date: fields[4] as DateTime?,
    )..inspirationType = fields[0] as InspirationType;
  }

  @override
  void write(BinaryWriter writer, Birthday obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.inspirationType)
      ..writeByte(1)
      ..write(obj.month)
      ..writeByte(2)
      ..write(obj.timeOfMonth)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BirthdayAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
