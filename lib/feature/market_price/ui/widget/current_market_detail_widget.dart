import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/common_card_wapper.dart';
import 'package:krishi_hub/common/common_error_widget.dart';
import 'package:krishi_hub/common/common_nodata_widget.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/image/custom_network_image.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/common/widget/shimmer/shimmer_widget.dart';
import 'package:krishi_hub/common/widget/text_tile_widget.dart';
import 'package:krishi_hub/feature/crop_care/ui/widget/doctor_record_detail.dart';
import 'package:krishi_hub/feature/market_price/cubit/get_current_marker_price_detail_cubit.dart';
import 'package:krishi_hub/feature/market_price/model/current_market_price_model.dart';

class CurrentMarketDetail extends StatefulWidget {
  const CurrentMarketDetail({super.key});

  @override
  State<CurrentMarketDetail> createState() => _CurrentMarketDetailState();
}

class _CurrentMarketDetailState extends State<CurrentMarketDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<GetCurrentMarketPriceDetailCubit, CommonState>(
                builder: (context, state) {
              if (state is CommonLoading) {
                return ListViewPlaceHolder(
                  itemHeight: 100.hp,
                );
              } else if (state is CommonError) {
                return CommonErrorWidget(
                  message: state.message,
                );
              } else if (state is CommonNoData) {
                return const Center(
                  child: CommonNoDataWidget(),
                );
              } else if (state is CommonStateSuccess<CurrentMarketPriceModel>) {
                return CommonCardWrapper(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextTileWidget(
                      title: LocaleKeys.name.tr(),
                      subTitle: state.data.name,
                    ),
                    TextTileWidget(
                      title: LocaleKeys.address.tr(),
                      subTitle: state.data.address,
                    ),
                    TextTileWidget(
                      title: LocaleKeys.email.tr(),
                      subTitle: state.data.email,
                    ),
                    Column(
                        children: List.generate(state.data.phoneNumber.length,
                            (index) {
                      return TextTileWidget(
                        title: LocaleKeys.phoneNumber.tr(),
                        subTitle: state.data.phoneNumber[index],
                      );
                    })),
                    CommonTextWidget(
                      title: LocaleKeys.contactus.tr(),
                    ),
                    Column(
                      children: List.generate(
                        state.data.contactPersons.length,
                        (index) {
                          return TextTileWidget(
                            title: state.data.contactPersons[index].name,
                            subTitle:
                                state.data.contactPersons[index].phoneNumber,
                          );
                        },
                      ),
                    ),
                    CommonTextWidget(
                      title: LocaleKeys.productTitle.tr(),
                    ),
                    Column(
                      children: List.generate(
                        state.data.products.length,
                        (index) {
                          return TextTileWidget(
                            title: state.data.products[index].title,
                            subTitle: state.data.products[index].category.title,
                          );
                        },
                      ),
                    ),
                    CommonTextWidget(
                      title: LocaleKeys.image.tr(),
                    ),
                    Row(
                      children: List.generate(state.data.media.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CustomNetWorkImage(
                              imageUrl: state.data.media[index].path,
                              boxFit: BoxFit.cover,
                              height: 100.hp,
                              width: 80.wp,
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ));
              }
              return const SizedBox();
            })
          ],
        ),
      ),
    );
  }
}
