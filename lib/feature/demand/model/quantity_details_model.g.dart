// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quantity_details_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuantityDetailsAdapter extends TypeAdapter<QuantityDetails> {
  @override
  final int typeId = 21;

  @override
  QuantityDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuantityDetails(
      id: fields[0] as String,
      createdAt: fields[1] as String,
      subCategory: fields[2] as SubCategoryModel,
      quantity: fields[3] as int,
      appliedDemand: (fields[4] as List).cast<AppliedDemandModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, QuantityDetails obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.subCategory)
      ..writeByte(3)
      ..write(obj.quantity)
      ..writeByte(4)
      ..write(obj.appliedDemand);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuantityDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
