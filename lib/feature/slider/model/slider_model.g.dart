// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slider_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SliderModelAdapter extends TypeAdapter<SliderModel> {
  @override
  final int typeId = 5;

  @override
  SliderModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SliderModel(
      id: fields[0] as String,
      title: fields[1] as String,
      media: fields[2] as MediaModel,
    );
  }

  @override
  void write(BinaryWriter writer, SliderModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.media);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SliderModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
