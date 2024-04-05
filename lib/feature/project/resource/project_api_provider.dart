import 'package:krishi_hub/feature/auth/resource/auth_repository.dart';
import 'package:krishi_hub/http/api_provider.dart';

class ProjectApiProvider {
  final String baseUrl;
  final AuthRepository authRepository;
  final ApiProvider apiProvider;

  ProjectApiProvider({
    required this.baseUrl,
    required this.authRepository,
    required this.apiProvider,
  });

  Future<dynamic> getFiscalYear(
      {required int currentPage, String? searchSlug}) {
    Uri uri = Uri.parse("$baseUrl/fiscal-year");

    final param = {
      "perpage": "100",
      "page": currentPage.toString(),
      "search": searchSlug ?? " ",
    };

    uri = uri.replace(queryParameters: param);
    return apiProvider.get(
      uri,
    );
  }

  Future<dynamic> getProgram(
      {required int currentPage,
      String? searchSlug,
      required String fiscalYearId}) {
    Uri uri = Uri.parse("$baseUrl/agriculture-plan/program");

    final param = {
      "perpage": "100",
      "page": currentPage.toString(),
      "search": searchSlug ?? " ",
      "fiscalYear": fiscalYearId,
    };

    uri = uri.replace(queryParameters: param);
    return apiProvider.get(
      uri,
    );
  }

  Future<dynamic> getProject(
      {required int currentPage,
      String? searchSlug,
      required String programId}) {
    Uri uri = Uri.parse("$baseUrl/agriculture-plan/project");

    final param = {
      "perpage": "100",
      "page": currentPage.toString(),
      "search": searchSlug ?? " ",
      "program": programId,
    };

    uri = uri.replace(queryParameters: param);
    return apiProvider.get(
      uri,
    );
  }

  getPlaningService({
    required int currentPage,
    String? searchSlug,
    required String projectId,
  }) {
    Uri uri = Uri.parse("$baseUrl/agriculture-plan/service");

    final param = {
      "perpage": "100",
      "page": currentPage.toString(),
      "search": searchSlug ?? " ",
      "project": projectId,
    };

    uri = uri.replace(queryParameters: param);
    return apiProvider.get(
      uri,
    );
  }

  getSeedCategory({
    required int currentPage,
    String? searchSlug,
  }) {
    Uri uri = Uri.parse("$baseUrl/seed-demand/seedcategory");

    final param = {
      "perpage": "100",
      "page": currentPage.toString(),
      "search": searchSlug ?? " ",
    };

    uri = uri.replace(queryParameters: param);
    return apiProvider.get(
      uri,
    );
  }

  Future<dynamic> getCurrentFiscalYear() {
    Uri uri = Uri.parse("$baseUrl/fiscal-year/current");

    return apiProvider.get(
      uri,
    );
  }

  // getSeedName(
  //     {required int currentPage,
  //     String? searchSlug,
  //     required String seedCategoryId}) {
  //   Uri uri = Uri.parse("$baseUrl/seed-demand/seedcategory/$seedCategoryId");

  //   return apiProvider.get(
  //     uri,
  //   );
  // }
}
