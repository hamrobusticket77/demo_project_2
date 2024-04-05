import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:krishi_hub/common/constant/constant_assets.dart';
import 'package:krishi_hub/common/image/custom_cache_network_image.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/date_formater_utils.dart';

import '../../../../common/app/theme.dart';
import '../../../../common/constant/locale_keys.dart';
import '../../../../common/image/custom_network_image.dart';
import '../../../../common/widget/app_bar/custom_app_bar.dart';
import '../../model/news_model.dart';

class NewsDetailsWidget extends StatelessWidget {
  final NewsModel newsModel;

  const NewsDetailsWidget({
    super.key,
    required this.newsModel,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.referenceMaterial.tr(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    // height: 200,
                    // width: width,
                    child: CustomCachedNetworkImage(
                  url: (newsModel.media.medias.isNotEmpty)
                      ? newsModel.media.medias.first.path
                      : "",
                  fit: BoxFit.fill,
                  // placeholder: Assets.news,
                )),
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
                    DateFormatterUtils.convertAdIntoBs(newsModel.createdAt),
                    style: textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.normal,
                      color: CustomTheme.grey,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  HtmlWidget(
                    newsModel.description,
                    textStyle: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
