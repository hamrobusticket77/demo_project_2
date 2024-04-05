import '../../../http/api_provider.dart';

class DownloadApiProvider {
  final String baseUrl;
  final ApiProvider apiProvider;

  DownloadApiProvider({
    required this.baseUrl,
    required this.apiProvider,
  });

  Future<dynamic> getdownloadpdf({required int currentPage}) async {
    final Map<String, dynamic> param = {
      "page": currentPage.toString(),
      "perpage": "20",
      "search":"",
    };
    Uri uri = Uri.parse("$baseUrl/resource");
    uri = uri.replace(queryParameters: param);
    return await apiProvider.get(
      uri,
    );
  }
}
