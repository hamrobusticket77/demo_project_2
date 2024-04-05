import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/common_card_wapper.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/utils/text_utils.dart';
import 'package:krishi_hub/common/utils/url_luncher_utils.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/common/widget/text_tile_list_widget.dart';
import 'package:krishi_hub/common/widget/text_tile_widget.dart';
import 'package:krishi_hub/feature/phone_book/model/phone_book_model.dart';

class PhoneBookDetailWidget extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final PhoneBookModel phoneBookModel;

  const PhoneBookDetailWidget({
    super.key,
    required this.phoneBookModel,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.subOfficeDetail.tr(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 7.hp,
            ),
            // ...List.generate(phoneBookModel.offices.first.subOffices.length,
            //     (index) {
            //   final subOffice = phoneBookModel.offices.first.subOffices[index];
            //   return CommonCardWrapper(
            //     margin: margin ??
            //         EdgeInsets.symmetric(
            //           horizontal: CustomTheme.symmetricHozPadding.wp,
            //           vertical: 8.hp,
            //         ),
            //     child: Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         TextTileWidget(
            //           title: LocaleKeys.office.tr(),
            //           subTitle: subOffice.title,
            //         ),
            //         // Column(
            //         //   crossAxisAlignment: CrossAxisAlignment.start,
            //         //   children: subOffice.phoneNumbers
            //         //       .map((phoneNumber) => TextTileWidget(
            //         //             onTapSubTitle: () {
            //         //               UrlLauncherUtils.launchPhone(
            //         //                   phoneNumber.phoneNumber);
            //         //             },
            //         //             title: LocaleKeys.phoneNumber.tr(),
            //         //             subTitle: phoneNumber.phoneNumber,
            //         //           ))
            //         //       .toList(),
            //         // ),

            //         TextTileListWidget(
            //           title: LocaleKeys.phoneNumber.tr(),
            //           onTapSubTitle: (index) {
            //             UrlLauncherUtils.launchPhone(
            //                 subOffice.phoneNumbers[index].phoneNumber);
            //           },
            //           subTitle: subOffice.phoneNumbers
            //               .map((e) => e.phoneNumber.toNepali())
            //               .toList(),
            //         ),
            //         TextTileWidget(
            //           title: LocaleKeys.socialMediaName.tr(),
            //           subTitle: subOffice.socialMedia
            //               .map((title) => title.title)
            //               .join('\n'),
            //         ),
            //         // TextTileWidget(
            //         //   title: LocaleKeys.socalMediaUrl.tr(),
            //         //   subTitle: subOffice.socialMedia
            //         //       .map((url) => url.url)
            //         //       .join('\n'),
            //         // ),

            //         TextTileListWidget(
            //           title: LocaleKeys.socalMediaUrl.tr(),
            //           onTapSubTitle: (index) {
            //             UrlLauncherUtils.launchCustomUrl(
            //               subOffice.socialMedia[index].url,
            //             );
            //           },
            //           subTitle:
            //               subOffice.socialMedia.map((e) => e.url).toList(),
            //         ),
            //         TextTileWidget(
            //           onTapSubTitle: () {
            //             UrlLauncherUtils.launchEmail(subOffice.email);
            //           },
            //           title: LocaleKeys.email.tr(),
            //           subTitle: subOffice.email,
            //         ),
            //         TextTileWidget(
            //             title: LocaleKeys.websiteUrl.tr(),
            //             subTitle: subOffice.websiteUrl,
            //             onTapSubTitle: () {
            //               UrlLauncherUtils.launchCustomUrl(
            //                   subOffice.websiteUrl);
            //             }),
            //       ],
            //     ),
            //   );
            // }),
          ],
        ),
      ),
    );
  }
}
