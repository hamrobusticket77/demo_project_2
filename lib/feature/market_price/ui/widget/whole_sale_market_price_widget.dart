// import 'package:flutter/material.dart';
// import 'package:krishi_hub/common/utils/size_utils.dart';
// import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
// import 'package:krishi_hub/common/widget/text_tile_widget.dart';
// import 'package:krishi_hub/feature/market_price/model/current_market_price_model.dart';

// import '../../../../common/app/theme.dart';
// import '../../../../common/common_card_wapper.dart';

// class WholeShaleMarketPriceWidget extends StatelessWidget {
//   final EdgeInsetsGeometry? margin;
//   final CurrentMarketPriceModel currentMarketPriceModel;

//   WholeShaleMarketPriceWidget({
//     Key? key,
//     required this.currentMarketPriceModel,
//     this.margin,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final textTheme = Theme.of(context).textTheme;
//     return Scaffold(
//         appBar: const CustomAppBar(
//           title: "थोक बजार",
//         ),
//         body: ListView.builder(
//           shrinkWrap: true,
//           itemCount: currentMarketPriceModel.product.length,
//           itemBuilder: (context, index) {
//             return CommonCardWrapper(
//               margin: margin ??
//                   EdgeInsets.symmetric(
//                       horizontal: CustomTheme.symmetricHozPadding.wp,
//                       vertical: 5.hp),
//               child: Column(
//                 children: [
//                   TextTileWidget(
//                     title: "कृषि उपज",
//                     subTitle: currentMarketPriceModel.product[index].crops,
//                   ),
//                   TextTileWidget(
//                     title: "मिति",
//                     subTitle: currentMarketPriceModel.product[index].date,
//                   ),
//                   TextTileWidget(
//                     title: "खुद्रा न्यूनतम",
//                     subTitle: currentMarketPriceModel
//                         .product[index].wholesalePrice.lowest
//                         .toString(),
//                   ),
//                   TextTileWidget(
//                     title: "खुद्रा अधिकतम",
//                     subTitle: currentMarketPriceModel
//                         .product[index].wholesalePrice.highest
//                         .toString(),
//                   ),
//                   TextTileWidget(
//                     title: "खुद्रा औसत",
//                     subTitle: currentMarketPriceModel
//                         .product[index].wholesalePrice.avgRetailPrice
//                         .toString(),
//                   ),
//                   TextTileWidget(
//                     title: "थोक न्यूनतम",
//                     subTitle: currentMarketPriceModel
//                         .product[index].wholesalePrice.lowest
//                         .toString(),
//                   ),
//                   TextTileWidget(
//                     title: "थोक अधिकतम",
//                     subTitle: currentMarketPriceModel
//                         .product[index].wholesalePrice.highest
//                         .toString(),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ));
//   }
// }
