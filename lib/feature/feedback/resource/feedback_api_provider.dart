import 'package:krishi_hub/feature/auth/resource/auth_repository.dart';
import 'package:krishi_hub/http/api_provider.dart';

class FeedbackApiProvider {
  final String baseUrl;
  final ApiProvider apiProvider;
  final AuthRepository authRepository;

  FeedbackApiProvider({
    required this.baseUrl,
    required this.apiProvider,
    required this.authRepository,
  });

  Future<dynamic> sendfeedback({required Map<String, dynamic> body}) async {
    final url = "$baseUrl/feedback";
    return await apiProvider.post(
      url,
      body,
      token: authRepository.accessToken,
    );
  }

  Future<dynamic> getfeedbacklist({required int currentPage}) async {
    final Map<String, dynamic> param = {
      "page": currentPage.toString(),
      "perpage": "20",
      "search": "",
    };
    Uri uri = Uri.parse("$baseUrl/feedback");
    uri = uri.replace(queryParameters: param);

    // await authRepository.fetchAccessToken();
    return await apiProvider.get(
      uri,
      token: authRepository.accessToken,
    );
  }

  Future<dynamic> deleteFeedback({required String id}) async {
    Uri uri = Uri.parse("$baseUrl/feedback/$id");

    return apiProvider.delete(
      uri,
      token: authRepository.accessToken,
    );
  }
}
