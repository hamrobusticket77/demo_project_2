// import 'package:krishi_hub/http/api_provider.dart';

// class AuthApiProvider {
//   final String baseUrl;
//   final ApiProvider apiProvider;

//   AuthApiProvider({required this.baseUrl, required this.apiProvider});

//   Future<dynamic> login({required Map<String, String> body}) async {
//     final uri = "$baseUrl/auth/employee-login";

//     return await apiProvider.post(uri, body);
//   }

//   Future<dynamic> update({required Map<String, String> body}) async {
//     final uri =
//         "$baseUrl/agriculture/farmer-personal-information/update-password";

//     return await apiProvider.post(uri, body);
//   }
// }
