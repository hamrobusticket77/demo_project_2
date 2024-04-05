import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/response/response.dart';
import 'package:krishi_hub/feature/chat/cubit/chat_socket_cubit.dart';
import 'package:krishi_hub/feature/chat/cubit/chat_socket_state.dart'
    as chat_state;
import 'package:krishi_hub/feature/chat/model/question_model.dart';
import 'package:krishi_hub/feature/chat/resource/all_question_repository.dart';
import 'package:krishi_hub/feature/chat/resource/socket_repository.dart';

class AllChatCubit extends Cubit<CommonState> {
  final ChatSocketCubit chatSocketCubit;

  // final ChatRepository chatRepository;
  final SocketRepository socketRepository;

  StreamSubscription? chatSocketCubitStream;
  final AllQuestionRepository allQuestionRepository;

  AllChatCubit({
    required this.chatSocketCubit,
    // required this.chatRepository,
    required this.socketRepository,
    required this.allQuestionRepository,
  }) : super(CommonInitial()) {
    chatSocketCubitStream = chatSocketCubit.stream.listen((event) async {
      if (event is chat_state.QuestionCreateSuccess) {
        await Future.delayed(const Duration(milliseconds: 200));
        getQuestionList();
      }
    });
  }

  int _currentPage = 1;
  int _totalPage = 0;
  final List<String> _items = [];
  List<String> get getItems => _items;

  getQuestionList() async {
    _items.clear();
    _currentPage = 1;
    _totalPage = 0;

    allQuestionRepository.removeAll();

    emit(CommonLoading());

    List<QuestionModel> temp = [];

    try {
      await socketRepository.getQuestionList(
          currentPage: _currentPage,
          handler: (data) {
            if (data != null) {
              temp = List.from(data['data'])
                  .map(
                    (e) => QuestionModel.fromMap(e),
                  )
                  .toList();

              for (int i = 0; i < temp.length; i++) {
                _items.add(temp[i].id);

                allQuestionRepository.addAll({temp[i].id: temp[i]});
              }

              _currentPage = data['pagination']?['currentPage'] ?? _currentPage;

              _totalPage = data['pagination']?['totalPages'] ?? _totalPage;

              emit(CommonDataFetchSuccess<String>(data: _items));
            } else {
              emit(const CommonNoData());
            }
          });
    } catch (e) {
      emit(CommonError(message: e.toString()));
    }
  }

  reloadQuestion() async {
    _items.clear();
    _currentPage = 1;
    _totalPage = 0;

    allQuestionRepository.removeAll();

    emit(CommonLoading());
    List<QuestionModel> temp = [];
    final res = await socketRepository.getQuestionList(
        currentPage: _currentPage,
        handler: (data) {
          if (data != null) {
            temp = List.from(data['data'])
                .map(
                  (e) => QuestionModel.fromMap(e),
                )
                .toList();

            for (int i = 0; i < temp.length; i++) {
              _items.add(temp[i].id);

              allQuestionRepository.addAll({temp[i].id: temp[i]});
            }

            _currentPage = data['pagination']?['currentPage'] ?? _currentPage;

            _totalPage = data['pagination']?['totalPages'] ?? _totalPage;

            emit(CommonDataFetchSuccess<String>(data: _items));
          } else {
            emit(const CommonNoData());
          }
        });
  }

  loadMoreQuestion({String? searchItem}) async {
    List<QuestionModel> temp = [];
    emit(CommonDummyLoading());

    if (_currentPage == _totalPage) {
      return DataResponse.success(_items);
    }
    _currentPage++;
    final res = await socketRepository.getQuestionList(
        currentPage: _currentPage,
        handler: (data) {
          if (data != null) {
            temp = List.from(data['data'])
                .map(
                  (e) => QuestionModel.fromMap(e),
                )
                .toList();

            for (int i = 0; i < temp.length; i++) {
              _items.add(temp[i].id);

              allQuestionRepository.addAll({temp[i].id: temp[i]});
            }

            _currentPage = data['pagination']?['currentPage'] ?? _currentPage;

            _totalPage = data['pagination']?['totalPages'] ?? _totalPage;

            emit(CommonDataFetchSuccess<String>(data: _items));
          } else {
            _currentPage--;

            emit(const CommonNoData());
          }
        });
  }
}
