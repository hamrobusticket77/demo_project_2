// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductModelAdapter extends TypeAdapter<ProductModel> {
  @override
  final int typeId = 34;

  @override
  ProductModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductModel(
      id: fields[0] as String,
      createdAt: fields[1] as String,
      productionDate: fields[2] as String,
      unit: fields[3] as String,
      quantity: fields[4] as int,
      estimatedPriceperunit: fields[5] as int,
      description: fields[6] as String,
      crops: fields[7] as Crops,
      statusActivity: (fields[8] as List).cast<StatusActivity>(),
      media: fields[9] as MediaModel?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.productionDate)
      ..writeByte(3)
      ..write(obj.unit)
      ..writeByte(4)
      ..write(obj.quantity)
      ..writeByte(5)
      ..write(obj.estimatedPriceperunit)
      ..writeByte(6)
      ..write(obj.description)
      ..writeByte(7)
      ..write(obj.crops)
      ..writeByte(8)
      ..write(obj.statusActivity)
      ..writeByte(9)
      ..write(obj.media);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StatusActivityAdapter extends TypeAdapter<StatusActivity> {
  @override
  final int typeId = 35;

  @override
  StatusActivity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StatusActivity(
      id: fields[0] as String,
      createdAt: fields[1] as String,
      status: fields[2] as String,
      remarks: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, StatusActivity obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.remarks);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatusActivityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CropsAdapter extends TypeAdapter<Crops> {
  @override
  final int typeId = 36;

  @override
  Crops read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Crops(
      id: fields[0] as int,
      name: fields[1] as String,
      type: fields[2] as CropTypeModel,
    );
  }

  @override
  void write(BinaryWriter writer, Crops obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CropsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
