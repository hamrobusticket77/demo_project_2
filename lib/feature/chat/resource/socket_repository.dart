import 'package:flutter/widgets.dart';
import 'package:krishi_hub/common/constant/env.dart';
import 'package:krishi_hub/common/response/response.dart';
import 'package:krishi_hub/common/utils/internet_checker.dart';
import 'package:krishi_hub/feature/auth/resource/auth_repository.dart';
import 'package:krishi_hub/http/api_provider.dart';
import 'package:krishi_hub/http/custom_exception.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:web_socket_channel/web_socket_channel.dart';

class SocketRepository {
  final InternetCheck internetCheck;
  final AuthRepository authRepository;

  final Env env;

  final ApiProvider apiProvider;

  SocketRepository({
    required this.authRepository,
    required this.env,
    required this.apiProvider,
    required this.internetCheck,
  });

  IO.Socket? _socket;

  IO.Socket? get socket => _socket;

  Future<void> initSocket() async {
    await authRepository.fetchAccessToken();
    final value = authRepository.accessToken;

    // WebSocketChannel socket = WebSocketChannel();
    // try {
    //   final res = await apiProvider.get(Uri.parse(env.baseUrl), token: value);
    //   debugPrint(res.toString());
    // } catch (e) {
    //   debugPrint(e.toString());
    // }

    // channel.stream.listen((event) {
    //   debugPrint(event.toString());
    // });

    debugPrint("token: $value");

    debugPrint("Init called");

    _socket ??= IO.io(
        env.socketUrl,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .enableAutoConnect()
            .setAuth({
              "token": value,
            })
            .build());

    _socket!.onAny((event, data) {
      debugPrint("Socket: \n \n ");
      debugPrint(event);
      debugPrint(data.toString());
    });
    if (_socket!.disconnected) {
      _socket!.connect();
    }
    if (_socket!.connected) {
      debugPrint("socket is connected");
    }
    _socket!.onConnect((data) {
      debugPrint('Socket Connected');
    });
    _socket!.onError((error) {
      debugPrint('socket have error:${error.toString()}');
      debugPrint(error.toString());
      throw Exception("error here");
    });
  }

  sockedDisconnectAndConnect(
      {required dynamic Function(dynamic) handler}) async {
    _socket?.dispose();
    _socket = null;
    await initSocket();
  }

  Future getQuestionList(
      {required dynamic Function(dynamic) handler,
      required int currentPage}) async {
    try {
      if (!await internetCheck.check()) {
        throw NoInternetException();
      }
      await initSocket();

      _socket!.emit('get-all-question', [
        {
          "perpage": "20",
          "page": currentPage.toString(),
          "search": "",
        }
      ]);
      if (_socket!.hasListeners(
        "get-all-question",
      )) {
        _socket!.off("get-all-question");
      }

      _socket!.on("get-all-question", handler);
    } catch (e) {
      rethrow;
    }
  }

  Future<DataResponse<bool>> createQuestion(
    String? question,
    dynamic Function(dynamic) handler,
  ) async {
    try {
      await initSocket();
      _socket!.emit("create-question", [
        {
          "question": question,
        }
      ]);

      if (_socket!.hasListeners(
        "create-question",
      )) {
        _socket!.off("create-question");
      }

      _socket!.on("create-question", (data) {
        debugPrint("hello");
      });

      _socket!.onAny((event, data) => null);

      return DataResponse.success(true);
    } on CustomException catch (e) {
      return DataResponse.error(e.toString());
    } catch (e) {
      debugPrint(e.toString());

      return DataResponse.error(e.toString());
    }
  }

  listenMessage(
    dynamic Function(dynamic) handler,
  ) async {
    try {
      await initSocket();
      // _socket!.emit("create-question");

      if (_socket!.hasListeners(
        "create-message",
      )) {
        _socket!.off("create-message");
      }

      _socket!.on("create-message", handler);

      return DataResponse.success(true);
    } on CustomException catch (e) {
      return DataResponse.error(e.toString());
    } catch (e) {
      debugPrint(e.toString());

      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<bool>> createMessage({
    required String message,
    required String questionId,
  }) async {
    try {
      await initSocket();
      _socket!.emit("create-message", [
        {
          "message": message,
          "questionId": questionId,
        }
      ]);

      return DataResponse.success(true);
    } on CustomException catch (e) {
      return DataResponse.error(e.toString());
    } catch (e) {
      debugPrint(e.toString());

      return DataResponse.error(e.toString());
    }
  }

  getChats({
    required dynamic Function(dynamic) handler,
    required String questionId,
    required int currentPage,
  }) {
    joinChat(questionId);
    _socket!.emit("get-old-messages", [
      {
        "questionId": questionId,
        "page": currentPage.toString(),
        "perpage": "20",
      }
    ]);
    if (_socket!.hasListeners(
      "get-old-messages",
    )) {
      _socket!.off("get-old-messages");
    }

    _socket!.on("get-old-messages", handler);
  }

  joinChat(String questionId) {
    _socket!.emit("join", [questionId]);
  }

  leaveChat(String questionId) {
    _socket!.emit('leave', [questionId]);
  }

  logoutSocket() {
    if (_socket != null) {
      _socket!.onclose("logout");
      _socket!.close();

      _socket!.disconnect();
      _socket = null;
    }
    // _socket!.hasListeners(event)
  }
}
