import 'dart:io';

import 'package:dio/dio.dart';
import 'package:krishi_hub/common/constant/env.dart';
import 'package:krishi_hub/common/utils/log.dart';
import 'package:krishi_hub/feature/auth/resource/auth_repository.dart';
import 'package:krishi_hub/feature/media/resource/media_api_provider.dart';
import 'package:krishi_hub/http/api_provider.dart';
import 'package:krishi_hub/http/custom_exception.dart';

class MediaRepository {
  final Env env;
  final ApiProvider apiProvider;
  late MediaApiProvider mediaApiProvider;
  final AuthRepository authRepository;

  MediaRepository({
    required this.apiProvider,
    required this.env,
    required this.authRepository,
  }) {
    mediaApiProvider = MediaApiProvider(
      baseUrl: env.baseUrl,
      apiProvider: apiProvider,
      authRepository: authRepository,
    );
  }

  Future<String> mediaUpload(
      {required List<File> file, required String relatedTo}) async {
    try {
      FormData formData = FormData();
      for (var value in file) {
        formData.files.add(MapEntry(
            "file",
            await MultipartFile.fromFile(
              value.path,
              filename: value.path.split('/').last,
            )));
      }

      formData.fields.add(MapEntry("relatedTo", relatedTo));

      // formData = FormData.fromMap(data);

      final res = await mediaApiProvider.mediaUpload(formData);

      final id = res['data']?['data']?['id'] ?? 0;
      return id.toString();
    } catch (e, s) {
      Log.e(e);
      Log.d(s);

      rethrow;
    }
  }

  Future<String> mediaUpdate({
    required List<File> file,
    List<String>? deletedMedia,
    required int mediaId,
    required String relatedTo,
  }) async {
    try {
      var formData = FormData();

      for (var value in file) {
        formData.files.add(MapEntry(
            "file",
            await MultipartFile.fromFile(
              value.path,
              filename: value.path.split('/').last,
            )));
      }

      formData.fields.addAll([
        MapEntry("relatedTo", relatedTo),
        MapEntry("id", mediaId.toString())
      ]);

      if (deletedMedia != null) {
        formData.fields.add(MapEntry("deleteMediaId", deletedMedia.join(",")));
      }

      final res = await mediaApiProvider.updateMedia(formData);

      final id = res['data']?['data']?['id'] ?? 0;
      return id.toString();
    } catch (e, s) {
      Log.e(e);
      Log.d(s);

      rethrow;
    }
  }

  Future<List<String>> mediaUploadWithMediaROute(
      {required List<File> file, required String relatedTo}) async {
    try {
      var formData = FormData();

      for (var value in file) {
        formData.files.add(MapEntry(
            "file",
            await MultipartFile.fromFile(
              value.path,
              filename: value.path.split('/').last,
            )));
      }

      formData.fields.add(MapEntry("relatedTo", relatedTo));

      final res = await mediaApiProvider.mediaUploadWithMediaROute(formData);

      List<Map<String, dynamic>> list = List.from(res['data']?['data'] ?? [])
          .map((e) => e as Map<String, dynamic>)
          .toList();

      if (list.isNotEmpty) {
        List<String> id = [];

        for (var value in list) {
          id.add(value['id']);
        }
        return id;
      } else {
        throw CustomException("media id not found");
      }
    } catch (e, s) {
      Log.e(e);
      Log.d(s);

      rethrow;
    }
  }
}
