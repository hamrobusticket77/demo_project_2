import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/common_card_wapper.dart';
import 'package:krishi_hub/common/common_error_widget.dart';
import 'package:krishi_hub/common/common_nodata_widget.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/cubit/data_state.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/common/widget/shimmer/shimmer_widget.dart';
import 'package:krishi_hub/common/widget/text_tile_widget.dart';
import 'package:krishi_hub/feature/crop_care/ui/widget/doctor_record_detail.dart';

import 'package:krishi_hub/feature/phone_book/cubit/get_office_detail_cubit.dart';
import 'package:krishi_hub/feature/phone_book/cubit/get_suboffice_detail_cubit.dart';
import 'package:krishi_hub/feature/phone_book/model/office_model.dart';
import 'package:krishi_hub/feature/phone_book/model/sub_office_model.dart';

class SubOfficeDetailWidget extends StatefulWidget {
  const SubOfficeDetailWidget({super.key});

  @override
  State<SubOfficeDetailWidget> createState() => _SubOfficeDetailState();
}

class _SubOfficeDetailState extends State<SubOfficeDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "SubOffice Detail",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<GetSubOfficeDetailCubit, CommonState>(
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
                } else if (state is CommonStateSuccess<SubofficeModel>) {
                  return Column(
                    children: [
                      CommonCardWrapper(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextTileWidget(
                            title: LocaleKeys.office.tr(),
                            subTitle: state.data.title,
                          ),
                          TextTileWidget(
                            title: LocaleKeys.email.tr(),
                            subTitle: state.data.office.email,
                          ),
                          TextTileWidget(
                            title: LocaleKeys.websiteUrl.tr(),
                            subTitle: state.data.office.websiteUrl,
                          ),
                          TextTileWidget(
                            title: "Department",
                            subTitle: state.data.office.department.title,
                          ),
                          CommonTextWidget(
                            title: LocaleKeys.socalMediaUrl.tr(),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                                state.data.office.socialMedias.length, (index) {
                              return CommonCardWrapper(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextTileWidget(
                                    title: state
                                        .data.office.socialMedias[index].type,
                                    subTitle: state
                                        .data.office.socialMedias[index].url,
                                  ),
                                ],
                              ));
                            }),
                          ),
                          const CommonTextWidget(
                            title: "Contact Detail",
                          ),
                          Column(
                            children: List.generate(
                                state.data.office.contactDetails.length,
                                (index) {
                              return CommonCardWrapper(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextTileWidget(
                                    title: state
                                        .data.office.contactDetails[index].type,
                                    subTitle: state.data.office
                                        .contactDetails[index].number,
                                  ),
                                ],
                              ));
                            }),
                          ),
                        ],
                      ))
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
