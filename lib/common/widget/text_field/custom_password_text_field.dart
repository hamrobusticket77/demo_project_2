import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';

class CustomPasswordTextField extends StatefulWidget {
  final double width, height;
  final String labelText;
  final Color? color;
  final String? initialValue;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool isShowHelperText;
  final void Function(String)? onChanged;

  const CustomPasswordTextField(
      {Key? key,
      this.width = double.infinity,
      this.height = 60,
      required this.labelText,
      this.initialValue,
      this.onChanged,
      this.textInputType,
      this.controller,
      this.validator,
      this.color,
      this.isShowHelperText = true})
      : super(key: key);

  @override
  State<CustomPasswordTextField> createState() =>
      _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  bool _isPasswordShown = false;

  void onPressedHandler() {
    setState(() {
      _isPasswordShown = !_isPasswordShown;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      // height: widget.height,
      child: TextFormField(
        controller: widget.controller,
        initialValue: widget.initialValue,
        onChanged: widget.onChanged,
        keyboardType: TextInputType.visiblePassword,
        obscureText: !_isPasswordShown ? true : false,
        cursorColor: widget.color,
        validator: widget.validator,
        style: const TextStyle(
            color: CustomTheme.black,
            fontSize: 15,
            fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(vertical: 16.hp, horizontal: 20.wp),
          // helperText: widget.isShowHelperText
          //     ? LocaleKeys.passwordHelperText.tr()
          //     : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: widget.color ?? Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(6)),
          labelText: widget.labelText,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: CustomTheme.midGrayColor)),
          labelStyle: const TextStyle(color: CustomTheme.black, fontSize: 12),
          prefixIcon: Icon(
            Icons.lock,
            color: Theme.of(context).primaryColor.withOpacity(0.7),
          ),
          suffixIcon: IconButton(
              icon: Icon(
                  _isPasswordShown
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: Theme.of(context).primaryColor.withOpacity(0.7)),
              onPressed: onPressedHandler),
        ),
      ),
    );
  }
}
