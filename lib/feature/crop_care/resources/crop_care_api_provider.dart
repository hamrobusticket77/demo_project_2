import 'package:krishi_hub/feature/auth/resource/auth_repository.dart';

import '../../../http/api_provider.dart';

class CropCareApiProvider {
  final String baseUrl;
  final ApiProvider apiProvider;
  final AuthRepository authRepository;
  final String globalUrl;

  CropCareApiProvider({
    required this.baseUrl,
    required this.apiProvider,
    required this.authRepository,
    required this.globalUrl,
  });

  // Future<dynamic> doctorRecord({
  //   required int currentPage,
  //   String searchSlug = "",
  // }) async {
  //   final Map<String, dynamic> param = {
  //     "page": currentPage.toString(),
  //     "perpage": "20",
  //     "search": searchSlug,
  //   };
  //   Uri uri = Uri.parse("$baseUrl/doctor");
  //   uri = uri.replace(queryParameters: param);
  //   return await apiProvider.get(
  //     uri,
  //     token: authRepository.accessToken,
  //   );
  // }

  Future<dynamic> doctorRecord({
    required int currentPage,
    String searchSlug = "",
    String? type,
    String? category,
  }) async {
    final Map<String, dynamic> param = {
      "page": currentPage.toString(),
      "perpage": "20",
      "search": searchSlug,
    };

    if (type != null && type.isNotEmpty) param['type'] = type;
    if (category != null && category.isNotEmpty) param['category'] = category;
    Uri uri = Uri.parse("$globalUrl/doctor");
    uri = uri.replace(queryParameters: param);
    return await apiProvider.get(
      uri,
    );
  }

  Future<dynamic> doctorRecordById({required String id}) async {
    Uri uri = Uri.parse("$globalUrl/doctor/$id");
    return await apiProvider.get(
      uri,
    );
  }

  Future<dynamic> fertilizerStore({
    required int currentPage,
    String searchSlug = "",
    required String storetype,
  }) async {
    final Map<String, dynamic> param = {
      "page": currentPage.toString(),
      "perpage": "20",
      "search": searchSlug,
      "storetype": storetype
    };
    Uri uri = Uri.parse("$globalUrl/store");
    uri = uri.replace(queryParameters: param);
    return await apiProvider.get(
      uri,
      token: authRepository.accessToken,
    );
  }

  Future<dynamic> fertilizerStoreById({required String id}) async {
    Uri uri = Uri.parse("$globalUrl/store/$id");
    return await apiProvider.get(
      uri,
    );
  }

  Future<dynamic> insuranceCenterDirectory({
    required int currentPage,
    String searchSlug = "",
  }) async {
    final Map<String, dynamic> param = {
      "page": currentPage.toString(),
      "perpage": "20",
      "search": searchSlug,
    };
    Uri uri = Uri.parse("$globalUrl/insurance");
    uri = uri.replace(queryParameters: param);
    return await apiProvider.get(
      uri,
    );
  }

  Future<dynamic> insuranceCenterDirectoryById({required String id}) async {
    Uri uri = Uri.parse("$globalUrl/insurance/$id");
    return await apiProvider.get(
      uri,
    );
  }

  Future<dynamic> agricultureEquipement({
    required int currentPage,
    String searchSlug = "",
  }) async {
    final Map<String, dynamic> param = {
      "page": currentPage.toString(),
      "perpage": "20",
      "search": searchSlug,
    };
    Uri uri = Uri.parse("$globalUrl/equipment");
    uri = uri.replace(queryParameters: param);
    return await apiProvider.get(
      uri,
    );
  }

  Future<dynamic> getAgricultureEquipmentByid({required String id}) async {
    Uri uri = Uri.parse("$globalUrl/equipment/$id");
    return await apiProvider.get(
      uri,
    );
  }
}
