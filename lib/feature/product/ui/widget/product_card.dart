import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/common_card_wapper.dart';
import 'package:krishi_hub/common/constant/constant_assets.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/image/custom_cache_network_image.dart';
import 'package:krishi_hub/common/image/custom_network_image.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/utils/check_locale.dart';
import 'package:krishi_hub/common/utils/custom_toast.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/utils/text_utils.dart';
import 'package:krishi_hub/common/widget/glass_morphism.dart';
import 'package:krishi_hub/feature/product/constant/product_status_constant.dart';
import 'package:krishi_hub/feature/product/cubit/delete_product_cubit.dart';
import 'package:krishi_hub/feature/product/model/product_model.dart';
import 'package:krishi_hub/feature/product/ui/page/product_details_page.dart';

class ProductCard extends StatelessWidget {
  final ProductModel model;
  const ProductCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return CommonCardWrapper(
      onTap: () {
        NavigationService.push(target: ProductDetailsPage(model: model));
      },
      elevation: 0,
      backgroundColor: CustomTheme.white,
      borderRadius: 0,
      contentPadding: const EdgeInsets.all(0),
      margin: const EdgeInsets.all(0),
      child: Container(
          child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: model.media != null && model.media!.medias.isNotEmpty
                    ? CustomCachedNetworkImage(
                        url: model.media!.medias[0].path,
                        fit: BoxFit.cover,
                        height: 100.hp,
                      )
                    : Image.asset(
                        Assets.placeholder,
                        height: 100.hp,
                        fit: BoxFit.cover,
                      ),
              ),
              SizedBox(
                height: 5.hp,
              ),
              Text(
                model.crops.name,
                style: textTheme.headlineSmall!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(
                height: 2.hp,
              ),
              Row(
                children: [
                  Text(
                    model.crops.type.name,
                    style: textTheme.titleLarge!.copyWith(
                      color: CustomTheme.grey,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: RichText(
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        style: textTheme.bodyLarge!.copyWith(),
                        children: [
                          TextSpan(
                            text:
                                "${LocaleKeys.rs.tr()} ${model.estimatedPriceperunit.toString().toNepali()}",
                            style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: CustomTheme.black,
                                fontSize: 13,
                                fontWeight: FontWeight.w600),
                          ),
                          TextSpan(
                            text: " ${LocaleKeys.per.tr()} ",
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: CustomTheme.darkGrey,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: model.unit,
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: CustomTheme.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  BlocListener<DeleteProductCubit, CommonState>(
                    listener: (context, state) {
                      if (state is CommonError) {
                        CustomToast.error(message: state.message);
                      }
                      if (state is CommonSuccess) {
                        Navigator.pop(context, true);
                        CustomToast.success(
                            message: "Product Delete Successfully");
                      }
                    },
                    child: BlocBuilder<DeleteProductCubit, CommonState>(
                      builder: (context, state) {
                        return InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    LocaleKeys.deleteProduct.tr(),
                                  ),
                                  content: Text(
                                      LocaleKeys.areyousuredeleteproduct.tr()),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(LocaleKeys.cancel.tr()),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        context
                                            .read<DeleteProductCubit>()
                                            .deleteProduct(id: model.id);
                                      },
                                      child: Text(LocaleKeys.delete.tr()),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: const Icon(
                            Icons.delete,
                            color: CustomTheme.red,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
          if (model.statusActivity.isNotEmpty)
            Positioned(
                top: 5,
                right: 5,
                child: GlassMorphism(
                  end: 0.04,
                  start: 0.05,
                  borderRadiusBottom: 5,
                  borderRadiusTop: 5,
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      color: CustomTheme.white,
                      child: Text(
                        CheckLocal.check(
                          ProductStatusConstant.getProductStatus(
                            model.statusActivity[0].status,
                          ),
                        ),
                        style: textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                      )),
                ))
        ],
      )),
    );
  }
}
