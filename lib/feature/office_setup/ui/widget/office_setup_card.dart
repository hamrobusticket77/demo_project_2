import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/common_card_wapper.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/utils/text_utils.dart';
import 'package:krishi_hub/common/utils/url_luncher_utils.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/text_tile_widget.dart';
import 'package:krishi_hub/feature/office_setup/model/office_setup_model.dart';

class CallCenterCard extends StatelessWidget {
  final Function()? onPressed;

  final EdgeInsetsGeometry? margin;

  final OfficeSetupModel officeSetupModel;

  const CallCenterCard({
    super.key,
    required this.officeSetupModel,
    this.onPressed,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return CommonCardWrapper(
      onTap: onPressed,
      margin: margin ??
          EdgeInsets.symmetric(
              horizontal: CustomTheme.symmetricHozPadding.wp, vertical: 10.hp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextTileWidget(
            title: LocaleKeys.name.tr(),
            subTitle: officeSetupModel.name,
          ),
          InkWell(
            onTap: () {
              UrlLauncherUtils.launchEmail(officeSetupModel.email);
            },
            child: TextTileWidget(
              title: LocaleKeys.email.tr(),
              subTitle: officeSetupModel.email,
            ),
          ),
          InkWell(
            onTap: () {
              UrlLauncherUtils.launchPhone(officeSetupModel.phoneNumber);
            },
            child: TextTileWidget(
              title: LocaleKeys.phoneNumber.tr(),
              subTitle: officeSetupModel.phoneNumber.toNepali(),
            ),
          ),
          TextTileWidget(
            title: LocaleKeys.address.tr(),
            subTitle: officeSetupModel.address,
          ),
        ],
      ),
    );
  }
}
