// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'applied_demand_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppliedDemandModelAdapter extends TypeAdapter<AppliedDemandModel> {
  @override
  final int typeId = 23;

  @override
  AppliedDemandModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppliedDemandModel(
      id: fields[0] as String,
      farmer: fields[1] as FarmerModel,
      appliedQuantity: fields[2] as int?,
      grantedQuantity: fields[3] as int?,
      grantDate: fields[4] as String?,
      demandQuantity: fields[5] as QuantityDetails?,
    );
  }

  @override
  void write(BinaryWriter writer, AppliedDemandModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.farmer)
      ..writeByte(2)
      ..write(obj.appliedQuantity)
      ..writeByte(3)
      ..write(obj.grantedQuantity)
      ..writeByte(4)
      ..write(obj.grantDate)
      ..writeByte(5)
      ..write(obj.demandQuantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppliedDemandModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
