import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/feature/auth/cubit/delete_user_cubit.dart';
import 'package:krishi_hub/feature/auth/resource/auth_repository.dart';
import 'package:krishi_hub/feature/auth/ui/widget/user_delete_widget.dart';

class UserDeletePage extends StatelessWidget {
  const UserDeletePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeleteUserCubit(
          authRepository: RepositoryProvider.of<AuthRepository>(context)),
      child: const UserDeleteWidget(),
    );
  }
}
