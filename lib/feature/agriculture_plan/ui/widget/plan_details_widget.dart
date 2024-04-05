import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/common_card_wapper.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/image/custom_network_image.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/utils/text_utils.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/common/widget/text_tile_widget.dart';
import 'package:krishi_hub/common/widget/view_image_dialog.dart';
import 'package:krishi_hub/feature/agriculture_plan/model/agriculture_plan_model.dart';

class PlanDetailsWidget extends StatelessWidget {
  final AgriculturePlanModel agriculturePlanModel;
  const PlanDetailsWidget({super.key, required this.agriculturePlanModel});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.details.tr(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: CustomTheme.symmetricHozPadding.wp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20.hp),
              Text(
                LocaleKeys.basicdetail.tr(),
                style: textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              ),
              CommonCardWrapper(
                margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10.hp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextTileWidget(
                      title: LocaleKeys.fiscalYear.tr(),
                      subTitle: agriculturePlanModel.fiscalYear.fiscalYear,
                    ),
                    TextTileWidget(
                      title: LocaleKeys.program.tr(),
                      subTitle: agriculturePlanModel.program.title,
                    ),
                    TextTileWidget(
                      title: LocaleKeys.framertype.tr(),
                      subTitle: agriculturePlanModel.farmerType,
                    ),
                    // TextTileWidget(
                    //   title: "
                    //   subTitle: agriculturelistModel.program.title,
                    // ),
                    // TextTileWidget(
                    //   title: LocaleKeys.project.tr(),
                    //   subTitle: agriculturelistModel.program.title,
                    // ),
                  ],
                ),
              ),
              SizedBox(height: 20.hp),
              Text(
                LocaleKeys.moredetail.tr(),
                style: textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              ),
              CommonCardWrapper(
                margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10.hp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextTileWidget(
                      title: LocaleKeys.program.tr(),
                      subTitle: agriculturePlanModel.project.title,
                    ),
                    TextTileWidget(
                      title: LocaleKeys.planningservice.tr(),
                      subTitle: agriculturePlanModel.planningService.services,
                    ),

                    TextTileWidget(
                      title: LocaleKeys.contactpersonname.tr(),
                      subTitle: agriculturePlanModel.contactPersonName,
                    ),
                    TextTileWidget(
                      title: LocaleKeys.benefittedhhs.tr(),
                      subTitle:
                          "${LocaleKeys.rs.tr()} ${agriculturePlanModel.benefittedHHS.toString().toNepali()}",
                    ),
                    TextTileWidget(
                      title: LocaleKeys.totalcost.tr(),
                      subTitle:
                          "${LocaleKeys.rs.tr()} ${agriculturePlanModel.totalCost.toString().toNepali()}",
                    ),
                    TextTileWidget(
                      title: LocaleKeys.municipalityexpectedcost.tr(),
                      subTitle:
                          "${LocaleKeys.rs.tr()} ${agriculturePlanModel.municipalityExpectedCost.toString().toNepali()}",
                    ),

                    TextTileWidget(
                      title: LocaleKeys.landArea.tr(),
                      subTitle:
                          agriculturePlanModel.landArea.toString().toNepali(),
                    ),

                    //
                  ],
                ),
              ),
              SizedBox(height: 20.hp),
              Text(
                LocaleKeys.activities.tr(),
                style: textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              ),
              CommonCardWrapper(
                margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10.hp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      agriculturePlanModel.activities,
                      textAlign: TextAlign.justify,
                      style: textTheme.labelLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: CustomTheme.black.withOpacity(0.9)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.hp),
              if (agriculturePlanModel.remarks.isNotEmpty)
                Text(
                  LocaleKeys.remarks.tr(),
                  style: textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
              if (agriculturePlanModel.remarks.isNotEmpty)
                CommonCardWrapper(
                  margin: EdgeInsets.symmetric(horizontal: 0, vertical: 10.hp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        agriculturePlanModel.remarks,
                        textAlign: TextAlign.justify,
                        style: textTheme.labelLarge!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: CustomTheme.black.withOpacity(0.9)),
                      ),
                    ],
                  ),
                ),
              SizedBox(height: 20.hp),
              if ((agriculturePlanModel.media != null &&
                  agriculturePlanModel.media!.medias.isNotEmpty))
                Column(
                  children: [
                    Text(
                      LocaleKeys.image.tr(),
                      style: textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    ),
                    SizedBox(height: 10.hp),
                    Container(
                      padding: const EdgeInsets.all(0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...List.generate(
                                agriculturePlanModel.media!.medias.length,
                                (index) {
                              return Padding(
                                padding: EdgeInsets.only(left: 10.wp),
                                child: InkWell(
                                  onTap: () {
                                    viewImageDialog(
                                      context,
                                      agriculturePlanModel
                                          .media!.medias[index].path,
                                    );
                                  },
                                  child: SizedBox(
                                    height: 100.hp,
                                    width: 150.wp,
                                    child: CustomNetWorkImage(
                                      imageUrl: agriculturePlanModel
                                          .media!.medias[index].path,
                                      height: 150.hp,
                                      width: 150.wp,
                                      boxFit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            })
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              SizedBox(height: 20.hp),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              )
            ],
          ),
        ),
      ),
    );
  }
}
