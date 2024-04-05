import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/image/custom_network_image.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/button/custom_icon_button.dart';
import 'package:krishi_hub/feature/news/model/news_model.dart';

showNoticeDialog(
    {required BuildContext context, required NewsModel newsModel}) {
  showDialog(
    context: context,
    builder: ((context) => Dialog(
          insetPadding: EdgeInsets.symmetric(
              horizontal: CustomTheme.symmetricHozPadding.wp, vertical: 20.hp),
          child: Padding(
              padding: EdgeInsets.all(10.wp),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Text(
                          newsModel.title,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      CustomIconButton(
                        icon: Icons.cancel_rounded,
                        iconColor: Theme.of(context).primaryColor,
                        onPressed: () {
                          NavigationService.pop();
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.hp,
                  ),
                  CustomNetWorkImage(
                    imageUrl: newsModel.media.medias.first.path,
                  ),
                ],
              )),
        )),
  );
}
