// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fiscal_year.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FiscalYearAdapter extends TypeAdapter<FiscalYear> {
  @override
  final int typeId = 19;

  @override
  FiscalYear read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FiscalYear(
      id: fields[0] as String,
      startDate: fields[1] as String,
      endDate: fields[2] as String,
      fiscalYear: fields[3] as String,
      isActive: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, FiscalYear obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.startDate)
      ..writeByte(2)
      ..write(obj.endDate)
      ..writeByte(3)
      ..write(obj.fiscalYear)
      ..writeByte(4)
      ..write(obj.isActive);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FiscalYearAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
