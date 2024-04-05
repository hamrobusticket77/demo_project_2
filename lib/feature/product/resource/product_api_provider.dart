import 'package:krishi_hub/feature/auth/resource/auth_repository.dart';

import '../../../http/api_provider.dart';

class ProductApiProvider {
  final String baseUrl;
  final String globalBaseUrl;
  final ApiProvider apiProvider;
  final AuthRepository authRepository;

  ProductApiProvider(
      {required this.baseUrl,
      required this.apiProvider,
      required this.authRepository,
      required this.globalBaseUrl});

  Future<dynamic> getProduct({
    required int currentPage,
    String searchSlug = "",
  }) async {
    final Map<String, dynamic> param = {
      "page": currentPage.toString(),
      "perpage": "20",
      "search": searchSlug,
    };
    Uri uri = Uri.parse("$baseUrl/product");
    uri = uri.replace(queryParameters: param);
    return await apiProvider.get(
      uri,
      token: authRepository.accessToken,
    );
  }

  Future<dynamic> createProduct({required Map<String, dynamic> body}) async {
    final url = "$baseUrl/product";
    return await apiProvider.post(
      url,
      body,
      token: authRepository.accessToken,
    );
  }

  Future<dynamic> updateProduct({required Map<String, dynamic> body}) async {
    final url = "$baseUrl/product";
    return await apiProvider.patch(
      url,
      body,
      token: authRepository.accessToken,
    );
  }

  Future<dynamic> deleteProduct(String id) async {
    // final url = "$baseUrl/product/$id";

    Uri uri = Uri.parse("$baseUrl/product/$id");
    return await apiProvider.delete(
      uri,
      token: authRepository.accessToken,
    );
  }

  Future<dynamic> getProductDetails(String id) async {
    Uri uri = Uri.parse("$baseUrl/training/$id");
    return await apiProvider.get(
      uri,
      token: authRepository.accessToken,
    );
  }

  Future<dynamic> getProductCategoryList(String type) async {
    final Map<String, dynamic> param = {'type': type};

    Uri uri = Uri.parse("$globalBaseUrl/product-category/list");
    uri = uri.replace(queryParameters: param);

    return await apiProvider.get(
      uri,
      globalBaseUrl: globalBaseUrl,
    );
  }

  Future<dynamic> getProductByCategoryType(String categoryType) async {
    final Map<String, dynamic> param = {'category': categoryType};

    Uri uri = Uri.parse("$globalBaseUrl/product/list");
    uri = uri.replace(queryParameters: param);

    return await apiProvider.get(
      uri,
      globalBaseUrl: globalBaseUrl,
    );
  }
}
