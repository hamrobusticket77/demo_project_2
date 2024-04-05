// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'images_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ImagesModelAdapter extends TypeAdapter<ImagesModel> {
  @override
  final int typeId = 27;

  @override
  ImagesModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ImagesModel(
      id: fields[0] as String,
      title: fields[1] as String,
      status: fields[2] as bool,
      album: fields[3] as Album,
      mediaGroup: fields[4] as MediaModel,
    );
  }

  @override
  void write(BinaryWriter writer, ImagesModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.album)
      ..writeByte(4)
      ..write(obj.mediaGroup);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImagesModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AlbumAdapter extends TypeAdapter<Album> {
  @override
  final int typeId = 28;

  @override
  Album read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Album(
      id: fields[0] as int,
      title: fields[1] as String,
      status: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Album obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlbumAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
