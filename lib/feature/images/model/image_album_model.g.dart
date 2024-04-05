// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_album_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ImageAlbumModelAdapter extends TypeAdapter<ImageAlbumModel> {
  @override
  final int typeId = 49;

  @override
  ImageAlbumModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ImageAlbumModel(
      id: fields[0] as int,
      title: fields[1] as String,
      status: fields[2] as bool,
      createAt: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ImageAlbumModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.createAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImageAlbumModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
