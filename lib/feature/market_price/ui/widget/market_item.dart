import 'package:flutter/material.dart';
import 'package:krishi_hub/common/common_card_wapper.dart';
import 'package:krishi_hub/common/widget/text_tile_widget.dart';
import 'package:krishi_hub/feature/market_price/model/market_price_model.dart';

class MarketItemWidget extends StatelessWidget {
  final MarketPriceModel data;
  const MarketItemWidget({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return CommonCardWrapper(
        child: Column(
      children: [
        Text(
          data.product.title,
          style: textTheme.headlineMedium!.copyWith(color: theme.primaryColor),
        ),
        const Divider(),
        TextTileWidget(
          title: "Survay date",
          subTitle: data.date,
        ),
        TextTileWidget(
          title: "Market Name",
          subTitle: data.market.title,
        ),
        TextTileWidget(
          title: "Product Type",
          subTitle: data.product.category.type,
        ),
        TextTileWidget(
          title: "Product ",
          subTitle: data.product.title,
        )
      ],
    ));
  }
}
