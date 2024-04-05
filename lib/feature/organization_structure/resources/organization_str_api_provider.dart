import '../../../http/api_provider.dart';

class OrganizationApiProvider {
  final String baseUrl;
  final ApiProvider apiProvider;

  OrganizationApiProvider({
    required this.baseUrl,
    required this.apiProvider,
  });

  Future<dynamic> getOrganization({required int currentPage}) async {
    final Map<String, dynamic> param = {
      "page": currentPage.toString(),
      "perpage": "20",
      "search":"",
    };
    Uri uri = Uri.parse("$baseUrl/organizational-structure");
    uri = uri.replace(queryParameters: param);
    return await apiProvider.get(
      uri,
    );
  }
}
