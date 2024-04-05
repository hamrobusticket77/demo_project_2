import 'package:krishi_hub/feature/auth/resource/auth_repository.dart';

import '../../../http/api_provider.dart';

class PhoneBookApiProvider {
  final String baseUrl;
  final ApiProvider apiProvider;
  final AuthRepository authRepository;
  final String globalUrl;

  PhoneBookApiProvider({
    required this.baseUrl,
    required this.apiProvider,
    required this.authRepository,
    required this.globalUrl,
  });

  Future<dynamic> getphoneBook({
    required int currentPage,
    String searchSlug = "",
  }) async {
    final Map<String, dynamic> param = {
      "page": currentPage.toString(),
      "perpage": "20",
      "search": searchSlug,
    };
    Uri uri = Uri.parse("$globalUrl/phone-diary/department");
    uri = uri.replace(queryParameters: param);
    return await apiProvider.get(
      uri,
      token:
          "eyJpZCI6Ijg2ZDEwYmQ5LTc0NWItNGMyNS03NDE5LWZhZTJjOGM0NTBhNSIsInJvbGUiOiJTVURPX0FETUlOIiwiaWF0IjoxNzEwNjQ5NzE5LCJleHAiOjE3MTA3MzYxMTl9",
    );
  }

  Future<dynamic> getOffice({
    required int currentPage,
    String searchSlug = "",
    required String id,
  }) async {
    final Map<String, dynamic> param = {
      "page": currentPage.toString(),
      "perpage": "20",
      "search": searchSlug,
      "department": id
    };
    Uri uri = Uri.parse("$globalUrl/phone-diary/office/");
    uri = uri.replace(queryParameters: param);
    return await apiProvider.get(uri,
        token:
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijg2ZDEwYmQ5LTc0NWItNGMyNS03NDE5LWZhZTJjOGM0NTBhNSIsInJvbGUiOiJTVURPX0FETUlOIiwiaWF0IjoxNzEwNzM1ODQ1LCJleHAiOjE3MTA4MjIyNDV9.QkFhpQg5bzSuV224zxPQcKIaMfLA4ou2gO_34WmlwAQ");
  }

  Future<dynamic> getofficeDetail({required String id}) async {
    Uri uri = Uri.parse("$globalUrl/phone-diary/office/$id");
    return await apiProvider.get(
      uri,
    );
  }

  Future<dynamic> getSuboffice({
    required int currentPage,
    String searchSlug = "",
    required String departement,
    required String office,
  }) async {
    final Map<String, dynamic> param = {
      "page": currentPage.toString(),
      "perpage": "20",
      "search": searchSlug,
      "office": office,
      "department": departement,
    };
    Uri uri = Uri.parse("$globalUrl/phone-diary/sub-office/");
    uri = uri.replace(queryParameters: param);
    return await apiProvider.get(uri,
        token:
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6Ijg2ZDEwYmQ5LTc0NWItNGMyNS03NDE5LWZhZTJjOGM0NTBhNSIsInJvbGUiOiJTVURPX0FETUlOIiwiaWF0IjoxNzEwNzM1ODQ1LCJleHAiOjE3MTA4MjIyNDV9.QkFhpQg5bzSuV224zxPQcKIaMfLA4ou2gO_34WmlwAQ");
  }

  Future<dynamic> getSubOfficeDetail({required String id}) async {
    Uri uri = Uri.parse("$globalUrl/phone-diary/sub-office/$id");
    return await apiProvider.get(
      uri,
    );
  }
}
