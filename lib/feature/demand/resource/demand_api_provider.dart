import 'package:krishi_hub/feature/auth/resource/auth_repository.dart';
import 'package:krishi_hub/http/api_provider.dart';

class DemandApiProvider {
  final String baseUrl;
  final AuthRepository authRepository;
  final ApiProvider apiProvider;

  DemandApiProvider({
    required this.baseUrl,
    required this.authRepository,
    required this.apiProvider,
  });

  getDemand({required int currentPage, String? searchSlug}) {
    Uri uri = Uri.parse("$baseUrl/demand-config");

    final param = {
      "perpage": "20",
      "page": currentPage.toString(),
      "search": searchSlug ?? " ",
    };

    uri = uri.replace(queryParameters: param);
    return apiProvider.get(uri, token: authRepository.accessToken);
  }

  getDemandById(String id) {
    Uri uri = Uri.parse("$baseUrl/demand-config/$id");

    return apiProvider.get(
      uri,
      token: authRepository.accessToken,
    );
  }

  Future<dynamic> seedDemand({required Map<String, dynamic> body}) {
    final uri = "$baseUrl/seed-demand/demand";

    return apiProvider.post(
      uri,
      body,
      token: authRepository.accessToken,
    );
  }

  Future<dynamic> deleteDemand({required String id}) async {
    Uri uri = Uri.parse("$baseUrl/seed-demand/demand/$id");

    return apiProvider.delete(
      uri,
      token: authRepository.accessToken,
    );
  }

  Future<dynamic> updateDemand({required Map<String, dynamic> body}) {
    final uri = "$baseUrl/seed-demand/demand";

    return apiProvider.patch(
      uri,
      body,
      token: authRepository.accessToken,
    );
  }

  Future<dynamic> applyDemand({required Map<String, dynamic> body}) {
    final uri = "$baseUrl/demand-config/apply";

    return apiProvider.post(
      uri,
      body,
      token: authRepository.accessToken,
    );
  }

  getAppliedDemand({required int currentPage, String? searchSlug}) {
    Uri uri = Uri.parse("$baseUrl/demand-config/applied");

    final param = {
      "perpage": "20",
      "page": currentPage.toString(),
      "search": searchSlug ?? " ",
    };

    uri = uri.replace(queryParameters: param);
    return apiProvider.get(uri, token: authRepository.accessToken);
  }
}
