import '../../../http/api_provider.dart';

class MissionApiProvider {
  final String baseUrl;
  final ApiProvider apiProvider;

  MissionApiProvider({
    required this.baseUrl,
    required this.apiProvider,
  });

  Future<dynamic> getMission({required int currentPage}) async {
    Uri uri = Uri.parse("$baseUrl/vision-and-mission");
    return await apiProvider.get(
      uri,
    );
  }
}
