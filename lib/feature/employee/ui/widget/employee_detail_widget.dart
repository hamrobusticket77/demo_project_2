import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/image/custom_network_image.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/feature/employee/model/employee_model.dart';

class EmployeeDetailsWidget extends StatelessWidget {
  final EmployeeModel employeeModel;

  const EmployeeDetailsWidget({
    super.key,
    required this.employeeModel,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              child: SizedBox(
                height: 200,
                width: width,
                child: CustomNetWorkImage(
                  imageUrl: (employeeModel.media.isNotEmpty)
                      ? employeeModel.media.first.path
                      : "",
                  boxFit: BoxFit.fitWidth,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: CustomTheme.symmetricHozPadding.wp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 24.hp,
                  ),
                  Text(
                    employeeModel.designation.name,
                    style: textTheme.displaySmall!,
                  ),
                  SizedBox(
                    height: 10.hp,
                  ),
                  Text(
                    employeeModel.position.name,
                    style: textTheme.bodyMedium!
                        .copyWith(color: CustomTheme.black.withOpacity(0.8)),
                  ),
                  Text(
                    employeeModel.department.name,
                    style: textTheme.bodyMedium!
                        .copyWith(color: CustomTheme.black.withOpacity(0.8)),
                  ),
                  SizedBox(
                    height: 20.hp,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.comingSoon.tr(),
                        textAlign: TextAlign.start,
                        style: textTheme.labelMedium!.copyWith(
                            color: CustomTheme.black.withOpacity(0.5)),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.hp),
                  // CommonImageListWidget(
                  //     mediaList: newsModel.media.map((e) => e.path).toList()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
