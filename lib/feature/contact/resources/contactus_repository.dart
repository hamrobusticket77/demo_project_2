import 'package:flutter/material.dart';
import '../../../common/constant/env.dart';
import '../../../common/response/response.dart';
import '../../../http/api_provider.dart';
import 'contactus_api_provider.dart';

class ContactUsRepository {
  final Env env;
  final ApiProvider apiProvider;
  late ContactUsApiProvider contactusApiProvider;

  ContactUsRepository({
    required this.apiProvider,
    required this.env,
  }) {
    contactusApiProvider = ContactUsApiProvider(
      baseUrl: env.baseUrl,
      apiProvider: apiProvider,
    );
  }

  Future<DataResponse<bool>> contactus({
    required String name,
    required String email,
    required String phoneNumber,
    required String address,
    required String message,
  }) async {
    try {
      Map<String, dynamic> body = {
        "name": name,
        "phoneNumber": phoneNumber,
        "address": address,
        "message": message,
      };

      if (email.isNotEmpty) {
        body["email"] = email;
      }

      await contactusApiProvider.sendcontactus(body: body);

      return DataResponse.success(true);
    } catch (e) {
      debugPrint(e.toString());

      return DataResponse.error(e.toString());
    }
  }
}
