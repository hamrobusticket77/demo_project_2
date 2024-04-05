import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/app/theme.dart';
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
import 'package:krishi_hub/feature/crop_care/model/doctor_record_model.dart';
import 'package:krishi_hub/feature/crop_care/ui/widget/commonservice_good_purchase_widget.dart';
import 'package:krishi_hub/feature/crop_care/ui/widget/doctor_record_detail.dart';
import 'package:krishi_hub/feature/expertise/cubit/get_expertise_detail_cubit.dart';

class ExpertiseDetailWidget extends StatefulWidget {
  const ExpertiseDetailWidget({super.key});

  @override
  State<ExpertiseDetailWidget> createState() => _ExpertiseDetailWidgetState();
}

class _ExpertiseDetailWidgetState extends State<ExpertiseDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: LocaleKeys.expertis.tr()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<GetExpertiseDetailCubit, CommonState>(
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
                } else if (state is CommonStateSuccess<DoctorRecordModel>) {
                  // return CommonServiceGoodPurchaseWidget(
                  //   doctorRecordModel: state.data,
                  // );
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
                            CommonTextWidget(
                              title: LocaleKeys.expertiseSector.tr(),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: DataTable(
                                // columnSpacing: 15,
                                columns: [
                                  const DataColumn(
                                      label: Text(
                                    'Year of Experience',
                                    style: TextStyle(
                                      color: CustomTheme.black,
                                      fontSize: 14,
                                    ),
                                  )),
                                  const DataColumn(
                                      label: Text(
                                    'Sector',
                                    style: TextStyle(
                                      color: CustomTheme.black,
                                      fontSize: 14,
                                    ),
                                  )),
                                  DataColumn(
                                      label: Text(
                                    LocaleKeys.prodcutCategory.tr(),
                                    style: const TextStyle(
                                      color: CustomTheme.black,
                                      fontSize: 14,
                                    ),
                                  )),
                                ],
                                rows: List.generate(
                                  state.data.sector.length,
                                  (index) => DataRow(
                                    cells: [
                                      DataCell(
                                        Text(
                                          state.data.sector[index]
                                              .yearOfExperience,
                                          style: const TextStyle(
                                            color: CustomTheme.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          state
                                              .data.sector[index].category.type,
                                          style: const TextStyle(
                                            color: CustomTheme.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          state.data.sector[index].category
                                              .title,
                                          style: const TextStyle(
                                            color: CustomTheme.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              color: Theme.of(context).primaryColor,
                            ),
                            CommonTextWidget(
                              title: LocaleKeys.image.tr(),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: state.data.media.map((image) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: CustomNetWorkImage(
                                        imageUrl: (image.path.isNotEmpty)
                                            ? image.path
                                            : "",
                                        boxFit: BoxFit.cover,
                                        height: 100.hp,
                                        width: 80.wp,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
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
