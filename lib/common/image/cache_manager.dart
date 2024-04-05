import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CustomCacheManager {
  static const key = "cache_key";

  static CacheManager instance = CacheManager(
    Config(
      key,
      stalePeriod: const Duration(days: 20),
      maxNrOfCacheObjects: 1000,
      repo: JsonCacheInfoRepository(databaseName: key),
      fileService: HttpFileService(),
    ),
  );
}
