// import 'package:flutter/widgets.dart';
// import 'package:krishi_hub/common/constant/env.dart';
// import 'package:krishi_hub/common/response/response.dart';
// import 'package:krishi_hub/common/utils/log.dart';
// import 'package:krishi_hub/feature/auth/resource/auth_repository.dart';
// import 'package:krishi_hub/feature/chat/model/question_model.dart';
// import 'package:krishi_hub/feature/chat/resource/all_question_repository.dart';
// import 'package:krishi_hub/feature/chat/resource/chat_api_provider.dart';
// import 'package:krishi_hub/feature/chat/resource/socket_repository.dart';
// import 'package:krishi_hub/http/api_provider.dart';

// class ChatRepository {
//   final AuthRepository authRepository;
//   final ApiProvider apiProvider;
//   final Env env;

//   final AllQuestionRepository allQuestionRepository;
//   final SocketRepository socketRepository;

//   late ChatApiProvider chatApiProvider;

//   ChatRepository({
//     required this.authRepository,
//     required this.apiProvider,
//     required this.env,
//     required this.socketRepository,
//     required this.allQuestionRepository,
//   }) {
//     chatApiProvider = ChatApiProvider(
//       authRepository: authRepository,
//       apiProvider: apiProvider,
//       baseUrl: env.baseUrl,
//     );
//   }


// }
