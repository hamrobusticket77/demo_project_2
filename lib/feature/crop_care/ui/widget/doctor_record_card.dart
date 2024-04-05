import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:krishi_hub/common/common_card_wapper.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/utils/url_luncher_utils.dart';
import 'package:krishi_hub/common/widget/button/custom_view_button.dart';
import 'package:krishi_hub/common/widget/text_tile_widget.dart';
import 'package:krishi_hub/feature/crop_care/model/doctor_record_model.dart';

class DoctorRecordCard extends StatelessWidget {
  final Function() onpress;
  final DoctorRecordModel doctorRecordModel;

  const DoctorRecordCard({
    Key? key,
    required this.onpress,
    required this.doctorRecordModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonCardWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextTileWidget(
            title: LocaleKeys.fullname.tr(),
            subTitle: doctorRecordModel.name,
          ),
          TextTileWidget(
            onTapSubTitle: () {
              UrlLauncherUtils.launchEmail(doctorRecordModel.email);
            },
            title: LocaleKeys.email.tr(),
            subTitle: doctorRecordModel.email,
          ),
          TextTileWidget(
            title: LocaleKeys.address.tr(),
            subTitle: doctorRecordModel.address,
          ),
          CustomViewIcons(
            onpress: onpress,
          )
        ],
      ),
    );
  }
}
