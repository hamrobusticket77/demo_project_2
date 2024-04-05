import 'package:equatable/equatable.dart';

abstract class ChatState<T> {
  const ChatState();
}

class CommonChatState extends Equatable implements ChatState {
  const CommonChatState({this.statusCode});
  final int? statusCode;
  @override
  List<Object?> get props => [];
}

class CommonInitial extends CommonChatState {}

class CommonLoading extends CommonChatState {}

class CommonDummyLoading extends CommonChatState {}

class CreateQuestionError extends CommonChatState {
  final String message;
  const CreateQuestionError({required this.message, int? statusCode})
      : super(statusCode: statusCode);
  bool get isNoConnection => statusCode == 1000;
  @override
  List<Object?> get props => [message];
}


class GetChatError extends CommonChatState {
  final String message;
  const GetChatError({required this.message, int? statusCode})
      : super(statusCode: statusCode);
  bool get isNoConnection => statusCode == 1000;
  @override
  List<Object?> get props => [message];
}

class CommonNoData extends CommonChatState {
  const CommonNoData();
  @override
  List<Object?> get props => [];
}

class CommonDataFetchSuccess<T> extends CommonChatState {
  final List<T> data;
  const CommonDataFetchSuccess({required this.data});
  @override
  List<T> get props => [...data];
}

class QuestionCreateSuccess extends CommonChatState {}

class CommonStateSuccess<T> extends CommonChatState {
  final T data;
  const CommonStateSuccess({required this.data});
  @override
  List<Object?> get props => [data];
}

class FetchNewMessageState extends CommonChatState {}
