// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agriculture_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AgricultureTypeAdapter extends TypeAdapter<AgricultureType> {
  @override
  final int typeId = 13;

  @override
  AgricultureType read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AgricultureType(
      id: fields[0] as int,
      title: fields[1] as MultiLanguage,
      agricultureName: (fields[2] as List).cast<AgricultureName>(),
    );
  }

  @override
  void write(BinaryWriter writer, AgricultureType obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.agricultureName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AgricultureTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
