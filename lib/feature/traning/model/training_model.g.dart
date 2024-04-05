// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrainingModelAdapter extends TypeAdapter<TrainingModel> {
  @override
  final int typeId = 14;

  @override
  TrainingModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TrainingModel(
      id: fields[0] as String,
      title: fields[1] as String,
      startDate: fields[2] as String,
      endDate: fields[3] as String,
      venue: fields[4] as String,
      trainer: fields[5] as String,
      isApplied: fields[6] as bool,
      media: fields[7] as Photos?,
      trainingApplicants: (fields[8] as List).cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, TrainingModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.startDate)
      ..writeByte(3)
      ..write(obj.endDate)
      ..writeByte(4)
      ..write(obj.venue)
      ..writeByte(5)
      ..write(obj.trainer)
      ..writeByte(6)
      ..write(obj.isApplied)
      ..writeByte(7)
      ..write(obj.media)
      ..writeByte(8)
      ..write(obj.trainingApplicants);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrainingModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
