import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/utils/form_validator.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/common/widget/button/custom_rounded_button.dart';
import 'package:krishi_hub/common/widget/text_field/custom_text_field.dart';

class ForgetPassworVerifyEmailWidget extends StatefulWidget {
  const ForgetPassworVerifyEmailWidget({super.key});

  @override
  State<ForgetPassworVerifyEmailWidget> createState() =>
      _ForgetPassworVerifyEmailWidgetState();
}

class _ForgetPassworVerifyEmailWidgetState
    extends State<ForgetPassworVerifyEmailWidget> {
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return

        // BlocListener<ForgetPasswordCubit, CommonState>(
        //   listener: (context, state) {
        //     if (state is CommonLoading) {
        //       setState(() {
        //         _isLoading = true;
        //       });
        //     } else {
        //       setState(() {
        //         _isLoading = false;
        //       });
        //     }
        //     if (state is CommonError) {
        //       CustomToast.error(message: state.message);
        //     }
        //     if (state is CommonSuccess) {
        //       NavigationService.pushNamed(
        //           routeName: Routes.forgetPasswordVerifyOTPPage);
        //     }
        //   },
        // child:
        Scaffold(
            appBar: const CustomAppBar(),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: CustomTheme.symmetricHozPadding.hp),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.hp),
                      Text(
                        LocaleKeys.forgetPasswordText.tr(),
                        style: TextStyle(
                            fontSize: 25,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10.hp),
                      Text(
                        LocaleKeys.verifyEmailAddress.tr(),
                        style: const TextStyle(
                            fontSize: 18, color: CustomTheme.grey),
                      ),
                      SizedBox(height: 50.hp),
                      CustomTextField(
                        prefixIcon: Icon(
                          Icons.person_outline,
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.7),
                        ),
                        labelText: LocaleKeys.email.tr(),
                        controller: emailController,
                        validator: (value) {
                          return FormValidator.validateEmail(value);
                        },
                      ),
                      SizedBox(height: 30.hp),
                      CustomRoundedButton(
                          title: LocaleKeys.verifyEmailAddress.tr(),
                          isLoading: _isLoading,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              FocusScope.of(context).unfocus();

                              // NavigationService.pushNamed(
                              //     routeName: Routes.forgetPasswordVerifyOTPPage);
                              // context
                              //     .read<ForgetPasswordCubit>()
                              //     .forgetPasswordVerifyEmail(
                              //         email: emailController.text);
                            }
                            // NavigationService.pushNamed(
                            //     routeName: Routes.forgetPasswordVerifyOTPPage);
                          }),
                    ],
                  ),
                ),
              ),
            )
            // ),
            );
  }
}
