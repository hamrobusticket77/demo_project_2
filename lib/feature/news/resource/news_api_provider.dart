import '../../../http/api_provider.dart';

class NewsApiProvider {
  final String baseUrl;
  final ApiProvider apiProvider;
  final String globalUrl;
  NewsApiProvider({
    required this.baseUrl,
    required this.apiProvider,
    required this.globalUrl,
  });

  Future<dynamic> getNews({required int currentPage}) async {
    final Map<String, dynamic> param = {
      "page": currentPage.toString(),
      "perpage": "20",
      "search": "",
    };
    Uri uri = Uri.parse("$baseUrl/agriculture/news");
    uri = uri.replace(queryParameters: param);
    return await apiProvider.get(
      uri,
    );
  }

  Future<dynamic> getReferenceContent(
      {required int currentPage, required String search}) async {
    final Map<String, dynamic> param = {
      "page": currentPage.toString(),
      "perPage": "10",
      "search": search
    };

    Uri uri = Uri.parse("$globalUrl/reference-content");
    uri = uri.replace(queryParameters: param);
    return await apiProvider.get(
      uri,
      globalBaseUrl: globalUrl,
    );
  }

  Future<dynamic> getReferenceById({required String id}) async {
    Uri uri = Uri.parse("$globalUrl/reference-content/$id");
    return await apiProvider.get(
      uri,
      globalBaseUrl: globalUrl,
    );
  }
}
