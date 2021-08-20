// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'month.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MonthAdapter extends TypeAdapter<Month> {
  @override
  final int typeId = 5;

  @override
  Month read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Month.January;
      case 1:
        return Month.February;
      case 2:
        return Month.March;
      case 3:
        return Month.April;
      case 4:
        return Month.May;
      case 5:
        return Month.June;
      case 6:
        return Month.July;
      case 7:
        return Month.August;
      case 8:
        return Month.September;
      case 9:
        return Month.October;
      case 10:
        return Month.November;
      case 11:
        return Month.December;
      default:
        return Month.January;
    }
  }

  @override
  void write(BinaryWriter writer, Month obj) {
    switch (obj) {
      case Month.January:
        writer.writeByte(0);
        break;
      case Month.February:
        writer.writeByte(1);
        break;
      case Month.March:
        writer.writeByte(2);
        break;
      case Month.April:
        writer.writeByte(3);
        break;
      case Month.May:
        writer.writeByte(4);
        break;
      case Month.June:
        writer.writeByte(5);
        break;
      case Month.July:
        writer.writeByte(6);
        break;
      case Month.August:
        writer.writeByte(7);
        break;
      case Month.September:
        writer.writeByte(8);
        break;
      case Month.October:
        writer.writeByte(9);
        break;
      case Month.November:
        writer.writeByte(10);
        break;
      case Month.December:
        writer.writeByte(11);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MonthAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
