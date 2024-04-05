import 'package:krishi_hub/feature/auth/resource/auth_repository.dart';
import 'package:krishi_hub/http/api_provider.dart';

class KrishiApiProvider {
  final String baseUrl;
  final ApiProvider apiProvider;
  final AuthRepository authRepository;
  final String globalurl;
  KrishiApiProvider({
    required this.baseUrl,
    required this.apiProvider,
    required this.authRepository,
    required this.globalurl,
  });

  Future<dynamic> getKrishi({required int currentPage}) async {
    final Map<String, dynamic> param = {
      "page": currentPage.toString(),
      "perpage": "5000",
      "search": "",
    };

    Uri uri = Uri.parse("$baseUrl/agriculture/agriculture/name/by-type");
    uri = uri.replace(queryParameters: param);
    return await apiProvider.get(
      uri,
    );
  }

  Future<dynamic> getAgricultureKnowledge(
      {required int currentPage, required String type}) async {
    final Map<String, dynamic> param = {
      "page": currentPage.toString(),
      "perpage": "20",
      "search": "",
      "type": type,
    };

    Uri uri = Uri.parse("$baseUrl/agriculture/agriculture/name/knowledge");
    uri = uri.replace(queryParameters: param);
    return await apiProvider.get(
      uri,
    );
  }

  Future<dynamic> getAgricultureKnowledgeDetail(int id,
      {required String type}) async {
    final Map<String, dynamic> param = {
      "perpage": "20",
      "search": "",
      "type": type,
    };

    Uri uri = Uri.parse("$baseUrl/agriculture/agriculture/name/$id");
    uri = uri.replace(queryParameters: param);
    return await apiProvider.get(
      uri,
    );
  }

  Future<dynamic> getAgricultureItem(int id) async {
    Uri uri = Uri.parse("$baseUrl/agriculture/agriculture/name/$id");
    return await apiProvider.get(
      uri,
    );
  }

  Future<dynamic> createDiseaseReport(
      {required Map<String, dynamic> body}) async {
    final url = "$baseUrl/disease";
    return await apiProvider.post(
      url,
      body,
      token: authRepository.accessToken,
    );
  }

  Future<dynamic> getDiseaseReportList({required int currentPage}) async {
    final Map<String, dynamic> param = {
      "page": currentPage.toString(),
      "perpage": "20",
    };
    Uri uri = Uri.parse("$baseUrl/disease");
    uri = uri.replace(queryParameters: param);
    return await apiProvider.get(
      uri,
      token: authRepository.accessToken,
    );
  }
}
