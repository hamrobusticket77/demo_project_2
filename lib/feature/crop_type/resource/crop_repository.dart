import 'package:krishi_hub/common/constant/env.dart';
import 'package:krishi_hub/common/utils/log.dart';
import 'package:krishi_hub/feature/auth/resource/auth_repository.dart';
import 'package:krishi_hub/feature/crop_type/resource/crop_api_provider.dart';
import 'package:krishi_hub/feature/product/model/crop_type_model.dart';
import 'package:krishi_hub/http/api_provider.dart';
import 'package:krishi_hub/common/response/response.dart';

class CropRepository {
  final Env env;
  final AuthRepository authRepository;
  late CropApiProvider cropApiProvider;
  final ApiProvider apiProvider;

  CropRepository({
    required this.env,
    required this.authRepository,
    required this.apiProvider,
  }) {
    cropApiProvider = CropApiProvider(
        apiProvider: apiProvider,
        baseUrl: env.baseUrl,
        authRepository: authRepository);
  }

  Future<DataResponse<List<CropTypeModel>>> getAllCropCategories() async {
    List<CropTypeModel> temp = [];
    try {
      final res = await cropApiProvider.getAllCropCategories();

      temp = List.from(res['data']?['data']?['data'] ?? [])
          .map((e) => CropTypeModel.fromMap(e))
          .toList();

      return DataResponse.success(temp);
    } catch (e) {
      Log.e(e);

      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<List<CropTypeModel>>> getCropByCategoryId(
      int cropTypeId) async {
    List<CropTypeModel> temp = [];
    try {
      final res = await cropApiProvider.getCropByCategoryId(cropTypeId);

      temp = List.from(res['data']?['data']?['data'] ?? [])
          .map((e) => CropTypeModel.fromMap(e))
          .toList();

      return DataResponse.success(temp);
    } catch (e) {
      Log.e(e);

      return DataResponse.error(e.toString());
    }
  }
}
