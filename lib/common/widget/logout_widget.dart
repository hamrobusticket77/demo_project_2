import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/button/custom_rounded_button.dart';

showLogoutAlertDialog(
    {required BuildContext context, required Function() onPressed}) {
  showDialog(
      context: context,
      builder: (context) => CommonAlertDialog(
            onPressed: onPressed,
          ));
}

class CommonAlertDialog extends StatelessWidget {
  final Function() onPressed;

  const CommonAlertDialog({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.wp))),
      title: Text(LocaleKeys.logout.tr(),
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold)),
      content: Text(
        LocaleKeys.logoutMessage.tr(),
        style: Theme.of(context).textTheme.titleSmall,
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              LocaleKeys.cancel.tr(),
              style: theme.textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.w700,
                color: Theme.of(context).primaryColor,
                fontSize: 12,
              ),
            )),
        SizedBox(width: 10.hp),
        SizedBox(
          width: 130,
          height: 34,
          child: CustomRoundedButton(
            title: LocaleKeys.yesLogout.tr(),
            onPressed: () {
              Navigator.pop(context);
              onPressed();
            },
            fontSize: 12,
            padding: EdgeInsets.zero,
          ),
        )
      ],
    );
  }
}
