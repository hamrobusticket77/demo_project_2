// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agriculture_name.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AgricultureNameAdapter extends TypeAdapter<AgricultureName> {
  @override
  final int typeId = 6;

  @override
  AgricultureName read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AgricultureName(
      id: fields[0] as int,
      title: fields[1] as MultiLanguage,
      category: fields[2] as CropTypeModel,
      name: fields[3] as CropTypeModel,
      media: fields[4] as MediaModel,
      details: fields[5] as Details?,
      disease: (fields[6] as List).cast<Disease>(),
    );
  }

  @override
  void write(BinaryWriter writer, AgricultureName obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.category)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.media)
      ..writeByte(5)
      ..write(obj.details)
      ..writeByte(6)
      ..write(obj.disease);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AgricultureNameAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DetailsAdapter extends TypeAdapter<Details> {
  @override
  final int typeId = 7;

  @override
  Details read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Details(
      id: fields[0] as int,
      values: (fields[1] as List).cast<Value>(),
    );
  }

  @override
  void write(BinaryWriter writer, Details obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.values);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ValueAdapter extends TypeAdapter<Value> {
  @override
  final int typeId = 8;

  @override
  Value read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Value(
      columnName: fields[0] as String,
      values: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Value obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.columnName)
      ..writeByte(1)
      ..write(obj.values);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ValueAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DiseaseAdapter extends TypeAdapter<Disease> {
  @override
  final int typeId = 9;

  @override
  Disease read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Disease(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      media: fields[3] as MediaModel?,
    );
  }

  @override
  void write(BinaryWriter writer, Disease obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.media);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiseaseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
