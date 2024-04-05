import '../../../http/api_provider.dart';

class EmployeeApiProvider {
  final String baseUrl;
  final ApiProvider apiProvider;

  EmployeeApiProvider({
    required this.baseUrl,
    required this.apiProvider,
  });

  Future<dynamic> getemployeelist({required int currentPage}) async {
    final Map<String, dynamic> param = {
      "page": currentPage.toString(),
      "perpage": "20",
      "search": "",
    };
    Uri uri = Uri.parse("$baseUrl/employee");
    uri = uri.replace(queryParameters: param);
    return await apiProvider.get(
      uri,
    );
  }

  Future<dynamic> getelectiverepresentivelist(
      {required int currentPage}) async {
    final Map<String, dynamic> param = {
      "page": currentPage.toString(),
      "perpage": "20",
      "search": "",
    };
    Uri uri = Uri.parse("$baseUrl/official");
    uri = uri.replace(queryParameters: param);
    return await apiProvider.get(
      uri,
    );
  }
}
