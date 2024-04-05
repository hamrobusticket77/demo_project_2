import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:krishi_hub/common/common_card_wapper.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/image/custom_network_image.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/text_tile_widget.dart';
import 'package:krishi_hub/feature/crop_care/model/doctor_record_model.dart';
import 'package:krishi_hub/feature/crop_care/ui/widget/doctor_record_detail.dart';

class CommonServiceGoodPurchaseWidget extends StatelessWidget {
  final DoctorRecordModel doctorRecordModel;
  const CommonServiceGoodPurchaseWidget({
    super.key,
    required this.doctorRecordModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CommonCardWrapper(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextTileWidget(
                title: LocaleKeys.name.tr(),
                subTitle: doctorRecordModel.name,
              ),
              TextTileWidget(
                title: LocaleKeys.address.tr(),
                // subTitle: state.data.address,
                subTitle: doctorRecordModel.address,
              ),
              TextTileWidget(
                title: LocaleKeys.email.tr(),
                // subTitle: state.data.email,
                subTitle: doctorRecordModel.email,
              ),
              CommonTextWidget(
                title: LocaleKeys.phoneNumber.tr(),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: doctorRecordModel.phoneNumber.map((phoneNumber) {
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
                title: LocaleKeys.image.tr(),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: doctorRecordModel.media.map((image) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CustomNetWorkImage(
                          imageUrl: (image.path.isNotEmpty) ? image.path : "",
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
}
