// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multi_language.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MultiLanguageAdapter extends TypeAdapter<MultiLanguage> {
  @override
  final int typeId = 10;

  @override
  MultiLanguage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MultiLanguage(
      en: fields[0] as String?,
      ne: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MultiLanguage obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.en)
      ..writeByte(1)
      ..write(obj.ne);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MultiLanguageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
