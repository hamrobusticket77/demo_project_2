import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/common_card_wapper.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/button/custom_view_button.dart';
import 'package:krishi_hub/common/widget/text_tile_widget.dart';
import 'package:krishi_hub/feature/market_price/model/current_market_price_model.dart';
import 'package:krishi_hub/feature/market_price/ui/pages/current_market_detail_page.dart';

class WholeSalerPriceCard extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final CurrentMarketPriceModel marketPriceModels;

  const WholeSalerPriceCard({
    super.key,
    required this.marketPriceModels,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return CommonCardWrapper(
      margin: margin ??
          EdgeInsets.symmetric(
              horizontal: CustomTheme.symmetricHozPadding.wp, vertical: 5.hp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextTileWidget(
            title: LocaleKeys.name.tr(),
            subTitle: marketPriceModels.name,
          ),
          TextTileWidget(
            title: LocaleKeys.address.tr(),
            subTitle: marketPriceModels.address,
          ),
          CustomViewIcons(
            onpress: () {
              NavigationService.push(
                  target: CurrentMarketDetailPage(
                currentMarketPriceModel: marketPriceModels,
              ));
            },
          )
        ],
      ),
    );
  }
}
