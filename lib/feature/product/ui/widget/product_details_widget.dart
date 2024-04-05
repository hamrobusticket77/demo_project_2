import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/common_card_wapper.dart';
import 'package:krishi_hub/common/common_image_list_widget.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/utils/check_locale.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/utils/text_utils.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/common/widget/button/custom_icon_button.dart';
import 'package:krishi_hub/common/widget/text_tile_widget.dart';
import 'package:krishi_hub/feature/product/constant/product_status_constant.dart';
import 'package:krishi_hub/feature/product/model/product_model.dart';
import 'package:krishi_hub/feature/product/ui/page/product_form_page.dart';

class ProductDetailsWidget extends StatelessWidget {
  final ProductModel model;
  const ProductDetailsWidget({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.productTitle.tr(),
        actions: [
          CustomIconButton(
            icon: Icons.edit_note_sharp,
            backgroundColor: Colors.transparent,
            iconColor: CustomTheme.white,
            onPressed: () {
              NavigationService.push(
                  target: ProductFormPage(productModel: model));
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15.hp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Text(
                    "${LocaleKeys.title.tr()}:",
                    style: textTheme.bodyLarge!
                        .copyWith(color: Theme.of(context).primaryColor),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    model.crops.name,
                    style:
                        textTheme.bodyLarge!.copyWith(color: CustomTheme.black),
                  ),
                ],
              ),
              SizedBox(height: 10.hp),
              CommonCardWrapper(
                margin: const EdgeInsets.all(0),
                child: Column(
                  children: [
                    SizedBox(height: 10.hp),
                    TextTileWidget(
                      title: LocaleKeys.category.tr(),
                      subTitle: model.crops.type.name,
                    ),
                    SizedBox(height: 10.hp),
                    TextTileWidget(
                      title: LocaleKeys.title.tr(),
                      subTitle: model.crops.name,
                    ),
                    TextTileWidget(
                      title: LocaleKeys.status.tr(),
                      subTitle: CheckLocal.check(
                        ProductStatusConstant.getProductStatus(
                          model.statusActivity.first.status,
                        ),
                      ),
                    ),
                    TextTileWidget(
                      title: LocaleKeys.unit.tr(),
                      subTitle: model.unit,
                    ),
                    TextTileWidget(
                      title: LocaleKeys.quantity.tr(),
                      subTitle: model.quantity.toString().toNepali(),
                    ),
                    TextTileWidget(
                      title: LocaleKeys.estimatedPricePerUnit.tr(),
                      subTitle:
                          model.estimatedPriceperunit.toString().toNepali(),
                    ),
                    // TextTileWidget(
                    //   title: LocaleKeys.total.tr(),
                    //   subTitle: "asdf",
                    // ),
                    TextTileWidget(
                      title: LocaleKeys.productionDate.tr(),
                      subTitle: model.productionDate,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.hp,
              ),
              if (model.media != null && model.media!.medias.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.image.tr(),
                      style: textTheme.bodyLarge!
                          .copyWith(color: Theme.of(context).primaryColor),
                    ),
                    const SizedBox(
                      height: 6.0,
                    ),
                    CommonImageListWidget(
                        mediaList:
                            model.media!.medias.map((e) => e.path).toList())
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
