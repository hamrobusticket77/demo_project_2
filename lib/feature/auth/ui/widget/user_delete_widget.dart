import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/route/route.dart';
import 'package:krishi_hub/common/utils/check_locale.dart';
import 'package:krishi_hub/common/utils/custom_toast.dart';
import 'package:krishi_hub/common/utils/form_validator.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/bottomsheet/common_bottom_sheet.dart';
import 'package:krishi_hub/common/widget/button/custom_icon_button.dart';
import 'package:krishi_hub/common/widget/button/custom_rounded_button.dart';
import 'package:krishi_hub/common/widget/dropdown/common_dropdown_type.dart';
import 'package:krishi_hub/common/widget/loading_overlay.dart';
import 'package:krishi_hub/common/widget/text_field/custom_password_text_field.dart';
import 'package:krishi_hub/common/widget/text_field/custom_text_field.dart';
import 'package:krishi_hub/feature/auth/cubit/delete_user_cubit.dart';
import 'package:krishi_hub/feature/auth/cubit/logout_cubit.dart';
import 'package:krishi_hub/feature/setting/ui/widget/screen_header.dart';

class UserDeleteWidget extends StatefulWidget {
  const UserDeleteWidget({super.key});

  @override
  State<UserDeleteWidget> createState() => _UserDeleteWidgetState();
}

class _UserDeleteWidgetState extends State<UserDeleteWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController reasonController = TextEditingController();

  CommonDropDownType? selectedReason;

  List<CommonDropDownType> deleteReason = [
    CommonDropDownType.noLongerNeedTheService(),
    CommonDropDownType.imNotSatisfiedWithTheService(),
    CommonDropDownType.imNotSatisfiedWithTheProduct(),
    CommonDropDownType.imNotSatisfiedWithTheUserExperience(),
    CommonDropDownType.others(),
  ];

  bool _isAlreadyValidate = false;
  bool _isLoading = false;

  validateField() {
    if (_isAlreadyValidate) {
      _formKey.currentState!.validate();
    }
  }

  _submit() async {
    setState(() {
      _isAlreadyValidate = true;
    });

    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      context.read<DeleteUserCubit>().deleteUser(
            phoneNumber: phoneNumberController.text,
            password: passwordController.text,
            reasonToDelete: selectedReason?.type ?? "",
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteUserCubit, CommonState>(
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
        if (state is CommonSuccess) {
          context.read<LogoutCubit>().logout();
          NavigationService.popUntil(routeName: Routes.dashboardPage);
        }
      },
      child: Scaffold(
          // appBar: const CustomAppBar(
          //   title: "Delete Account",
          // ),
          body: LoadingOverlay(
        isLoading: _isLoading,
        child: SingleChildScrollView(
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
                CustomIconButton(
                  icon: Icons.arrow_back_ios_new_rounded,

                  iconColor: Theme.of(context).primaryColor,
                  // backgroundColor: ,
                  iconSize: 20,
                  onPressed: () {
                    NavigationService.pop();
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ScreenHeader(
                  title: LocaleKeys.deleteAccount.tr(),
                  subtitle: LocaleKeys.itWillCompletelyDeleteYourAccount.tr(),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  onChanged: (value) {
                    validateField();
                  },
                  controller: phoneNumberController,
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
                SizedBox(
                  height: 15.hp,
                ),

                CustomTextField(
                  // onChanged: (value) {
                  //   validateField();
                  // },
                  isReadOnly: true,
                  onTap: () {
                    showCommonBottomSheet(
                      context: context,
                      title: LocaleKeys.chooseAccountDeleteReason.tr(),
                      onChange: (value) {
                        selectedReason = value;

                        reasonController.text =
                            CheckLocal.isEnglish() ? value.en : value.ne;
                        setState(() {});
                      },
                      valueList: deleteReason,
                    );
                  },

                  controller: reasonController,
                  prefixIcon: Icon(
                    Icons.admin_panel_settings_outlined,
                    color: Theme.of(context).primaryColor.withOpacity(0.7),
                  ),
                  labelText: LocaleKeys.chooseAccountDeleteReason.tr(),
                  validator: (value) {
                    return FormValidator.validateFieldNotEmpty(
                        value, LocaleKeys.reason.tr());
                  },
                ),
                // CommonDropDownWidget(
                //     dropDownList: deleteReason,
                //     onChange: (value) {
                //       selectedReason = value;
                //       setState(() {});
                //     },
                //     hintText: "Choose Reason to delete account"),
                SizedBox(
                  height: 34.hp,
                ),
                CustomRoundedButton(
                  title: LocaleKeys.confirm.tr(),
                  onPressed: _submit,
                ),
              ],
            ),
          ),
        )),
      )),
    );
  }
}
