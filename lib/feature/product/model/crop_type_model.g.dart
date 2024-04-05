// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crop_type_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CropTypeModelAdapter extends TypeAdapter<CropTypeModel> {
  @override
  final int typeId = 11;

  @override
  CropTypeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CropTypeModel(
      id: fields[0] as int,
      name: fields[1] as String,
      agricultureName: fields[2] as AgricultureName?,
    );
  }

  @override
  void write(BinaryWriter writer, CropTypeModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.agricultureName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CropTypeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
