import 'package:krishi_hub/feature/auth/resource/auth_repository.dart';
import 'package:krishi_hub/http/api_provider.dart';

class CallCenterApiProvider {
  final String baseUrl;
  final ApiProvider apiProvider;
  final AuthRepository authRepository;
  CallCenterApiProvider({
    required this.baseUrl,
    required this.apiProvider,
    required this.authRepository,
  });

  getofficesetupList() async {
    Uri uri = Uri.parse("$baseUrl/office-setup");

    uri = uri.replace();

    return apiProvider.get(
      uri,
    );
  }

  Future<dynamic> getanswerquestionlist({required int currentPage}) async {
    final Map<String, dynamic> param = {
      "page": currentPage.toString(),
      "perpage": "20",
      "search": "",
    };
    Uri uri = Uri.parse("$baseUrl/agriculture/call-center-qna");
    uri = uri.replace(queryParameters: param);

    await authRepository.fetchAccessToken();
    return await apiProvider.get(
      uri,
      token: authRepository.accessToken,
    );
  }
}
