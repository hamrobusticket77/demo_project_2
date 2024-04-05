import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/utils/custom_toast.dart';
import 'package:krishi_hub/common/utils/form_validator.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/common/widget/button/custom_rounded_button.dart';
import 'package:krishi_hub/common/widget/text_field/custom_password_text_field.dart';
import 'package:krishi_hub/common/widget/text_field/custom_text_field.dart';
import 'package:krishi_hub/feature/auth/cubit/update_cubit.dart';

class UpdatePasswordWidget extends StatefulWidget {
  const UpdatePasswordWidget({super.key});

  @override
  State<UpdatePasswordWidget> createState() => _UpdatePasswordWidgetState();
}

class _UpdatePasswordWidgetState extends State<UpdatePasswordWidget> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void login() {
    if (_formKey.currentState!.validate()) {
      context.read<UpdateCubit>().updatePassword(
          oldPassword: oldPasswordController.text,
          newPassword: newPasswordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateCubit, CommonState>(
      listener: (context, state) {
        // if (state is CommonLoading) {
        //   setState(() {
        //     _isLoading = true;
        //   });
        // } else {
        //   setState(() {
        //     _isLoading = false;
        //   });
        // }
        if (state is CommonError) {
          CustomToast.error(message: state.message);
        }
        if (state is CommonStateSuccess) {
          CustomToast.success(message: LocaleKeys.updatepassworsucess.tr());
          NavigationService.pop();
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: LocaleKeys.updatepassword.tr(),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  CustomPasswordTextField(
                    labelText: LocaleKeys.oldpassword.tr(),
                    controller: oldPasswordController,
                    validator: (value) {
                      return FormValidator.validatePassword(value ?? "");
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomPasswordTextField(
                    labelText: LocaleKeys.newPassword.tr(),
                    controller: newPasswordController,
                    validator: (value) {
                      return FormValidator.validatePassword(value ?? "");
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomPasswordTextField(
                    labelText: LocaleKeys.confirmPassword.tr(),
                    controller: confirmPasswordController,
                    validator: (value) {
                      return FormValidator.validateConfirmPassword(
                        value ?? "",
                        newPasswordController.text,
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  BlocBuilder<UpdateCubit, CommonState>(
                    builder: (context, state) {
                      return CustomRoundedButton(
                        isLoading: state is CommonLoading ? true : false,
                        title: LocaleKeys.updatepassword.tr(),
                        onPressed: login,
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
