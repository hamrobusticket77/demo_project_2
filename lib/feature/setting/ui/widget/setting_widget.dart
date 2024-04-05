import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/feature/auth/ui/page/update_password.dart';

import '../../../../common/app/theme.dart';
import '../../../../common/constant/locale_keys.dart';
import '../../../../common/navigation/navigation_service.dart';
import '../../../../common/widget/app_bar/custom_app_bar.dart';
import '../../../../common/widget/button/custom_icon_button.dart';
import 'language_page.dart';

class SettingWidget extends StatefulWidget {
  const SettingWidget({super.key});

  @override
  State<SettingWidget> createState() => _SettingWidgetState();
}

class _SettingWidgetState extends State<SettingWidget> {
  final bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.setting.tr(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Column(
            children: [
              SizedBox(height: 20.hp),
              RoundedListTileCard(
                title: LocaleKeys.yourLanguage.tr(),
                borderRadius: 0,
                icon: Icons.language,
                horizontalPadding: 18,
                vertialPadding: 12,
                titleFontWeight: FontWeight.w300,
                titleFontSize: 11,
                onPressed: () {
                  NavigationService.push(target: const LanguagePage())
                      .whenComplete(() {
                    setState(() {});
                  });
                },
              ),
              RoundedListTileCard(
                title: LocaleKeys.updatepassword.tr(),
                borderRadius: 0,
                icon: Icons.lock,
                horizontalPadding: 18,
                vertialPadding: 12,
                titleFontWeight: FontWeight.w300,
                titleFontSize: 11,
                onPressed: () {
                  NavigationService.push(target: const UpdatePassword())
                      .whenComplete(() {
                    setState(() {});
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RoundedListTileCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function()? onPressed;
  final bool hasForwardIcon;
  final double borderRadius;
  final double horizontalPadding;
  final double vertialPadding;
  final FontWeight titleFontWeight;
  final double? titleFontSize;

  const RoundedListTileCard(
      {super.key,
      required this.title,
      required this.icon,
      this.onPressed,
      this.borderRadius = 25,
      this.horizontalPadding = 20,
      this.vertialPadding = 10,
      this.hasForwardIcon = true,
      this.titleFontWeight = FontWeight.w500,
      this.titleFontSize});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.hp),
      child: Material(
        elevation: 0,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: onPressed,
          child: Container(
            decoration: BoxDecoration(
                color: CustomTheme.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(borderRadius.wp)),
            padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding.wp, vertical: vertialPadding.hp),
            child: Row(
              children: [
                CustomIconButton(
                  icon: icon,
                  backgroundColor:
                      Theme.of(context).primaryColor.withOpacity(0.5),
                  iconColor: CustomTheme.white,
                  horizontalPadding: 8,
                  verticalPadding: 8,
                  iconSize: 16,
                ),
                SizedBox(width: 20.wp),
                Expanded(
                    child: Text(
                  title,
                  style: textTheme.bodyLarge!.copyWith(
                    fontWeight: titleFontWeight,
                    fontSize: titleFontSize,
                  ),
                )),
                if (hasForwardIcon)
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 18,
                    color: Theme.of(context).primaryColor,
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
