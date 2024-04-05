// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'office_setup_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OfficeSetupModelAdapter extends TypeAdapter<OfficeSetupModel> {
  @override
  final int typeId = 1;

  @override
  OfficeSetupModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OfficeSetupModel(
      id: fields[0] as String,
      createdAt: fields[1] as String,
      name: fields[2] as String,
      fax: fields[3] as String,
      email: fields[4] as String,
      phoneNumber: fields[5] as String,
      telephone: fields[7] as String,
      address: fields[8] as String,
      callCenterNumber: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, OfficeSetupModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.fax)
      ..writeByte(4)
      ..write(obj.email)
      ..writeByte(5)
      ..write(obj.phoneNumber)
      ..writeByte(6)
      ..write(obj.callCenterNumber)
      ..writeByte(7)
      ..write(obj.telephone)
      ..writeByte(8)
      ..write(obj.address);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OfficeSetupModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
