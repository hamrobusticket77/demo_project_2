import 'package:dio/dio.dart';
import 'package:krishi_hub/feature/auth/resource/auth_repository.dart';
import 'package:krishi_hub/http/api_provider.dart';

class AgriculturePlanApiProvider {
  final String baseUrl;
  final AuthRepository authRepository;
  final ApiProvider apiProvider;

  AgriculturePlanApiProvider({
    required this.baseUrl,
    required this.apiProvider,
    required this.authRepository,
  });

  Future<dynamic> getagricultureplan({required int currentPage}) async {
    final Map<String, dynamic> param = {
      "page": currentPage.toString(),
      "perpage": "20",
      "search": "",
    };
    Uri uri = Uri.parse("$baseUrl/agriculture-plan/program-form");
    uri = uri.replace(queryParameters: param);

    return await apiProvider.get(
      uri,
      token: authRepository.accessToken,
    );
  }

  Future<dynamic> createAgriculturePlan(
      {required Map<String, dynamic> body}) async {
    final url = "$baseUrl/agriculture-plan/program-form";
    return await apiProvider.post(
      url,
      body,
      token: authRepository.accessToken,
    );
  }

  Future<dynamic> updateAgriculturePlan(
      {required Map<String, dynamic> body}) async {
    final url = "$baseUrl/agriculture-plan/program-form";
    return await apiProvider.patch(
      url,
      body,
      token: authRepository.accessToken,
    );
  }

  Future<dynamic> mediaUpload(FormData body) async {
    final uri = "$baseUrl/agriculture/media";

    return await apiProvider.post(
      uri,
      body,
      token: authRepository.accessToken,
    );
  }

  Future<dynamic> updateMedia(FormData body) async {
    final uri = "$baseUrl/agriculture/media";

    return await apiProvider.patch(
      uri,
      body,
      token: authRepository.accessToken,
    );
  }

  Future<dynamic> deleteAgriculturePlan({required String id}) async {
    Uri uri = Uri.parse("$baseUrl/agriculture-plan/program-form/$id");

    return apiProvider.delete(
      uri,
      token: authRepository.accessToken,
    );
  }
}
