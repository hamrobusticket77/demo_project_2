// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'demand_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DemandModelAdapter extends TypeAdapter<DemandModel> {
  @override
  final int typeId = 17;

  @override
  DemandModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DemandModel(
      id: fields[0] as String,
      createdAt: fields[1] as String,
      deletedAt: fields[2] as dynamic,
      project: fields[3] as ProjectModel,
      program: fields[4] as ProgramModel,
      fiscalYear: fields[5] as FiscalYear,
      quantityDetails: (fields[6] as List).cast<QuantityDetails>(),
      startDate: fields[7] as String,
      endDate: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DemandModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.deletedAt)
      ..writeByte(3)
      ..write(obj.project)
      ..writeByte(4)
      ..write(obj.program)
      ..writeByte(5)
      ..write(obj.fiscalYear)
      ..writeByte(6)
      ..write(obj.quantityDetails)
      ..writeByte(7)
      ..write(obj.startDate)
      ..writeByte(8)
      ..write(obj.endDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DemandModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
