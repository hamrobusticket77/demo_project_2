import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/constant/custom_locale.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/hive/auth_hive.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/user_type_card.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/feature/setting/ui/widget/screen_header.dart';

class LanguageWidget extends StatefulWidget {
  const LanguageWidget({
    super.key,
  });

  @override
  State<LanguageWidget> createState() => _LanguageWidgetState();
}

class _LanguageWidgetState extends State<LanguageWidget> {
  bool isEnglish() {
    return Localizations.localeOf(NavigationService.context) ==
        CustomLocale.english;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(
          CustomTheme.symmetricHozPadding,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ScreenHeader(
              title: LocaleKeys.change.tr(),
              subtitle: LocaleKeys.yourLanguage.tr(),
            ),
            // const SizedBox(height: 43),
            UserTypeCard(
              subtitle: "",
              image: "🇳🇵",
              icon: Icons.people_alt_rounded,
              isSelected: !isEnglish(),
              title: LocaleKeys.nepali.tr(),
              onTap: () async {
                NavigationService.context.setLocale(CustomLocale.nepali);
                await AuthHive().setLanguage("ne");

                await Future.delayed(const Duration(milliseconds: 200));
                NavigationService.pop();
              },
            ),
            UserTypeCard(
              subtitle: "",
              image: "🇺🇸",
              icon: Icons.people_alt_rounded,
              isSelected: isEnglish(),
              title: LocaleKeys.english.tr(),
              onTap: () async {
                NavigationService.context.setLocale(CustomLocale.english);

                await AuthHive().setLanguage("en");
                await Future.delayed(const Duration(milliseconds: 200));
                NavigationService.pop();
                // setState(() async {
                //   NavigationService.context.setLocale(CustomLocale.english);
                //   await Future.delayed(const Duration(milliseconds: 200));
                //   NavigationService.pop();
                // });
              },
            ),

            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
