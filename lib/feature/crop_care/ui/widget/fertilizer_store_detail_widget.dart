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
import 'package:krishi_hub/feature/crop_care/cubit/get_doctor_recordid_cubit.dart';
import 'package:krishi_hub/feature/crop_care/cubit/get_fertilierstoreDetail.dart';
import 'package:krishi_hub/feature/crop_care/model/doctor_record_model.dart';
import 'package:krishi_hub/feature/crop_care/model/fertilizer_store_model.dart';
import 'package:krishi_hub/feature/crop_care/ui/widget/doctor_record_detail.dart';

class FertilizerStoreDetail extends StatefulWidget {
  const FertilizerStoreDetail({super.key});

  @override
  State<FertilizerStoreDetail> createState() => _FertilizerStoreDetailState();
}

class _FertilizerStoreDetailState extends State<FertilizerStoreDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.details.tr(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<GetFertilizerStoreDetailCubit, CommonState>(
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
                  return const Center(child: CommonNoDataWidget());
                } else if (state is CommonStateSuccess<FertilizerStoreModel>) {
                  return Column(
                    children: [
                      CommonCardWrapper(
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
                            CommonTextWidget(
                              title: LocaleKeys.phoneNumber.tr(),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:
                                  state.data.phoneNumber.map((phoneNumber) {
                                return Text(
                                  phoneNumber,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                );
                              }).toList(),
                            ),
                            Divider(
                              color: Theme.of(context).primaryColor,
                            ),
                            const CommonTextWidget(
                              title: "Contact Person",
                            ),
                            Column(
                              children:
                                  state.data.contactPersons.map((contatperson) {
                                return SizedBox(
                                  child: Column(
                                    children: [
                                      TextTileWidget(
                                        title: LocaleKeys.name.tr(),
                                        subTitle: contatperson.name,
                                      ),
                                      TextTileWidget(
                                        title: LocaleKeys.phoneNumber.tr(),
                                        subTitle: contatperson.phoneNumber,
                                      )
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                            Divider(
                              color: Theme.of(context).primaryColor,
                            ),
                            CommonTextWidget(
                              title: LocaleKeys.productTitle.tr(),
                            ),
                            Column(
                              children: state.data.products.map((product) {
                                return SizedBox(
                                  child: Column(
                                    children: [
                                      TextTileWidget(
                                        title: LocaleKeys.type.tr(),
                                        subTitle: product.category.type,
                                      ),
                                      TextTileWidget(
                                        title: LocaleKeys.prodcutCategory.tr(),
                                        subTitle: product.category.title,
                                      ),
                                      TextTileWidget(
                                        title: LocaleKeys.productTitle.tr(),
                                        subTitle: product.title,
                                      )
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                            Divider(
                              color: Theme.of(context).primaryColor,
                            ),
                            CommonTextWidget(
                              title: LocaleKeys.image.tr(),
                            ),
                            Column(
                              children: state.data.media.map((image) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: CustomNetWorkImage(
                                    imageUrl: (image.path.isNotEmpty)
                                        ? image.path
                                        : "",
                                    boxFit: BoxFit.cover,
                                    height: 100.hp,
                                    width: 80.wp,
                                  ),
                                );
                              }).toList(),
                            )
                          ],
                        ),
                      )
                    ],
                  );
                }
                return SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
