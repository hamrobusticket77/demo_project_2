import '../../../http/api_provider.dart';

class FaqApiProvider {
  final String baseUrl;
  final ApiProvider apiProvider;

  FaqApiProvider({
    required this.baseUrl,
    required this.apiProvider,
  });

  Future<dynamic> getFaq({required int currentPage}) async {
    final Map<String, dynamic> param = {
      "page": currentPage.toString(),
      "perpage": "20",
      "search":"",
    };
    Uri uri = Uri.parse("$baseUrl/faq");
    uri = uri.replace(queryParameters: param);
    return await apiProvider.get(
      uri,
    );
  }
}
