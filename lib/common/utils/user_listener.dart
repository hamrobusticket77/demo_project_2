import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/auth/model/user_model.dart';
import 'package:krishi_hub/feature/auth/resource/auth_repository.dart';

typedef UserListenableBuilder = Widget Function(BuildContext, UserModel?);

class UserListener extends StatelessWidget {
  const UserListener({super.key, required this.builder});
  final UserListenableBuilder builder;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: RepositoryProvider.of<AuthRepository>(context).user,
        builder: (context, user, child) => builder(context, user));
  }
}
