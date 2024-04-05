// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agriculture_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AgricultureModelAdapter extends TypeAdapter<AgricultureModel> {
  @override
  final int typeId = 12;

  @override
  AgricultureModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AgricultureModel(
      id: fields[0] as int,
      title: fields[1] as MultiLanguage,
      agricultureType: (fields[2] as List).cast<AgricultureType>(),
    );
  }

  @override
  void write(BinaryWriter writer, AgricultureModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.agricultureType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AgricultureModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
