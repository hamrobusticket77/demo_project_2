import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.width = double.infinity,
    this.height,
    this.fontSize = 14,
    this.labelText,
    this.isObscureText = false,
    this.initialValue,
    this.textInputType,
    this.controller,
    this.validator,
    this.color,
    this.prefixIcon,
    this.maxLength,
    this.onTap,
    this.onChanged,
    this.suffixIcon,
    this.isReadOnly = false,
    this.isRequired = false,
    this.maxLines = 1,
    this.helperText,
    this.textInputFormatterList,
    this.bottomMargin,
    this.textInputAction,
    this.hintText,
    this.contentPadding,
    TextStyle? helperStyle,
  }) : super(key: key);

  final double? width;
  final double? height;
  final double fontSize;
  final String? labelText;
  final bool isObscureText;
  final bool isReadOnly;
  final Color? color;
  final String? initialValue;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLength;
  final Function()? onTap;
  final void Function(String)? onChanged;
  final bool isRequired;
  final int maxLines;
  final String? helperText;
  final List<TextInputFormatter>? textInputFormatterList;
  final double? bottomMargin;
  final TextInputAction? textInputAction;
  final String? hintText;

  final EdgeInsets? contentPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: bottomMargin ?? 20),
      width: width,
      height: height,
      child: TextFormField(
        scrollPadding: EdgeInsets.all(0),
        textAlign: maxLength != null ? TextAlign.center : TextAlign.left,
        controller: controller,
        keyboardType: textInputType,
        obscureText: isObscureText,
        cursorColor: color,

        //  maxLines: 1, // Set the maximum number of lines to 1
        // overflow: TextOverflow.ellipsis,
        initialValue: initialValue,
        validator: validator,
        maxLength: maxLength,
        onChanged: onChanged,
        onTap: onTap,
        readOnly: isReadOnly,
        maxLines: maxLines,
        textInputAction: textInputAction,
        inputFormatters: textInputFormatterList,
        style: maxLength == 1
            ? TextStyle(
                color: color,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              )
            : TextStyle(
                color: CustomTheme.black,
                fontSize: fontSize,
                fontWeight: FontWeight.w400),
        decoration: InputDecoration(
            hintText: hintText,
            contentPadding: contentPadding ??
                EdgeInsets.symmetric(vertical: 16.hp, horizontal: 20.wp),
            counterText: "",
            helperText: helperText,
            helperStyle: TextStyle(
              inherit: true,
              color: Theme.of(context).primaryColor,
            ),
            fillColor: CustomTheme.white,
            filled: true,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: CustomTheme.midGrayColor)),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: CustomTheme.grey),
              borderRadius: BorderRadius.circular(6),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: color ?? Theme.of(context).primaryColor,
                ),
                borderRadius: BorderRadius.circular(6)),
            labelText: labelText != null
                ? isRequired
                    ? "$labelText * "
                    : labelText
                : null,
            alignLabelWithHint: true,
            labelStyle: const TextStyle(
              color: CustomTheme.black,
              fontSize: 12,
            )),
      ),
    );
  }
}
