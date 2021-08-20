// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecipeAdapter extends TypeAdapter<Recipe> {
  @override
  final int typeId = 2;

  @override
  Recipe read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Recipe(
      month: fields[1] as Month,
      timeOfMonth: fields[2] as TimeOfMonth,
    )..inspirationType = fields[0] as InspirationType;
  }

  @override
  void write(BinaryWriter writer, Recipe obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.inspirationType)
      ..writeByte(1)
      ..write(obj.month)
      ..writeByte(2)
      ..write(obj.timeOfMonth);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
