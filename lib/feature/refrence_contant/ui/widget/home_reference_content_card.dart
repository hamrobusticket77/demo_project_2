import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/common_card_wapper.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/image/custom_cache_network_image.dart';
import 'package:krishi_hub/common/image/custom_network_image.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/text_tile_widget.dart';
import 'package:krishi_hub/feature/auth/utils/fullname_utils.dart';
import 'package:krishi_hub/feature/refrence_contant/model/reference_content_model.dart';
import 'package:krishi_hub/feature/refrence_contant/ui/page/reference_content_details_page.dart';

class HomeReferenceContentCard extends StatelessWidget {
  final ReferenceContentModel data;

  const HomeReferenceContentCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SizedBox(
      width: (MediaQuery.of(context).size.width - 30.wp),
      child: CommonCardWrapper(
        onTap: () {
          NavigationService.push(
              target: ReferenceContentDetailsPage(
            data: data,
          ));
        },
        hasShadow: true,
        backgroundColor: CustomTheme.white,
        margin: EdgeInsets.all(5.hp),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // TextTileWidget(
            //   title: LocaleKeys.title.tr(),
            //   subTitle: data.title,
            // ),
            // TextTileWidget(
            //   title: "Writer",
            //   subTitle:
            //       "${data.details.firstName.en} ${data.details.lastName.en}",
            // ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              // child: CustomCachedNetworkImage(
              //   url: data.details.profileImage.isNotEmpty
              //       ? data.details.profileImage[index].path
              //       : "",
              //   fit: BoxFit.cover,
              //   height: 75.hp,
              //   width: 75.wp,
              // ),
              child: CustomNetWorkImage(
                imageUrl: (data.details.profileImage.isNotEmpty)
                    ? data.details.profileImage.first.path
                    : "",
                boxFit: BoxFit.cover,
                height: 100.hp,
                width: 80.wp,
              ),
            ),
            SizedBox(
              width: 10.wp,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5.hp),
                  Text(
                    FullNameUtils.getFullName(
                        firstName: data.details.firstName,
                        lastName: data.details.lastName,
                        middleName: data.details.middleName),
                    // textScaleFactor:
                    //     SizeUtils.textScaleFactor,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                    maxLines: 1,
                  ),
                  SizedBox(height: 5.hp),
                  Text(
                    data.createdAt,
                    // textScaleFactor:
                    //     SizeUtils.textScaleFactor,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w400,
                        color: CustomTheme.darkGrey),
                    maxLines: 1,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
