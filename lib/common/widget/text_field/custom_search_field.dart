import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/constant/constant_assets.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';

class CustomSearchField extends StatelessWidget {
  final Function()? onTapSuffixButton;
  final String hintText;
  final TextEditingController controller;
  final Function(String)? onFieldSubmitted;

  final void Function(String)? onChanged;
  const CustomSearchField(
      {Key? key,
      required this.controller,
      this.onTapSuffixButton,
      required this.hintText,
      this.onFieldSubmitted,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final txt = theme.textTheme;
    return TextFormField(
      style: txt.bodyLarge,
      controller: controller,
      cursorColor: theme.primaryColor,
      onFieldSubmitted: onFieldSubmitted,
      textInputAction: TextInputAction.search,
      onChanged: onChanged,
      decoration: InputDecoration(
        suffix: InkWell(
            onTap: onTapSuffixButton,
            child: Text(
              LocaleKeys.clear.tr(),
              style: theme.textTheme.bodyLarge!
                  .copyWith(color: theme.primaryColor),
            )),
        hintText: hintText,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            Assets.search,
            height: 5,
            width: 5,
            fit: BoxFit.cover,
            color: CustomTheme.midGrayColor,
          ),
        ),
        hintStyle: theme.textTheme.bodyLarge!
            .copyWith(color: CustomTheme.grey, fontWeight: FontWeight.w400),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        border: InputBorder.none,
        focusedBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: CustomTheme.midGrayColor, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: CustomTheme.midGrayColor, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.primaryColor),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.primaryColor),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
