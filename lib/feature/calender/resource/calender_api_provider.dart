import 'package:krishi_hub/feature/auth/resource/auth_repository.dart';
import 'package:krishi_hub/http/api_provider.dart';

class CalenderApiProvider {
  final ApiProvider apiProvider;
  final String baseUrl;

  final AuthRepository authRepository;

  CalenderApiProvider({
    required this.apiProvider,
    required this.baseUrl,
    required this.authRepository,
  });

  // Future<dynamic> getCropType({required int currentPage}) async {
  //   final Map<String, dynamic> param = {
  //     "page": currentPage.toString(),
  //     "perpage": "20",
  //     "search": "",
  //   };
  //   Uri uri =
  //       Uri.parse("$baseUrl/agriculture/farmer-crops-information/crops-type");
  //   uri = uri.replace(queryParameters: param);
  //   return await apiProvider.get(
  //     uri,
  //   );
  // }

  Future<dynamic> getAgricultureCalender(
      {int id = 1, required int currentPage}) async {
    final Map<String, dynamic> param = {
      "category": id.toString(),
      // "page": currentPage.toString(),
      // "perpage": "50",
      // "search": "",
      //   };
    };
    Uri uri = Uri.parse("$baseUrl/agriculture-calender/filter");
    uri = uri.replace(queryParameters: param);

    return await apiProvider.get(uri, token: authRepository.accessToken);
  }
}
