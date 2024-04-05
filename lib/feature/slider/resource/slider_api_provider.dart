import '../../../http/api_provider.dart';

class SliderApiProvider {
  final String baseUrl;
  final ApiProvider apiProvider;

  SliderApiProvider({
    required this.baseUrl,
    required this.apiProvider,
  });

  Future<dynamic> getSlider({required int currentPage}) async {
    final Map<String, dynamic> param = {
      "page": currentPage.toString(),
      "perpage": "100",
      "search":" ",
    };
    Uri uri = Uri.parse("$baseUrl/agriculture/carousel");
    uri = uri.replace(queryParameters: param);
    return await apiProvider.get(
      uri,
    );
  }
}
