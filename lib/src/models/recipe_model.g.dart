// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecipeModelAdapter extends TypeAdapter<RecipeModel> {
  @override
  final int typeId = 2;

  @override
  RecipeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecipeModel(
      key: fields[0] as String,
      month: fields[2] as Month,
      timeOfMonth: fields[3] as TimeOfMonth,
      title: fields[4] as String,
      introduction: fields[5] as String,
      ingredients: (fields[6] as List).cast<String>(),
      instructions: fields[7] as String,
    )..inspirationType = fields[1] as InspirationType;
  }

  @override
  void write(BinaryWriter writer, RecipeModel obj) {
    writer
      ..writeByte(8)
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
      ..write(obj.introduction)
      ..writeByte(6)
      ..write(obj.ingredients)
      ..writeByte(7)
      ..write(obj.instructions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecipeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
