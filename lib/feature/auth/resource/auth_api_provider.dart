import 'package:krishi_hub/http/api_provider.dart';

class AuthApiProvider {
  final String baseUrl;
  final ApiProvider apiProvider;

  AuthApiProvider({required this.baseUrl, required this.apiProvider});

  Future<dynamic> login({required Map<String, String> body}) async {
    final uri = "$baseUrl/auth/farmer-login";

    return await apiProvider.post(uri, body);
  }

  Future<dynamic> updatePassword(
      {required Map<String, String> body, required String token}) async {
    final uri = "$baseUrl/auth/update-password";

    return await apiProvider.patch(
      uri,
      body,
      token: token,
    );
  }

  Future<dynamic> farmerRequest(Map<String, dynamic> body) async {
    final uri = "$baseUrl/farmer-registration-request";
    return await apiProvider.post(uri, body);
  }

  Future<dynamic> logout(
      {required Map<String, dynamic> body, required String token}) async {
    final uri = "$baseUrl/auth/farmer-logout";
    return await apiProvider.post(uri, body, token: token);
  }

  Future<dynamic> getUserDetails(String token) async {
    Uri uri = Uri.parse("$baseUrl/analytics/farmer-analytics");

    return await apiProvider.get(uri, token: token);
  }

  Future<dynamic> deleteUser({
    required String phoneNumber,
    required String password,
    required String reasonToDelete,
    required String accessToken,
    required String userId,
  }) async {
    Map<String, dynamic> param = {
      "phoneNumber": phoneNumber,
      "password": password,
      "reasonToDelete": reasonToDelete,
    };
    Uri uri = Uri.parse("$baseUrl/auth/delete-account/$userId");

    uri = uri.replace(queryParameters: param);

    return await apiProvider.delete(
      uri,
      token: accessToken,
    );
  }
}
