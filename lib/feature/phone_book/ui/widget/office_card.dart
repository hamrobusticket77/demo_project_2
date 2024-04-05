import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/common_card_wapper.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';

import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/button/custom_outline_button.dart';
import 'package:krishi_hub/common/widget/button/custom_view_button.dart';
import 'package:krishi_hub/common/widget/date_formater_utils.dart';
import 'package:krishi_hub/common/widget/text_tile_widget.dart';
import 'package:krishi_hub/feature/phone_book/model/office_model.dart';
import 'package:krishi_hub/feature/phone_book/ui/page/suboffice_page.dart';

class OfficeCard extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final OfficeModel officeModel;
  final Function() onPressed;
  final int index;
  const OfficeCard({
    Key? key,
    required this.officeModel,
    required this.onPressed,
    this.margin,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: CustomTheme.symmetricHozPadding.wp, vertical: 5.hp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CommonCardWrapper(
            margin:
                margin ?? EdgeInsets.symmetric(horizontal: 0, vertical: 5.hp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextTileWidget(
                  title: LocaleKeys.date.tr(),
                  subTitle:
                      DateFormatterUtils.convertAdIntoBs(officeModel.createdAt),
                ),
                TextTileWidget(
                  title: LocaleKeys.office.tr(),
                  subTitle: officeModel.title,
                ),
                TextTileWidget(
                  title: "Department",
                  subTitle: officeModel.department.title,
                ),
                CustomViewIcons(
                  onpress: onPressed,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomOutlineButton(
                      name: "View Sub Office",
                      sufixIcon: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        NavigationService.push(
                          target: Suboffice(
                            suboffice: officeModel,
                          ),
                        );
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
