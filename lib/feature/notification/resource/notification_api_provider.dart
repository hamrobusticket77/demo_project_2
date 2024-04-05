import 'package:krishi_hub/feature/auth/resource/auth_repository.dart';
import 'package:krishi_hub/http/api_provider.dart';

class NotificationApiProvider {
  final String baseUrl;

  final ApiProvider apiProvider;
  final AuthRepository authRepository;

  NotificationApiProvider({
    required this.apiProvider,
    required this.baseUrl,
    required this.authRepository,
  });

  Future<dynamic> getNotifications(
      {required int currentPage, String? searchSlug}) async {
    final param = {
      "data": {
        "page": currentPage.toString(),
        "perPage": "20",
        // "search": searchSlug ?? "",
      }
    };

    Uri uri = Uri.parse("$baseUrl/notification");

    // uri = uri.replace(queryParameters: param);

    return apiProvider.get(uri, token: authRepository.accessToken);
  }

  Future<dynamic> updateNotification({required String id}) async {
    // MutationOptions options = MutationOptions(
    //     document: gql(NotificationMutation.updateNotifcaiton),
    //     variables: {
    //       "data": {
    //         "id": id,
    //       }
    //     });

    // return await graphqlProvider.mutation(
    //     options: options, token: authRepository.accessToken);

    final uri = "$baseUrl/notificationupdate";

    return apiProvider.post(uri, {"id": id});
  }
}
