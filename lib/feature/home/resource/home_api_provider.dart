// import 'package:metro_appointment_user/common/http/api_provider.dart';
// import 'package:metro_appointment_user/feature/auth/resource/auth_repository.dart';

import 'package:krishi_hub/http/api_provider.dart';

class HomeApiProvider {
  final ApiProvider apiProvider;
  final String baseUrl;
  // final AuthRepository authRepository;

  HomeApiProvider({
    required this.apiProvider,
    required this.baseUrl,
    // required this.authRepository,
  });

  Future<dynamic> getAdminStatus() async {
    Uri uri = Uri.parse("$baseUrl/auth/admin-status");

    return await apiProvider.get(
      uri,
      // token: authRepository.accessToken,
    );
  }

  Future<dynamic> deviceConfig(Map<String, dynamic> body) async {
    final uri = "$baseUrl/device-config";

    return apiProvider.post(uri, body);
  }
}
