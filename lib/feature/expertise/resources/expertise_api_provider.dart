import 'package:krishi_hub/feature/auth/resource/auth_repository.dart';
import 'package:krishi_hub/http/api_provider.dart';

class ExpertiseApiProvider {
  final ApiProvider apiProvider;
  final AuthRepository authRepository;
  final String globalUrl;

  ExpertiseApiProvider({
    required this.apiProvider,
    required this.authRepository,
    required this.globalUrl,
  });
  // A function that takes in the current page number and an optional search slug, and returns a Future<dynamic>
  // representing the expertise data fetched from the API.
  Future<dynamic> expertise({
    required int currentPage,
    String? type,
    String? category,
    String searchSlug = "",
  }) async {
    final Map<String, dynamic> param = {
      "page": currentPage.toString(),
      "perpage": "20",
      "search": searchSlug,
    };
    if (type != null && type.isNotEmpty) param['type'] = type;
    if (category != null && category.isNotEmpty) param['category'] = category;
    Uri uri = Uri.parse("$globalUrl/expertise");
    uri = uri.replace(queryParameters: param);
    return await apiProvider.get(
      uri,
    );
  }

  // Retrieves expertise details using the provided ID and returns a Future containing the expertise detail information.
  Future<dynamic> getExpertiseDetail({required String id}) async {
    Uri uri = Uri.parse("$globalUrl/expertise/$id");
    return await apiProvider.get(uri);
  }
}
