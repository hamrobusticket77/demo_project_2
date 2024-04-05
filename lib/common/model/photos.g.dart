// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photos.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PhotosAdapter extends TypeAdapter<Photos> {
  @override
  final int typeId = 4;

  @override
  Photos read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Photos(
      id: fields[0] as String,
      createdAt: fields[1] as String,
      fileName: fields[2] as String,
      type: fields[3] as String,
      path: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Photos obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.fileName)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.path);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PhotosAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
