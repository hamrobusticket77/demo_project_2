import 'package:dio/dio.dart';
import 'package:krishi_hub/feature/auth/resource/auth_repository.dart';
import 'package:krishi_hub/http/api_provider.dart';

class MediaApiProvider {
  final String baseUrl;
  final ApiProvider apiProvider;
  final AuthRepository authRepository;

  MediaApiProvider({
    required this.baseUrl,
    required this.apiProvider,
    required this.authRepository,
  });

  Future<dynamic> mediaUpload(FormData body) async {
    final uri = "$baseUrl/agriculture/media";

    return await apiProvider.post(
      uri,
      body,
      token: authRepository.accessToken,
    );
  }

  Future<dynamic> mediaUploadWithMediaROute(FormData body) async {
    final uri = "$baseUrl/media";

    return await apiProvider.post(
      uri,
      body,
      token: authRepository.accessToken,
    );
  }

  Future<dynamic> updateMedia(FormData body) async {
    final uri = "$baseUrl/agriculture/media";

    return await apiProvider.patch(
      uri,
      body,
      token: authRepository.accessToken,
    );
  }
}
