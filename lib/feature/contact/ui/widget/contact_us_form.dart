import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/feature/contact/cubit/contact_cubit.dart';
import '../../../../common/app/theme.dart';
import '../../../../common/constant/locale_keys.dart';
import '../../../../common/cubit/data_state.dart';
import '../../../../common/utils/custom_toast.dart';
import '../../../../common/utils/form_validator.dart';
import '../../../../common/widget/app_bar/custom_app_bar.dart';
import '../../../../common/widget/button/custom_rounded_button.dart';
import '../../../../common/widget/text_field/custom_text_field.dart';

class ContactUsFormWidget extends StatefulWidget {
  const ContactUsFormWidget({
    super.key,
  });

  @override
  State<ContactUsFormWidget> createState() => _ContactUsFormWidgetState();
}

class _ContactUsFormWidgetState extends State<ContactUsFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  TextEditingController fullName = TextEditingController();

  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController subject = TextEditingController();
  TextEditingController message = TextEditingController();

  TextEditingController date = TextEditingController();

  bool _isAlreadyValidate = false;

  void _validateField() {
    if (_isAlreadyValidate) {
      _formKey.currentState!.validate();
    }
  }

  onSubmit() {}

  @override
  Widget build(BuildContext context) {
    // final textTheme = Theme.of(context).textTheme;

    return BlocListener<ContactUsCubit, CommonState>(
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
            message: LocaleKeys.contactfromsubmit.tr(),
          );
          Navigator.pop(context, true);
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: LocaleKeys.contactus.tr(),
        ),
        body: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: CustomTheme.symmetricHozPadding.hp),
                child: Column(
                  children: [
                    SizedBox(height: 20.hp),
                    CustomTextField(
                      onChanged: (value) {
                        _validateField();
                      },
                      labelText: '${LocaleKeys.fullname.tr()} *',
                      controller: fullName,
                      validator: (value) {
                        return FormValidator.validateFullName(
                            value, LocaleKeys.fullname.tr());
                      },
                    ),
                    CustomTextField(
                      onChanged: (value) {
                        _validateField();
                      },
                      labelText: LocaleKeys.email.tr(),
                      textInputType: TextInputType.emailAddress,
                      controller: email,
                      validator: (value) {
                        return FormValidator.validateEmail(value, true);
                      },
                    ),
                    CustomTextField(
                      onChanged: (value) {
                        _validateField();
                      },
                      labelText: '${LocaleKeys.phonenumber.tr()} *',
                      textInputType: TextInputType.phone,
                      controller: phoneNumber,
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
                      labelText: LocaleKeys.address.tr(),
                      controller: address,
                      // validator: (value) {
                      //   return FormValidator.validateFieldNotEmpty(
                      //       value, LocaleKeys.address.tr());
                      // },
                    ),
                    CustomTextField(
                      onChanged: (value) {
                        _validateField();
                      },
                      labelText: '${LocaleKeys.message.tr()} *',
                      controller: message,
                      maxLines: 3,
                      validator: (value) {
                        return FormValidator.validateFieldNotEmpty(
                            value, LocaleKeys.message.tr());
                      },
                    ),
                    SizedBox(height: 20.hp),
                    CustomRoundedButton(
                        isLoading: _isLoading,
                        title: LocaleKeys.submit.tr(),
                        onPressed: () {
                          setState(() {
                            _isAlreadyValidate = true;
                          });
                          if (_formKey.currentState!.validate()) {
                            context.read<ContactUsCubit>().contactus(
                                  name: fullName.text,
                                  address: address.text,
                                  email: email.text,
                                  message: message.text,
                                  phoneNumber: phoneNumber.text,
                                );
                          }
                        }),
                    SizedBox(height: 34.hp),
                    SizedBox(
                      height: MediaQuery.of(context).padding.bottom,
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
