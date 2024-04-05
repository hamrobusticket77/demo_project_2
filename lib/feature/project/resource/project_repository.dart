import 'package:krishi_hub/common/constant/env.dart';
import 'package:krishi_hub/common/model/fiscal_year.dart';
import 'package:krishi_hub/common/utils/log.dart';
import 'package:krishi_hub/feature/auth/resource/auth_repository.dart';
import 'package:krishi_hub/feature/project/model/plan_service_model.dart';
import 'package:krishi_hub/feature/project/model/program_model.dart';
import 'package:krishi_hub/feature/project/model/project_model.dart';
import 'package:krishi_hub/feature/project/model/seed_category_model.dart';
import 'package:krishi_hub/feature/project/resource/all_fiscal_year_repository.dart';
import 'package:krishi_hub/feature/project/resource/all_plan_Service_repository.dart';
import 'package:krishi_hub/feature/project/resource/all_program_repository.dart';
import 'package:krishi_hub/feature/project/resource/all_project_repository.dart';
import 'package:krishi_hub/feature/project/resource/all_seed_category_repository.dart';
import 'package:krishi_hub/feature/project/resource/project_api_provider.dart';
import 'package:krishi_hub/http/api_provider.dart';
import 'package:krishi_hub/common/response/response.dart';

class ProjectRepository {
  final Env env;
  final AuthRepository authRepository;
  late ProjectApiProvider projectApiProvider;

  final ApiProvider apiProvider;
  final AllFiscalYearRepository allFiscalYearRepository;

  final AllProgramRepository allProgramRepository;
  final AllProjectRepository allProjectRepository;
  final AllPlanServiceRepository allPlanRepository;
  final AllSeedCategoryRepository allSeedCategoryRepository;

  ProjectRepository(
      {required this.env,
      required this.authRepository,
      required this.apiProvider,
      required this.allFiscalYearRepository,
      required this.allProgramRepository,
      required this.allProjectRepository,
      required this.allSeedCategoryRepository,
      required this.allPlanRepository}) {
    projectApiProvider = ProjectApiProvider(
        apiProvider: apiProvider,
        baseUrl: env.baseUrl,
        authRepository: authRepository);
  }

  int _currentPage = 1;
  int _totalPage = 0;
  final List<String> _items = [];
  List<String> get getItems => _items;

  Future<DataResponse<List<String>>> getFiscalYear(
      {bool isLoadMore = false}) async {
    List<FiscalYear> temp = [];
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

      final res = await projectApiProvider.getFiscalYear(
        searchSlug: "",
        currentPage: _currentPage,
      );

      temp = List.from(res['data']?['data']?['data'] ?? [])
          .map((e) => FiscalYear.fromMap(e))
          .toList();
      _currentPage =
          res['data']?['data']?['pagination']?['currentPage'] ?? _currentPage;
      _totalPage =
          res['data']?['data']?['pagination']?['totalPages'] ?? _totalPage;

      for (int i = 0; i < temp.length; i++) {
        allFiscalYearRepository.addAll({temp[i].id: temp[i]});
        _items.add(temp[i].id);
      }

      return DataResponse.success(_items);
    } on Exception catch (e, s) {
      if (isLoadMore) {
        _currentPage--;
      }
      Log.e(e);
      Log.d(s);

      return DataResponse.error(e.toString());
    } catch (e, s) {
      Log.e(e);
      Log.d(s);

      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<List<String>>> getProgram({
    bool isLoadMore = false,
    required String fiscalYearId,
  }) async {
    List<ProgramModel> temp = [];
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

      final res = await projectApiProvider.getProgram(
          searchSlug: "",
          currentPage: _currentPage,
          fiscalYearId: fiscalYearId);

      temp = List.from(res['data']?['data']?['data'] ?? [])
          .map((e) => ProgramModel.fromMap(e))
          .toList();
      _currentPage = res['pagination']?['currentPage'] ?? _currentPage;
      _totalPage = res['pagination']?['totalPages'] ?? _totalPage;

      for (int i = 0; i < temp.length; i++) {
        allProgramRepository.addAll({temp[i].id: temp[i]});
        _items.add(temp[i].id);
      }

      return DataResponse.success(_items);
    } on Exception catch (e, s) {
      Log.e(e);
      Log.d(s);
      if (isLoadMore) {
        _currentPage--;
      }

      return DataResponse.error(e.toString());
    } catch (e) {
      if (isLoadMore) {
        _currentPage--;
      }

      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<List<String>>> getProject({
    bool isLoadMore = false,
    required String programId,
  }) async {
    List<ProjectModel> temp = [];
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

      final res = await projectApiProvider.getProject(
        searchSlug: "",
        currentPage: _currentPage,
        programId: programId,
      );

      temp = List.from(res['data']?['data']?['data'] ?? [])
          .map((e) => ProjectModel.fromMap(e))
          .toList();
      _currentPage = res['pagination']?['currentPage'] ?? _currentPage;
      _totalPage = res['pagination']?['totalPages'] ?? _totalPage;

      for (int i = 0; i < temp.length; i++) {
        allProjectRepository.addAll({temp[i].id: temp[i]});
        _items.add(temp[i].id);
      }

      return DataResponse.success(_items);
    } on Exception catch (e, s) {
      Log.e(e);
      Log.d(s);
      if (isLoadMore) {
        _currentPage--;
      }

      return DataResponse.error(e.toString());
    } catch (e, s) {
      Log.e(e);
      Log.d(s);
      if (isLoadMore) {
        _currentPage--;
      }
      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<List<String>>> getPlaningService({
    bool isLoadMore = false,
    required String projectId,
  }) async {
    List<PlanServiceModel> temp = [];
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

      final res = await projectApiProvider.getPlaningService(
        searchSlug: "",
        currentPage: _currentPage,
        projectId: projectId,
      );

      temp = List.from(res['data']?['data']?['data'] ?? [])
          .map((e) => PlanServiceModel.fromMap(e))
          .toList();
      _currentPage = res['pagination']?['currentPage'] ?? _currentPage;
      _totalPage = res['pagination']?['totalPages'] ?? _totalPage;

      for (int i = 0; i < temp.length; i++) {
        allPlanRepository.addAll({temp[i].id: temp[i]});
        _items.add(temp[i].id);
      }

      return DataResponse.success(_items);
    } on Exception catch (e, s) {
      Log.e(e);
      Log.d(s);
      if (isLoadMore) {
        _currentPage--;
      }

      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<List<String>>> getSeedCategory({
    bool isLoadMore = false,
  }) async {
    List<SeedCategoryModel> temp = [];
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

      final res = await projectApiProvider.getSeedCategory(
        searchSlug: "",
        currentPage: _currentPage,
      );

      temp = List.from(res['data']?['data']?['data'] ?? [])
          .map((e) => SeedCategoryModel.fromMap(e))
          .toList();
      _currentPage = res['pagination']?['currentPage'] ?? _currentPage;
      _totalPage = res['pagination']?['totalPages'] ?? _totalPage;

      for (int i = 0; i < temp.length; i++) {
        allSeedCategoryRepository.addAll({temp[i].id: temp[i]});
        _items.add(temp[i].id);
      }

      return DataResponse.success(_items);
    } on Exception catch (e, s) {
      Log.e(e);
      Log.d(s);
      if (isLoadMore) {
        _currentPage--;
      }

      return DataResponse.error(e.toString());
    } catch (e, s) {
      Log.e(e);
      Log.d(s);
      if (isLoadMore) {
        _currentPage--;
      }

      return DataResponse.error(e.toString());
    }
  }

  Future<DataResponse<FiscalYear>> getCurrentFiscalYear(
      {bool isLoadMore = false}) async {
    try {
      FiscalYear? temp;
      final res = await projectApiProvider.getCurrentFiscalYear();

      temp = FiscalYear.fromMap(res['data']?['data'] ?? {});
      return DataResponse.success(temp);
    } on Exception catch (e, s) {
      Log.e(e);
      Log.d(s);

      return DataResponse.error(e.toString());
    } catch (e, s) {
      Log.e(e);
      Log.d(s);

      return DataResponse.error(e.toString());
    }
  }
}
