import 'package:krishi_hub/common/enum/environment.dart';

class Env {
  final String baseUrl;
  final String socketUrl;
  final Environment environment;
  final String globalBaseUrl;
  final String weatherApiKey;

  Env({
    required this.baseUrl,
    required this.socketUrl,
    required this.environment,
    required this.globalBaseUrl,
    required this.weatherApiKey,
  });
}

class EnvValue {
  static final Env development = Env(
    // baseUrl: "https://test.krishihub.cliffbyte.com/api/v1",
    baseUrl: "http://192.168.1.97:4001/api/v1",
    socketUrl: "wss://krishihub.cliffbyte.com",
    environment: Environment.krishihub(),
    globalBaseUrl: "https://global.krishiportal.cliffbyte.com/api/v1",
    weatherApiKey: "eb4eccdcfff6f80455c1364f8161e338",
  );

  static final Env production = Env(
    baseUrl: "https://krishihub.cliffbyte.com/api/v1",
    socketUrl: "wss://krishihub.cliffbyte.com",
    environment: Environment.krishihub(),
    globalBaseUrl: "https://global.krishiportal.cliffbyte.com/api/v1",
    weatherApiKey: "eb4eccdcfff6f80455c1364f8161e338",
  );

  static final Env benighat = Env(
    baseUrl: "https://ag.benighatrorangmun.gov.np/api/v1",
    socketUrl: "wss:/ag.benighatrorangmun.gov.np",
    environment: Environment.benighat(),
    globalBaseUrl: "https://global.krishiportal.cliffbyte.com/api/v1",
    weatherApiKey: "eb4eccdcfff6f80455c1364f8161e338",
  );

  static final Env krishihub = Env(
    baseUrl: "https://krishihub.cliffbyte.com/api/v1",
    socketUrl: "wss://krishihub.cliffbyte.com",
    environment: Environment.krishihub(),
    globalBaseUrl: "https://global.krishiportal.cliffbyte.com/api/v1",
    weatherApiKey: "eb4eccdcfff6f80455c1364f8161e338",
  );
}
