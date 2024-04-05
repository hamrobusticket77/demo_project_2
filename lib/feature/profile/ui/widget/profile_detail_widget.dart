import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/common_card_wapper.dart';
import 'package:krishi_hub/common/constant/constant_assets.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/enum/acadamy_constant.dart';
import 'package:krishi_hub/common/enum/literature_constant.dart';
import 'package:krishi_hub/common/image/custom_network_image.dart';
import 'package:krishi_hub/common/utils/check_locale.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/utils/text_utils.dart';
import 'package:krishi_hub/common/utils/user_listener.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/common/widget/text_tile_widget.dart';
import 'package:krishi_hub/common/enum/gender_constant.dart';
import 'package:krishi_hub/feature/auth/utils/fullname_utils.dart';
import 'package:krishi_hub/feature/profile/constant/farmer_type.dart';

class ProfileDetailsWidget extends StatelessWidget {
  const ProfileDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: CustomAppBar(
          title: LocaleKeys.userDetails.tr(),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              UserListener(builder: (context, user) {
                if (user != null) {
                  return SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.hp),
                        GestureDetector(
                          child: Container(
                            color: CustomTheme.white,
                            padding: EdgeInsets.all(10.hp),
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Center(
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: CustomNetWorkImage(
                                                  imageUrl: user.profileMedia
                                                          .medias.isNotEmpty
                                                      ? user.profileMedia
                                                          .medias[0].path
                                                      : Assets.placeholder,
                                                  boxFit: BoxFit.cover,
                                                  width: 100.wp,
                                                  height: 100.wp,
                                                  placeHolder:
                                                      Assets.userPlaceHolder,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5.wp,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 14.hp),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            SizedBox(height: 8.hp),
                                            Text(
                                              FullNameUtils.getFullName(
                                                firstName: user.firstName,
                                                lastName: user.lastName,
                                                middleName: user.middleName,
                                              ),
                                              style: textTheme.titleLarge,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        CommonCardWrapper(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: 5.hp),
                            Text(
                              "${LocaleKeys.userDetails.tr()} :",
                              style: textTheme.bodyLarge!.copyWith(
                                  color: Theme.of(context).primaryColor),
                            ),
                            SizedBox(height: 10.hp),
                            TextTileWidget(
                              title: LocaleKeys.fullname.tr(),
                              subTitle: FullNameUtils.getFullName(
                                firstName: user.firstName,
                                middleName: user.middleName,
                                lastName: user.lastName,
                              ),
                            ),
                            TextTileWidget(
                                title: LocaleKeys.phoneNumber.tr(),
                                subTitle: user.phoneNumber.toNepali() ?? ""),
                            TextTileWidget(
                                title: LocaleKeys.gender.tr(),
                                subTitle: CheckLocal.check(
                                    GenderConstant.getGenderLocal(
                                        user.gender))),
                            TextTileWidget(
                              title: LocaleKeys.dob.tr(),
                              subTitle: user.dateOfBirth,
                            ),
                            TextTileWidget(
                              title: LocaleKeys.academicQualification.tr(),
                              subTitle: CheckLocal.check(
                                  AcadamyConstant.getAcadamyLocal(
                                      user.academicQualification)),
                            ),
                            TextTileWidget(
                              title: LocaleKeys.literateLevel.tr(),
                              subTitle: CheckLocal.check(
                                  LiteratureConstant.getLitratureLocal(
                                      user.literateLevel)),
                            ),
                            TextTileWidget(
                              title: LocaleKeys.address.tr(),
                              subTitle: user.citizenshipIssuedDistrict,
                            )
                          ],
                        )),

                        CommonCardWrapper(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(height: 5.hp),
                              Text(
                                "${LocaleKeys.landArea.tr()}:",
                                style: textTheme.bodyLarge!.copyWith(
                                    color: Theme.of(context).primaryColor),
                              ),
                              SizedBox(height: 10.hp),
                              TextTileWidget(
                                title: LocaleKeys.biggha.tr(),
                                subTitle: user.landArea.biggha.toNepali(),
                              ),
                              TextTileWidget(
                                title: LocaleKeys.katha.tr(),
                                subTitle: user.landArea.katha.toNepali(),
                              ),
                              TextTileWidget(
                                title: LocaleKeys.dhur.tr(),
                                subTitle: user.landArea.dhur.toNepali(),
                              )
                            ],
                          ),
                        ),
                        CommonCardWrapper(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: 5.hp),
                            Text(
                              "${LocaleKeys.yearlyTurnOver.tr()} :",
                              style: textTheme.bodyLarge!.copyWith(
                                  color: Theme.of(context).primaryColor),
                            ),
                            SizedBox(height: 10.hp),
                            TextTileWidget(
                              title: LocaleKeys.agriculture.tr(),
                              subTitle:
                                  "${LocaleKeys.rs.tr()} ${user.yearlyTurnOver.agriculture.toString().toNepali().tr()}",
                            ),
                            TextTileWidget(
                              title: LocaleKeys.nonAgriculture.tr(),
                              subTitle:
                                  "${LocaleKeys.rs.tr()} ${user.yearlyTurnOver.nonAgriculture.toString().toNepali().tr()}",
                            ),
                            TextTileWidget(
                              title: LocaleKeys.total.tr(),
                              subTitle:
                                  "${LocaleKeys.rs.tr()} ${user.yearlyTurnOver.total.toString().toNepali().tr()}",
                            ),
                            TextTileWidget(
                              title: LocaleKeys.averageMonthEngageOnAgriculture
                                  .tr(),
                              subTitle:
                                  " ${user.averageMonthEngageOnAgriculture.toNepali().tr()} ${LocaleKeys.months.tr()}",
                            ),
                            TextTileWidget(
                              title: LocaleKeys.farmerCategory.tr(),
                              // subTitle: user.farmerCategory,
                              subTitle:
                                  CheckLocal.check(FarmerType.getFarmerType(
                                user.farmerCategory,
                              )),
                            ),
                            TextTileWidget(
                              title: LocaleKeys.certificateNumber.tr(),
                              subTitle:
                                  user.certificateNumber.toString().toNepali(),
                            ),
                          ],
                        )),

                        // if (user.meida.isNotEmpty)
                        //   CommonCardWrapper(
                        //       child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.stretch,
                        //     children: [
                        //       SizedBox(height: 5.hp),
                        //       Text(
                        //         "Citizenship Front :",
                        //         style: textTheme.bodyLarge!
                        //             .copyWith(color: Theme.of(context).primaryColor),
                        //       ),
                        //       SizedBox(height: 10.hp),
                        //       CustomCachedNetworkImage(
                        //           placeholder: Assets.placeholder,
                        //           url: user.meida.firstWhere((element) {
                        //             return element.type == "CITIZENSHIP_FRONT";
                        //           }).path,
                        //           fit: BoxFit.contain),
                        //       SizedBox(height: 20.hp),
                        //       Text(
                        //         "Citizenship back :",
                        //         style: textTheme.bodyLarge!
                        //             .copyWith(color: Theme.of(context).primaryColor),
                        //       ),
                        //       SizedBox(height: 10.hp),
                        //       CustomCachedNetworkImage(
                        //           placeholder: Assets.placeholder,
                        //           url: user.meida.firstWhere((element) {
                        //             return element.type == "CITIZENSHIP_BACK";
                        //           }).path,
                        //           fit: BoxFit.contain)
                        //     ],
                        //   ))
                      ],
                    ),
                  );
                }
                return Container();
              }),
            ],
          ),
        ));
  }
}
