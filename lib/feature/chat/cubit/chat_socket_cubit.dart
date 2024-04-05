
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/response/response.dart';
import 'package:krishi_hub/common/utils/custom_toast.dart';
import 'package:krishi_hub/common/utils/log.dart';
import 'package:krishi_hub/feature/chat/cubit/chat_socket_state.dart';
import 'package:krishi_hub/feature/chat/model/old_message.dart';
import 'package:krishi_hub/feature/chat/resource/all_chat_repository.dart';
import 'package:krishi_hub/feature/chat/resource/socket_repository.dart';

class ChatSocketCubit extends Cubit<CommonChatState> {
  final SocketRepository socketRepository;

  final AllChatRepository allChatRepository;

  ChatSocketCubit({
    required this.socketRepository,
    required this.allChatRepository,
  }) : super(CommonInitial());

  createQuestion(String question) async {
    emit(CommonLoading());

    final res = await socketRepository.createQuestion(question, (data) {
      if (data != null) {
        Log.d(data + "hello");
      }
    });

    if (res.status == Status.success) {
      emit(QuestionCreateSuccess());
    } else {
      emit(
        CreateQuestionError(message: res.message ?? "something went wrong"),
      );
    }
  }

  int _currentPage = 1;
  int _totalPage = 0;
  List<String> _items = [];
  List<String> get getItems => _items;

  getMessage(String questionId) {
    _items = [];
    List<OldMessage> temp = [];
    emit(CommonLoading());

    allChatRepository.removeAll();

    _items.clear();
    _currentPage = 1;
    _totalPage = 0;
    socketRepository.getChats(
        currentPage: _currentPage,
        handler: (data) {
          if (data != null) {
            temp = List.from(data['data'])
                .map(
                  (e) => OldMessage.fromMap(e),
                )
                .toList();

            for (int i = 0; i < temp.length; i++) {
              _items.add(temp[i].id);

              allChatRepository.addAll({temp[i].id: temp[i]});
            }

            _currentPage = data['pagination']?['currentPage'] ?? _currentPage;

            _totalPage = data['pagination']?['totalPages'] ?? _totalPage;

            emit(CommonDataFetchSuccess<String>(data: _items));
          } else {
            emit(const CommonNoData());
          }
        },
        questionId: questionId);

    socketRepository.listenMessage(
      (data) {
        if (data != null) {
          Log.d(data);
          emit(CommonDummyLoading());
          OldMessage message = OldMessage.fromMap(data);
          allChatRepository.add(message);
          _items.add(message.id);
          emit(CommonDataFetchSuccess<String>(data: _items));
        }
      },
    );
  }

  loadMoreMessage({String? searchItem}) async {
    List<OldMessage> temp = [];
    emit(CommonDummyLoading());

    if (_currentPage == _totalPage) {
      return DataResponse.success(_items);
    }
    _currentPage++;
    await socketRepository.getQuestionList(
        currentPage: _currentPage,
        handler: (data) {
          if (data != null) {
            List<String> newItems = [];
            temp = List.from(data['data'])
                .map(
                  (e) => OldMessage.fromMap(e),
                )
                .toList();

            for (int i = 0; i < temp.length; i++) {
              newItems.add(temp[i].id);

              allChatRepository.addAll({temp[i].id: temp[i]});
            }

            _currentPage = data['pagination']?['currentPage'] ?? _currentPage;

            _totalPage = data['pagination']?['totalPages'] ?? _totalPage;

            _items = [...newItems, ..._items];

            emit(CommonDataFetchSuccess<String>(data: _items));
          } else {
            _currentPage--;

            emit(const CommonNoData());
          }
        });
  }

  createMessage({required String message, required String questionId}) async {
    emit(CommonDummyLoading());
    final res = await socketRepository.createMessage(
        message: message, questionId: questionId);

    if (res.status == Status.success) {
      emit(CommonDataFetchSuccess<String>(data: _items));
    } else {
      CustomToast.error(message: res.message ?? "something went wrong");
    }
  }
}
