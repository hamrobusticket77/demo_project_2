// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'downloads_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DownloadsModelAdapter extends TypeAdapter<DownloadsModel> {
  @override
  final int typeId = 45;

  @override
  DownloadsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DownloadsModel(
      id: fields[0] as String,
      name: fields[1] as String,
      description: fields[2] as String,
      createdAt: fields[4] as String,
      updatedAt: fields[5] as String,
      date: fields[6] as String,
      media: (fields[3] as List).cast<Photos>(),
    );
  }

  @override
  void write(BinaryWriter writer, DownloadsModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.media)
      ..writeByte(4)
      ..write(obj.createdAt)
      ..writeByte(5)
      ..write(obj.updatedAt)
      ..writeByte(6)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DownloadsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
