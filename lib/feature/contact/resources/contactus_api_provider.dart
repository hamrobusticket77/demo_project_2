
import '../../../http/api_provider.dart';

class ContactUsApiProvider {
  final String baseUrl;
  final ApiProvider apiProvider;

  ContactUsApiProvider({required this.baseUrl, required this.apiProvider});

  Future<dynamic> sendcontactus({required Map<String, dynamic> body}) async {
    final url = "$baseUrl/contact";
    return await apiProvider.post(url, body);
  }

}