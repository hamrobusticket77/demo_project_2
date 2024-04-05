import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/model/multi_language.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/utils/check_locale.dart';
import 'package:krishi_hub/common/utils/custom_toast.dart';
import 'package:krishi_hub/common/utils/form_validator.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/common/widget/button/custom_icon_button.dart';
import 'package:krishi_hub/common/widget/button/custom_rounded_button.dart';
import 'package:krishi_hub/common/widget/text_field/custom_text_field.dart';
import 'package:krishi_hub/feature/auth/cubit/farmer_request_cubit.dart';
import 'package:krishi_hub/feature/privacy_policy/ui/page/privacy_policy_page.dart';
import 'package:krishi_hub/feature/setting/ui/widget/language_page.dart';
import 'package:krishi_hub/feature/setting/ui/widget/screen_header.dart';

class FarmerRequestWidget extends StatefulWidget {
  const FarmerRequestWidget({super.key});

  @override
  State<FarmerRequestWidget> createState() => _FarmerRequestWidgetState();
}

class _FarmerRequestWidgetState extends State<FarmerRequestWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController fullName = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController wardNumber = TextEditingController();

  bool _isAlreadyValidate = false;

  validateField() {
    if (_isAlreadyValidate) {
      _formKey.currentState!.validate();
    }
  }

  _onSubmit() {
    setState(() {
      _isAlreadyValidate = true;
    });

    if (_formKey.currentState!.validate()) {
      context.read<FarmerRequestCubit>().farmerRequest(
            fullName: fullName.text,
            phoneNumber: phoneNumber.text,
            wardNumber: int.parse(wardNumber.text),
          );
    }
  }

  onTapTermsAndPolicy() {
    NavigationService.push(target: const PrivacyPolicyPage());
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return BlocListener<FarmerRequestCubit, CommonState>(
      listener: (context, state) {
        if (state is CommonError) {
          CustomToast.error(message: state.message);
        }

        if (state is CommonSuccess) {
          CustomToast.success(
              message: LocaleKeys.farmerRegisterRequestSucess.tr());
          if (mounted) {
            NavigationService.pop();
          }
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          backgroundColor: CustomTheme.white,
          leadingIcon: CustomIconButton(
            icon: Icons.arrow_back,
            // backgroundColor: CustomTheme.white,
            iconColor: Theme.of(context).primaryColor,
            onPressed: () {
              NavigationService.pop();
            },
          ),
          actions: [
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
          title: "",
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: CustomTheme.symmetricHozPadding.wp,
                vertical: CustomTheme.symmetricHozPadding.hp),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ScreenHeader(
                    title: LocaleKeys.registration.tr(),
                    subtitle: LocaleKeys.requestForRegestration.tr(),
                  ),
                  SizedBox(height: 50.hp),
                  CustomTextField(
                    onChanged: (value) {
                      validateField();
                    },
                    controller: phoneNumber,
                    prefixIcon: Icon(
                      Icons.phone_android_outlined,
                      color: Theme.of(context).primaryColor.withOpacity(0.7),
                    ),
                    textInputType: TextInputType.number,
                    textInputFormatterList: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    labelText: LocaleKeys.phoneNumber.tr(),
                    validator: (value) {
                      return FormValidator.validatePhoneNumber(value ?? "");
                    },
                  ),
                  CustomTextField(
                    onChanged: (value) {
                      validateField();
                    },
                    controller: fullName,
                    prefixIcon: Icon(
                      Icons.person_outline,
                      color: Theme.of(context).primaryColor.withOpacity(0.7),
                    ),
                    // textInputType: TextInputType.number,
                    labelText: LocaleKeys.fullname.tr(),
                    validator: (value) {
                      return FormValidator.validateFieldNotEmpty(
                          value ?? "", LocaleKeys.phoneNumber);
                    },
                  ),
                  CustomTextField(
                    onChanged: (value) {
                      validateField();
                    },
                    controller: wardNumber,
                    prefixIcon: Icon(
                      Icons.home_outlined,
                      color: Theme.of(context).primaryColor.withOpacity(0.7),
                    ),
                    textInputType: TextInputType.number,
                    textInputFormatterList: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    labelText: LocaleKeys.wardNumber.tr(),
                    validator: (value) {
                      return FormValidator.validateFieldNotEmpty(
                          value ?? "", LocaleKeys.wardNumber.tr());
                    },
                  ),
                  SizedBox(
                    height: 15.hp,
                  ),
                  BlocBuilder<FarmerRequestCubit, CommonState>(
                    builder: (context, state) {
                      return CustomRoundedButton(
                        title: LocaleKeys.registerText.tr(),
                        isLoading: state is CommonLoading,
                        onPressed: _onSubmit,
                      );
                    },
                  ),
                  SizedBox(
                    height: 15.hp,
                  ),
                  // TextButton(
                  //     onPressed: () {
                  //       NavigationService.push(target: PrivacyPolicyPage());
                  //     },
                  //     child: Text(
                  //       "By creating, you are agreeing to our Terms of Service and Privacy Policy, ",
                  //     )),
                  Row(
                    children: [
                      Expanded(
                        child: RichText(
                          // locale: CheckLocal.isEnglish()
                          //     ? CustomLocale.english
                          //     : CustomLocale.nepali,
                          textAlign: TextAlign.center,

                          text: TextSpan(
                            style: textTheme.headlineSmall!.copyWith(),
                            children: [
                              TextSpan(
                                text: CheckLocal.check(MultiLanguage(
                                    en: "By creating, you are agreeing to our",
                                    ne: "खाता सिर्जना गरेर, तपाईं हाम्रा")),
                                style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    // color: Theme.of(context).primaryColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                              TextSpan(
                                text: CheckLocal.check(MultiLanguage(
                                    en: " Terms ", ne: " सर्तहरू ")),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = onTapTermsAndPolicy,
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: CheckLocal.check(
                                    MultiLanguage(en: "and ", ne: "र ")),
                                // recognizer: TapGestureRecognizer()..onTap = onPressed,
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              TextSpan(
                                text: CheckLocal.check(MultiLanguage(
                                    en: "Privacy Policy.",
                                    ne: " गोपनीयता नीतिमा ")),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = onTapTermsAndPolicy,
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              if (!CheckLocal.isEnglish())
                                TextSpan(
                                  text: CheckLocal.check(MultiLanguage(
                                      en: "", ne: "सहमत हुनुहुन्छ ।")),
                                  style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
