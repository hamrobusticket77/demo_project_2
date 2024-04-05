// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer_question_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnswerQuestionModelAdapter extends TypeAdapter<AnswerQuestionModel> {
  @override
  final int typeId = 31;

  @override
  AnswerQuestionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AnswerQuestionModel(
      id: fields[0] as String,
      deletedAt: fields[1] as dynamic,
      callerFirstName: fields[2] as String,
      callerLastName: fields[3] as String,
      callerMiddleName: fields[4] as dynamic,
      callerPhoneNumber: fields[5] as String,
      callerEmail: fields[6] as String,
      questionAndAnswer: (fields[7] as List).cast<QuestionAndAnswer>(),
      address: fields[8] as String,
      farmerDetails: fields[9] as FarmerDetails,
    );
  }

  @override
  void write(BinaryWriter writer, AnswerQuestionModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.deletedAt)
      ..writeByte(2)
      ..write(obj.callerFirstName)
      ..writeByte(3)
      ..write(obj.callerLastName)
      ..writeByte(4)
      ..write(obj.callerMiddleName)
      ..writeByte(5)
      ..write(obj.callerPhoneNumber)
      ..writeByte(6)
      ..write(obj.callerEmail)
      ..writeByte(7)
      ..write(obj.questionAndAnswer)
      ..writeByte(8)
      ..write(obj.address)
      ..writeByte(9)
      ..write(obj.farmerDetails);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnswerQuestionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FarmerDetailsAdapter extends TypeAdapter<FarmerDetails> {
  @override
  final int typeId = 32;

  @override
  FarmerDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FarmerDetails(
      id: fields[0] as String,
      addedBy: fields[1] as String,
      userId: fields[2] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, FarmerDetails obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.addedBy)
      ..writeByte(2)
      ..write(obj.userId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FarmerDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class QuestionAndAnswerAdapter extends TypeAdapter<QuestionAndAnswer> {
  @override
  final int typeId = 33;

  @override
  QuestionAndAnswer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuestionAndAnswer(
      id: fields[0] as String,
      createdAt: fields[1] as String,
      deletedAt: fields[2] as String,
      question: fields[3] as String,
      answer: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, QuestionAndAnswer obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.deletedAt)
      ..writeByte(3)
      ..write(obj.question)
      ..writeByte(4)
      ..write(obj.answer);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionAndAnswerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
