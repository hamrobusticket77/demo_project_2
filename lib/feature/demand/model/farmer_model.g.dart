// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'farmer_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FarmerModelAdapter extends TypeAdapter<FarmerModel> {
  @override
  final int typeId = 25;

  @override
  FarmerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FarmerModel(
      id: fields[0] as String,
      farmerPersonalInformation: fields[2] as FarmerInfo,
    );
  }

  @override
  void write(BinaryWriter writer, FarmerModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.farmerPersonalInformation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FarmerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FarmerInfoAdapter extends TypeAdapter<FarmerInfo> {
  @override
  final int typeId = 26;

  @override
  FarmerInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FarmerInfo(
      firstName: fields[0] as MultiLanguage,
      middleName: fields[1] as MultiLanguage?,
      lastName: fields[2] as MultiLanguage,
    );
  }

  @override
  void write(BinaryWriter writer, FarmerInfo obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.firstName)
      ..writeByte(1)
      ..write(obj.middleName)
      ..writeByte(2)
      ..write(obj.lastName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FarmerInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
