import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/common_card_wapper.dart';
import 'package:krishi_hub/common/image/custom_network_image.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/utils/text_utils.dart';
import 'package:krishi_hub/common/utils/url_luncher_utils.dart';
import 'package:krishi_hub/common/widget/view_image_dialog.dart';
import 'package:krishi_hub/feature/employee/model/employee_model.dart';

class EmployeeCard extends StatelessWidget {
  final Function()? onPressed;

  final EdgeInsetsGeometry? margin;

  final EmployeeModel employeeModel;

  const EmployeeCard({
    super.key,
    required this.employeeModel,
    this.onPressed,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return CommonCardWrapper(
      onTap: onPressed,
      margin: margin ??
          EdgeInsets.symmetric(
              horizontal: CustomTheme.symmetricHozPadding.wp, vertical: 10.hp),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              (employeeModel.media.isNotEmpty)
                  ? viewImageDialog(context, employeeModel.media.first.path)
                  : null;
            },
            child: ClipRRect(
                borderRadius: BorderRadius.circular(8.wp),
                child: CustomNetWorkImage(
                  imageUrl: (employeeModel.media.isNotEmpty)
                      ? employeeModel.media.first.path
                      : "",
                  boxFit: BoxFit.cover,
                  height: 100.hp,
                  width: 80.wp,
                )),
          ),
          SizedBox(width: 10.wp),
          Expanded(
            child: Column(
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
                          employeeModel.firstName +
                              employeeModel.middleName +
                              employeeModel.lastName,
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
                  employeeModel.designation.name,
                  style: textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w500,
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
                    UrlLauncherUtils.launchPhone(employeeModel.phoneNumber);
                  },
                  child: Text(
                    employeeModel.phoneNumber.toNepali(),
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
                    UrlLauncherUtils.launchEmail(employeeModel.email);
                  },
                  child: Text(
                    employeeModel.email,
                    style: textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).primaryColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
