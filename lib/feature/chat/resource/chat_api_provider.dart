import 'package:krishi_hub/feature/auth/resource/auth_repository.dart';
import 'package:krishi_hub/http/api_provider.dart';

class ChatApiProvider {
  final AuthRepository authRepository;

  final ApiProvider apiProvider;
  final String baseUrl;

  ChatApiProvider({
    required this.authRepository,
    required this.apiProvider,
    required this.baseUrl,
  });



    


}
