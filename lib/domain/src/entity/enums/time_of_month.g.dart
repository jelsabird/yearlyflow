// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_of_month.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TimeOfMonthAdapter extends TypeAdapter<TimeOfMonth> {
  @override
  final int typeId = 6;

  @override
  TimeOfMonth read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TimeOfMonth.Any;
      case 1:
        return TimeOfMonth.Start;
      case 2:
        return TimeOfMonth.Middle;
      case 3:
        return TimeOfMonth.End;
      default:
        return TimeOfMonth.Any;
    }
  }

  @override
  void write(BinaryWriter writer, TimeOfMonth obj) {
    switch (obj) {
      case TimeOfMonth.Any:
        writer.writeByte(0);
        break;
      case TimeOfMonth.Start:
        writer.writeByte(1);
        break;
      case TimeOfMonth.Middle:
        writer.writeByte(2);
        break;
      case TimeOfMonth.End:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeOfMonthAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
