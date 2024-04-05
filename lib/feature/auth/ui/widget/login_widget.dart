import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/utils/custom_toast.dart';
import 'package:krishi_hub/common/utils/form_validator.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/button/custom_icon_button.dart';
import 'package:krishi_hub/common/widget/button/custom_rounded_button.dart';
import 'package:krishi_hub/common/widget/custom_check_box.dart';
import 'package:krishi_hub/common/widget/text_field/custom_password_text_field.dart';
import 'package:krishi_hub/common/widget/text_field/custom_text_field.dart';
import 'package:krishi_hub/feature/auth/cubit/login_cubit.dart';
import 'package:krishi_hub/feature/auth/resource/auth_repository.dart';
import 'package:krishi_hub/feature/auth/ui/page/farmer_request_page.dart';

import 'package:krishi_hub/feature/setting/ui/widget/language_page.dart';
import 'package:krishi_hub/feature/setting/ui/widget/screen_header.dart';

class LoginWidget extends StatefulWidget {
  final bool loginFromOtherPage;

  const LoginWidget({
    required this.loginFromOtherPage,
    super.key,
  });

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  bool _rememberMe = true;

  @override
  void initState() {
    super.initState();

    if (RepositoryProvider.of<AuthRepository>(context).rememberUserId.value !=
            null &&
        RepositoryProvider.of<AuthRepository>(context)
            .rememberUserId
            .value!
            .isNotEmpty) {
      emailController.text =
          RepositoryProvider.of<AuthRepository>(context).rememberUserId.value ??
              "";
    }
  }

  bool _isAlreadyValidate = false;

  validateField() {
    if (_isAlreadyValidate) {
      _formKey.currentState!.validate();
    }
  }

  login() async {
    setState(() {
      _isAlreadyValidate = true;
    });
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      context.read<LoginCubit>().login(
            phoneNumber: emailController.text.trim(),
            password: passwordController.text,
            isRememberMe: _rememberMe,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, CommonState>(
      listener: (context, state) {
        if (state is CommonLoading) {
          setState(() {
            _isLoading = true;
          });
        } else {
          setState(() {
            _isLoading = false;
          });
        }
        if (state is CommonError) {
          CustomToast.error(message: state.message);
        }
        if (state is CommonStateSuccess) {
          CustomToast.success(message: LocaleKeys.loginSuccessMessage.tr());
          if (widget.loginFromOtherPage) {
            Navigator.pop(context, true);
          }
        }
      },
      child: Scaffold(
          body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: CustomTheme.symmetricHozPadding.hp),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).padding.top + 10,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (widget.loginFromOtherPage)
                      CustomIconButton(
                        icon: Icons.arrow_back_ios_new_rounded,
                        iconColor: Theme.of(context).primaryColor,
                        // backgroundColor: ,
                        onPressed: () {
                          NavigationService.pop();
                        },
                      ),
                    const Expanded(child: SizedBox()),
                    CustomIconButton(
                      icon: Icons.language,
                      iconColor: Theme.of(context).primaryColor,
                      // backgroundColor: ,
                      onPressed: () {
                        NavigationService.push(target: const LanguagePage())
                            .whenComplete(() {
                          setState(() {});
                        });
                      },
                    ),
                  ],
                ),
                ScreenHeader(
                  title: LocaleKeys.welcome.tr(),
                  subtitle: LocaleKeys.signInToYourAccount.tr(),
                ),
                SizedBox(height: 50.hp),
                CustomTextField(
                  onChanged: (value) {
                    validateField();
                  },
                  controller: emailController,
                  prefixIcon: Icon(
                    Icons.person_outline,
                    color: Theme.of(context).primaryColor.withOpacity(0.7),
                  ),
                  textInputType: TextInputType.number,
                  labelText: LocaleKeys.phoneNumber.tr(),
                  validator: (value) {
                    return FormValidator.validatePhoneNumber(value ?? "");
                  },
                ),
                SizedBox(
                  height: 10.hp,
                ),
                CustomPasswordTextField(
                  onChanged: (value) {
                    validateField();
                  },
                  isShowHelperText: false,
                  labelText: LocaleKeys.password.tr(),
                  controller: passwordController,
                  validator: (value) {
                    return FormValidator.validatePassword(value ?? "");
                  },
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomCheckBox(
                      label: LocaleKeys.rememberMe.tr(),
                      onChange: (value) {
                        setState(() {
                          _rememberMe = value;
                          debugPrint(_rememberMe.toString());
                        });
                      },
                    ),
                    // TextButton(
                    //   onPressed: () {
                    //     FocusScope.of(context).unfocus();
                    //     NavigationService.pushNamed(
                    //         routeName:
                    //             Routes.forgetPasswordVerifyEmailPage);
                    //   },
                    //   child: Text(
                    //     "${LocaleKeys.forgetPassword.tr()} ?",
                    //     style: const TextStyle(
                    //         fontWeight: FontWeight.w600,
                    //         decoration: TextDecoration.underline),
                    //   ),
                    // )
                  ],
                ),
                // Align(
                //     alignment: Alignment.topRight,
                //     child: TextButton(
                //         onPressed: () {
                //           NavigationService.push(
                //               target: const ForgetPassworVerifyEmailWidget());
                //         },
                //         child: Text("Forget Password ?"))),
                SizedBox(
                  height: 15.hp,
                ),
                CustomRoundedButton(
                  title: LocaleKeys.login.tr(),
                  isLoading: _isLoading,
                  onPressed: login,
                ),
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     if (_supportState == _SupportState.unknown)
                //       const CircularProgressIndicator()
                //     else if (_supportState == _SupportState.supported)
                //       Center(
                //         child: Column(
                //           children: [
                //             // ElevatedButton(
                //             //   onPressed: _authenticate,
                //             //   child: const Row(
                //             //     mainAxisSize: MainAxisSize.min,
                //             //     children: <Widget>[
                //             //       Text('Authenticate'),
                //             //       Icon(Icons.perm_device_information),
                //             //     ],
                //             //   ),
                //             // ),
                //             ElevatedButton(
                //               onPressed: _authenticateWithBiometrics,
                //               child: Row(
                //                 mainAxisSize: MainAxisSize.min,
                //                 children: <Widget>[
                //                   Text(_isAuthenticating
                //                       ? 'Cancel'
                //                       : 'Authenticate: biometrics only'),
                //                   const Icon(Icons.fingerprint_rounded),
                //                 ],
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //   ],
                // ),

                SizedBox(height: 20.hp),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomRoundedButton(
                        textColor: Theme.of(context).primaryColor,
                        color: CustomTheme.white,
                        elevation: 0,
                        title: LocaleKeys.requestForRegestration.tr(),
                        onPressed: () {
                          NavigationService.push(
                                  target: const FarmerRequestPage())
                              .whenComplete(() {
                            setState(() {});
                          });
                        }),
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}

// enum _SupportState {
//   unknown,
//   supported,
//   unsupported,
// }
