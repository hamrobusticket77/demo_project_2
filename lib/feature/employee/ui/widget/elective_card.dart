import 'package:flutter/material.dart';
import 'package:krishi_hub/common/utils/check_locale.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/utils/text_utils.dart';
import 'package:krishi_hub/common/utils/url_luncher_utils.dart';
import 'package:krishi_hub/common/widget/view_image_dialog.dart';
import 'package:krishi_hub/feature/employee/constant/oficialdesignation_constant.dart';
import 'package:krishi_hub/feature/employee/model/elective_representative_model.dart';

import '../../../../common/app/theme.dart';
import '../../../../common/common_card_wapper.dart';
import '../../../../common/image/custom_network_image.dart';

class ElectiveCard extends StatelessWidget {
  final EdgeInsetsGeometry? margin;

  final ElectiveRepresentiveModel electiveModel;

  const ElectiveCard({
    super.key,
    required this.electiveModel,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return CommonCardWrapper(
      margin: margin ??
          EdgeInsets.symmetric(
              horizontal: CustomTheme.symmetricHozPadding.wp, vertical: 10.hp),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              (electiveModel.media.isNotEmpty)
                  ? viewImageDialog(context, electiveModel.media.first.path)
                  : null;
            },
            child: ClipRRect(
                borderRadius: BorderRadius.circular(8.wp),
                child: CustomNetWorkImage(
                  imageUrl: (electiveModel.media.isNotEmpty)
                      ? electiveModel.media.first.path
                      : "",
                  boxFit: BoxFit.cover,
                  height: 100.hp,
                  width: 80.wp,
                )),
          ),
          SizedBox(width: 10.wp),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Text(
                          electiveModel.firstName +
                              electiveModel.middleName +
                              electiveModel.middleName,
                          style: textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.hp,
                ),
                Text(
                  CheckLocal.check(
                      OfficialDesignationConstant.getOfficeDesignation(
                          electiveModel.designation)),
                  style: textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 5.hp,
                ),
                InkWell(
                  onTap: () {
                    electiveModel.phoneNumber.isNotEmpty
                        ? UrlLauncherUtils.launchPhone(
                            electiveModel.phoneNumber)
                        : null;
                  },
                  child: Text(
                    electiveModel.phoneNumber.toNepali(),
                    style: textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).primaryColor),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(
                  height: 5.hp,
                ),
                InkWell(
                  onTap: () {
                    electiveModel.email.isNotEmpty
                        ? UrlLauncherUtils.launchEmail(electiveModel.email)
                        : null;
                  },
                  child: Text(
                    electiveModel.email,
                    style: textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).primaryColor),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(
                  height: 5.hp,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
