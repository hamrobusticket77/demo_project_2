import 'package:krishi_hub/common/constant/env.dart';
import 'package:krishi_hub/common/response/response.dart';
import 'package:krishi_hub/common/utils/log.dart';
import 'package:krishi_hub/feature/auth/resource/auth_repository.dart';
import 'package:krishi_hub/feature/crop_care/model/doctor_record_model.dart';
import 'package:krishi_hub/feature/expertise/resources/all_expertise_repository.dart';
import 'package:krishi_hub/feature/expertise/resources/expertise_api_provider.dart';
import 'package:krishi_hub/http/api_provider.dart';

class ExpertiseRepository {
  final Env env;
  final ApiProvider apiProvider;
  late ExpertiseApiProvider expertiseApiProvider;
  final AuthRepository authRepository;
  final AllExpertiseRepository allExpertiseRepository;
  ExpertiseRepository({
    required this.env,
    required this.apiProvider,
    required this.authRepository,
    required this.allExpertiseRepository,
  }) {
    expertiseApiProvider = ExpertiseApiProvider(
      apiProvider: apiProvider,
      authRepository: authRepository,
      globalUrl: env.globalBaseUrl,
    );
  }

  int _currentPage = 1;
  int _totalPage = 0;
  final List<String> _items = [];

  List<String> get getItems => _items;
  Future<DataResponse<List<String>>> getExpertise({
    bool isLoadMore = false,
    String searchSlug = "",
    String? type,
    String? category,
  }) async {
    List<DoctorRecordModel> temp = [];

    try {
      if (isLoadMore) {
        if (_currentPage == _totalPage) {
          return DataResponse.success(_items);
        }
        _currentPage++;
      }
      if (!isLoadMore) {
        _items.clear();
        _currentPage = 1;
        _totalPage = 0;
      }
      final res = await expertiseApiProvider.expertise(
        currentPage: _currentPage,
        searchSlug: searchSlug,
        type: type,
        category: category,
      );

      temp = List.from(res['data']?['data']?['data'] ?? [])
          .map((e) => DoctorRecordModel.fromMap(e))
          .toList();
      _currentPage = res['pagination']?['currentPage'] ?? _currentPage;
      _totalPage = res['pagination']?['totalPages'] ?? _totalPage;

      for (int i = 0; i < temp.length; i++) {
        allExpertiseRepository.addAll({temp[i].id: temp[i]});
        _items.add(temp[i].id);
      }

      return DataResponse.success(_items);
    } catch (e) {
      Log.e(e);
      if (isLoadMore) {
        _currentPage--;
      }

      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<DoctorRecordModel>> getExpertiseDetail(
      {required String id}) async {
    try {
      final res = await expertiseApiProvider.getExpertiseDetail(id: id);

      DoctorRecordModel temp = DoctorRecordModel.fromMap(res['data']?['data']);

      return DataResponse.success(temp);
    } catch (e) {
      Log.e(e);

      return DataResponse.error(e.toString());
    }
  }
}
