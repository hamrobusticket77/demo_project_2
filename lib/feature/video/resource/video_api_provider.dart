import '../../../http/api_provider.dart';

class VideoApiProvider {
  final String baseUrl;
  final ApiProvider apiProvider;

  VideoApiProvider({
    required this.baseUrl,
    required this.apiProvider,
  });

  Future<dynamic> getvideo({required int currentPage}) async {
    final Map<String, dynamic> param = {
      "page": currentPage.toString(),
      "perpage": "20",
      "search":"",
    };
    Uri uri = Uri.parse("$baseUrl/agriculture/video");
    uri = uri.replace(queryParameters: param);
    return await apiProvider.get(
      uri,
    );
  }
}
