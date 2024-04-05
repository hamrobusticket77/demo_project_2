// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_service_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlanServiceModelAdapter extends TypeAdapter<PlanServiceModel> {
  @override
  final int typeId = 20;

  @override
  PlanServiceModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlanServiceModel(
      id: fields[0] as String,
      services: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PlanServiceModel obj) {
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
      other is PlanServiceModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
