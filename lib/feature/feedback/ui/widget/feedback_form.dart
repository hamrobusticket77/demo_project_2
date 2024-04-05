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
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/common/widget/button/custom_rounded_button.dart';
import 'package:krishi_hub/common/widget/text_field/custom_text_field.dart';
import 'package:krishi_hub/feature/auth/model/user_model.dart';
import 'package:krishi_hub/feature/auth/resource/auth_repository.dart';
import 'package:krishi_hub/feature/auth/utils/fullname_utils.dart';
import 'package:krishi_hub/feature/feedback/cubit/feedback_cubit.dart';
import 'package:krishi_hub/feature/feedback/model/feedback_model.dart';
import 'package:krishi_hub/feature/feedback/ui/pages/feed_back_list_page.dart';

class FeedBackForm extends StatefulWidget {
  final FeedbackParams? feedbackParams;
  const FeedBackForm({super.key, this.feedbackParams});

  @override
  State<FeedBackForm> createState() => _FeedBackFormState();
}

bool _isLoading = false;
// final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
// TextEditingController _emailController = TextEditingController();
// TextEditingController _firstnameController = TextEditingController();
// TextEditingController _phonenumberController = TextEditingController();
// TextEditingController _titleController = TextEditingController();
// TextEditingController _descriptionController = TextEditingController();

class _FeedBackFormState extends State<FeedBackForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phonenumberController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  bool _isAlreadyValidate = false;

  void _validateField() {
    if (_isAlreadyValidate) {
      _formKey.currentState!.validate();
    }
  }

  @override
  void initState() {
    final UserModel? user =
        RepositoryProvider.of<AuthRepository>(context).user.value;

    // if (user != null) {
    //   _phonenumberController.text = user.phoneNumber;
    //   _firstnameController.text =
    //       "${user.firstName.en} ${user.middleName?.en ?? ""}${user.lastName.en}";
    // }

    if (RepositoryProvider.of<AuthRepository>(context).isLoggedIn.value &&
        user != null) {
      // _emailController.text =
      _fullNameController.text = FullNameUtils.getFullName(
        firstName: user.firstName,
        lastName: user.lastName,
        middleName: user.middleName,
      );
      _phonenumberController.text = user.phoneNumber;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FeedbackCubit, CommonState>(
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
        if (state is CommonSuccess) {
          CustomToast.success(
            message: LocaleKeys.feedBackSubmittedSuccessfully.tr(),
          );
          Navigator.pop(context, true);
        }
        if (state is CommonError) {
          CustomToast.error(message: state.message);
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: LocaleKeys.feedback.tr(),
          actions: [
            IconButton(
                onPressed: () {
                  NavigationService.push(target: const FeedbackListPage());
                },
                icon: const Icon(
                  Icons.list_rounded,
                  color: CustomTheme.white,
                ))
          ],
        ),
        body: SingleChildScrollView(
            child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: CustomTheme.symmetricHozPadding.wp,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 20.hp,
                ),
                CustomTextField(
                  onChanged: (value) {
                    _validateField();
                  },
                  labelText: LocaleKeys.fullname.tr(),
                  controller: _fullNameController,
                  isRequired: true,
                  validator: (value) {
                    return FormValidator.validateFieldNotEmpty(
                        value, LocaleKeys.description.tr());
                  },
                ),
                CustomTextField(
                  onChanged: (value) {
                    _validateField();
                  },
                  labelText: LocaleKeys.email.tr(),
                  controller: _emailController,
                  textInputType: TextInputType.emailAddress,
                  isRequired: true,
                  validator: (value) {
                    return FormValidator.validateEmail(
                      value,
                    );
                  },
                ),
                CustomTextField(
                  onChanged: (value) {
                    _validateField();
                  },
                  labelText: LocaleKeys.phonenumber.tr(),
                  isRequired: true,
                  textInputType: TextInputType.number,
                  textInputFormatterList: [
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  controller: _phonenumberController,
                  validator: (value) {
                    return FormValidator.validatePhoneNumber(
                      value,
                    );
                  },
                ),
                CustomTextField(
                  onChanged: (value) {
                    _validateField();
                  },
                  labelText: LocaleKeys.title.tr(),
                  isRequired: true,
                  controller: _titleController,
                  validator: (value) {
                    return FormValidator.validateFieldNotEmpty(
                        value, LocaleKeys.title.tr());
                  },
                ),
                CustomTextField(
                  onChanged: (value) {
                    _validateField();
                  },
                  validator: (value) {
                    return FormValidator.validateFieldNotEmpty(
                        value, LocaleKeys.description.tr());
                  },
                  labelText: LocaleKeys.description.tr(),
                  controller: _descriptionController,
                  maxLines: 4,
                  isRequired: false,
                ),
                CustomRoundedButton(
                    isLoading: _isLoading,
                    title: LocaleKeys.submit.tr(),
                    onPressed: () {
                      setState(() {
                        _isAlreadyValidate = true;
                      });
                      if (_formKey.currentState!.validate()) {
                        context.read<FeedbackCubit>().createfeedback(
                              name: _fullNameController.text,
                              email: _emailController.text,
                              phoneNumber: _phonenumberController.text,
                              title: _titleController.text,
                              description: _descriptionController.text,
                            );
                      }
                    }),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
