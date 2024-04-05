import 'package:flutter/material.dart';
import 'package:krishi_hub/common/constant/constant_assets.dart';
import 'package:krishi_hub/common/image/custom_cache_network_image.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/date_formater_utils.dart';

import '../../../../common/app/theme.dart';
import '../../../../common/common_card_wapper.dart';
import '../../../../common/image/custom_network_image.dart';
import '../../model/news_model.dart';

class NewsCard extends StatelessWidget {
  final Function()? onPressed;

  final EdgeInsetsGeometry? margin;

  final NewsModel newsModel;

  const NewsCard({
    super.key,
    required this.newsModel,
    required this.onPressed,
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
          ClipRRect(
              borderRadius: BorderRadius.circular(8.wp),
              child: CustomCachedNetworkImage(
                url: (newsModel.media.medias.isNotEmpty)
                    ? newsModel.media.medias.first.path
                    : "",
                fit: BoxFit.cover,
                height: 100.hp,
                width: 80.wp,
                // placeholder: Assets.news,
              )),
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
                          newsModel.title,
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
                  height: 8.hp,
                ),

                Row(
                  children: [
                    Icon(
                      Icons.calendar_month_outlined,
                      size: 15,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      DateFormatterUtils.convertAdIntoBs(newsModel.createdAt),
                      style: textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.normal,
                        color: CustomTheme.grey,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    )
                  ],
                )

                // Text(
                //   DateFormatterUtils.convertAdIntoBs(newsModel.createdAt),
                //   style: textTheme.titleSmall!.copyWith(
                //     fontWeight: FontWeight.normal,
                //     color: CustomTheme.grey,
                //   ),
                //   overflow: TextOverflow.ellipsis,
                //   maxLines: 1,
                // )
              ],
            ),
          )
        ],
      ),
    );
  }
}
