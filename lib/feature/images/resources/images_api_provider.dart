import '../../../http/api_provider.dart';

class ImagesApiProvider {
  final String baseUrl;
  final ApiProvider apiProvider;

  ImagesApiProvider({
    required this.baseUrl,
    required this.apiProvider,
  });

  Future<dynamic> getImage(int id) async {
    final Map<String, dynamic> param = {};
    Uri uri = Uri.parse("$baseUrl/agriculture/image-gallery/album/$id");
    uri = uri.replace(queryParameters: param);
    return await apiProvider.get(
      uri,
    );
  }

  Future<dynamic> getAlbum({required int currentPage}) async {
    final Map<String, dynamic> param = {
      "page": currentPage.toString(),
      "perpage": "20",
      "search": "",
    };
    Uri uri = Uri.parse("$baseUrl/agriculture/image-album");
    uri = uri.replace(queryParameters: param);
    return await apiProvider.get(
      uri,
    );
  }
}
