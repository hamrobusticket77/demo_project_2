import 'package:easy_localization/easy_localization.dart';
import 'package:krishi_hub/common/utils/regex.dart';
import '../constant/locale_keys.dart';

class FormValidator {
  static String? validateEmail(String? val, [bool supportEmpty = false]) {
    if (supportEmpty && (val == null || val.isEmpty)) {
      return null;
    } else if (val == null) {
      return LocaleKeys.fieldCannotBeEmpty.tr(args: [LocaleKeys.email.tr()]);
    } else if (val.isEmpty) {
      return LocaleKeys.fieldCannotBeEmpty.tr(args: [LocaleKeys.email.tr()]);
    } else if (Regex.emailRegex.hasMatch(val)) {
      return null;
    } else {
      return LocaleKeys.pleaseEnterValidField.tr(args: [LocaleKeys.email.tr()]);
    }
  }

  static String? validateFieldNotEmpty(String? val, String fieldName) {
    if (val == null) {
      return LocaleKeys.fieldCannotBeEmpty.tr(args: [fieldName]);
    } else if (val.isEmpty) {
      return LocaleKeys.fieldCannotBeEmpty.tr(args: [fieldName]);
    } else {
      return null;
    }
  }

  static String? validatePhoneNumber(String? val) {
    if (val == null) {
      return LocaleKeys.fieldCannotBeEmpty
          .tr(args: [LocaleKeys.phonenumber.tr()]);
    } else if (val.isEmpty) {
      return LocaleKeys.fieldCannotBeEmpty
          .tr(args: [LocaleKeys.phonenumber.tr()]);
    } else if (val.length != 10 || !Regex.phoneNumberRegex.hasMatch(val)) {
      return LocaleKeys.enterValidPhoneNumber.tr();
    } else {
      return null;
    }
  }

  static String? validatePassword(String? val, {String? label}) {
    if (val == null) {
      return LocaleKeys.fieldCannotBeEmpty
          .tr(args: [label ?? LocaleKeys.password.tr()]);
    } else if (val.isEmpty) {
      return LocaleKeys.fieldCannotBeEmpty
          .tr(args: [label ?? LocaleKeys.password.tr()]);
    } else if (Regex.passwordRegex.hasMatch(val)) {
      return null;
    } else {
      return LocaleKeys.invalidPasswordMessage
          .tr(args: [label ?? LocaleKeys.password.tr()]);
    }
  }

  static validateNepaliText(String? value, String fieldName,
      [bool supportEmpty = false]) {
    if (supportEmpty && (value == null || value.isEmpty)) {
      return null;
    } else if (value == null) {
      return LocaleKeys.fieldCannotBeEmpty.tr(args: [fieldName]);
    } else if (value.isEmpty) {
      return LocaleKeys.fieldCannotBeEmpty.tr(args: [fieldName]);
    } else if (!Regex.nepaliTextOnlyRegex.hasMatch(value)) {
      return null;
    } else {
      return LocaleKeys.shouldBeNepali.tr(args: [fieldName]);
    }
  }

  static String? validateConfirmPassword(String? val, String? newPassword,
      {String? label}) {
    if (val == null) {
      return LocaleKeys.fieldCannotBeEmpty
          .tr(args: [label ?? LocaleKeys.password.tr()]);
    } else if (val.isEmpty) {
      return LocaleKeys.fieldCannotBeEmpty
          .tr(args: [label ?? LocaleKeys.password.tr()]);
    } else if (Regex.passwordRegex.hasMatch(val)) {
      if (val == newPassword) {
        return null;
      } else {
        return LocaleKeys.doesnotMatch
            .tr(args: [label ?? LocaleKeys.confirmPassword.tr()]);
      }
    } else {
      return LocaleKeys.invalidPasswordMessage
          .tr(args: [label ?? LocaleKeys.password.tr()]);
    }
  }

  static String? validateFullName(String? val, String fieldName) {
    if (val == null) {
      return LocaleKeys.fieldCannotBeEmpty.tr(args: [fieldName]);
    } else if (val.isEmpty) {
      return LocaleKeys.fieldCannotBeEmpty.tr(args: [fieldName]);
    } else if (val.contains(" ")) {
      return null;
    } else {
      return LocaleKeys.enterValid.tr(args: [fieldName]);
    }
  }
}
