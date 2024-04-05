import 'package:flutter/material.dart';
import 'package:krishi_hub/feature/auth/ui/widget/login_widget.dart';

class LoginPage extends StatelessWidget {
  final bool loginFromOtherPage;

  const LoginPage({super.key, this.loginFromOtherPage = false});

  @override
  Widget build(BuildContext context) {
    return LoginWidget(
      loginFromOtherPage: loginFromOtherPage,
    );
  }
}
