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
import 'package:krishi_hub/feature/crop_care/cubit/getinsurancedirectory_detail_cubit.dart';
import 'package:krishi_hub/feature/crop_care/model/doctor_record_model.dart';
import 'package:krishi_hub/feature/crop_care/ui/widget/commonservice_good_purchase_widget.dart';

class InsuranceDetailWidget extends StatefulWidget {
  const InsuranceDetailWidget({super.key});

  @override
  State<InsuranceDetailWidget> createState() => _InsuranceDetailState();
}

class _InsuranceDetailState extends State<InsuranceDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.insuranceDetail.tr(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<GetInsuranceDirectoryDetailCubit, CommonState>(
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
                  return CommonServiceGoodPurchaseWidget(
                    doctorRecordModel: state.data,
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
