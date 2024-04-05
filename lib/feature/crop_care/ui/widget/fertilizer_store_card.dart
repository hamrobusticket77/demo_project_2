import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:krishi_hub/common/common_card_wapper.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/widget/button/custom_view_button.dart';
import 'package:krishi_hub/common/widget/text_tile_widget.dart';
import 'package:krishi_hub/feature/crop_care/model/fertilizer_store_model.dart';
import 'package:krishi_hub/feature/crop_care/ui/page/fertilizer_store_detail_page.dart';

class FertilizerStoreCard extends StatelessWidget {
  final FertilizerStoreModel fertilizerStoreModel;
  const FertilizerStoreCard({
    super.key,
    required this.fertilizerStoreModel,
  });

  @override
  Widget build(BuildContext context) {
    return CommonCardWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextTileWidget(
            title: LocaleKeys.fullname.tr(),
            subTitle: fertilizerStoreModel.name,
          ),
          TextTileWidget(
            title: LocaleKeys.address.tr(),
            subTitle: fertilizerStoreModel.address,
          ),
          TextTileWidget(
            title: LocaleKeys.email.tr(),
            subTitle: fertilizerStoreModel.email,
          ),
          CustomViewIcons(
            onpress: () {
              NavigationService.push(
                  target: FertilizerStoreDetailPage(
                fertilizerStoreModel: fertilizerStoreModel,
              ));
            },
          )
          // TextTileWidget(
          //   onTapSubTitle: () {
          //     UrlLauncherUtils.launchPhone(fertilizerStoreModel.phoneNumber);
          //   },
          //   title: LocaleKeys.phoneNumber.tr(),
          //   subTitle: fertilizerStoreModel.phoneNumber,
          // ),
          // TextTileWidget(
          //   title: LocaleKeys.address.tr(),
          //   subTitle: fertilizerStoreModel.storeAddress,
          // ),
        ],
      ),
    );
  }
}
