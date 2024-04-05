import 'package:krishi_hub/feature/auth/resource/auth_repository.dart';
import 'package:krishi_hub/http/api_provider.dart';

class CropApiProvider {
  final String baseUrl;
  final AuthRepository authRepository;
  final ApiProvider apiProvider;

  CropApiProvider({
    required this.baseUrl,
    required this.authRepository,
    required this.apiProvider,
  });

  // https://krishihub.cliffbyte.com/api/v1/agriculture/agriculture/type/all

  Future<dynamic> getAllCropCategories() async {
    Uri uri =
        Uri.parse("$baseUrl/agriculture/farmer-crops-information/crops-type");
    final Map<String, dynamic> param = {
      "page": "1",
      "perpage": "50",
      "search": "",
    };
    uri = uri.replace(queryParameters: param);
    return await apiProvider.get(
      uri,
      token: authRepository.accessToken,
    );
  }

  Future<dynamic> getCropByCategoryId(int id) async {
    Uri uri = Uri.parse(
        "$baseUrl/agriculture/farmer-crops-information/crops-type/$id");

    final Map<String, dynamic> param = {
      "page": "1",
      "perpage": "50",
      "search": "",
    };
    uri = uri.replace(queryParameters: param);

    return await apiProvider.get(
      uri,
      token: authRepository.accessToken,
    );
  }
}
