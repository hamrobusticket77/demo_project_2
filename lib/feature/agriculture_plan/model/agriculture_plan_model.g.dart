// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agriculture_plan_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AgriculturePlanModelAdapter extends TypeAdapter<AgriculturePlanModel> {
  @override
  final int typeId = 29;

  @override
  AgriculturePlanModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AgriculturePlanModel(
      id: fields[0] as String,
      createdAt: fields[1] as String,
      farmerType: fields[2] as String,
      contactPersonName: fields[3] as String,
      benefittedHHS: fields[4] as int,
      totalCost: fields[5] as int,
      municipalityExpectedCost: fields[6] as int,
      landArea: fields[7] as String,
      activities: fields[8] as String,
      remarks: fields[9] as String,
      fiscalYear: fields[10] as FiscalYear,
      program: fields[11] as ProgramModel,
      project: fields[12] as ProgramModel,
      planningService: fields[13] as PlanningService,
      media: fields[14] as MediaModel?,
    );
  }

  @override
  void write(BinaryWriter writer, AgriculturePlanModel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.farmerType)
      ..writeByte(3)
      ..write(obj.contactPersonName)
      ..writeByte(4)
      ..write(obj.benefittedHHS)
      ..writeByte(5)
      ..write(obj.totalCost)
      ..writeByte(6)
      ..write(obj.municipalityExpectedCost)
      ..writeByte(7)
      ..write(obj.landArea)
      ..writeByte(8)
      ..write(obj.activities)
      ..writeByte(9)
      ..write(obj.remarks)
      ..writeByte(10)
      ..write(obj.fiscalYear)
      ..writeByte(11)
      ..write(obj.program)
      ..writeByte(12)
      ..write(obj.project)
      ..writeByte(13)
      ..write(obj.planningService)
      ..writeByte(14)
      ..write(obj.media);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AgriculturePlanModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PlanningServiceAdapter extends TypeAdapter<PlanningService> {
  @override
  final int typeId = 30;

  @override
  PlanningService read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlanningService(
      id: fields[0] as String,
      services: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PlanningService obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.services);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlanningServiceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
