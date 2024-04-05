import 'package:krishi_hub/feature/auth/resource/auth_repository.dart';

import '../../../http/api_provider.dart';

class TraningApiProvider {
  final String baseUrl;
  final ApiProvider apiProvider;
  final AuthRepository authRepository;

  TraningApiProvider({
    required this.baseUrl,
    required this.apiProvider,
    required this.authRepository,
  });

  Future<dynamic> getTraning({
    required int currentPage,
    String searchSlug = "",
  }) async {
    final Map<String, dynamic> param = {
      "page": currentPage.toString(),
      "perpage": "20",
      "search": searchSlug,
    };
    Uri uri = Uri.parse("$baseUrl/training");
    uri = uri.replace(queryParameters: param);
    return await apiProvider.get(
      uri,
      token: authRepository.accessToken,
    );
  }

  Future<dynamic> applyTraning({required Map<String, dynamic> body}) async {
    final url = "$baseUrl/training/apply";
    return await apiProvider.post(
      url,
      body,
      token: authRepository.accessToken,
    );
  }

  Future<dynamic> getTrainingDetails(String id) async {
    Uri uri = Uri.parse("$baseUrl/training/$id");
    return await apiProvider.get(
      uri,
      token: authRepository.accessToken,
    );
  }
}
