import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/common_nodata_widget.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/image/custom_network_image.dart';

import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/common/widget/view_image_dialog.dart';
import 'package:krishi_hub/feature/krishi_knowledge/models/agriculture_type.dart';

class DiseaseDetail extends StatefulWidget {
  final AgricultureType agricultureType;

  const DiseaseDetail({
    super.key,
    required this.agricultureType,
  });

  @override
  State<DiseaseDetail> createState() => _DiseaseDetailState();
}

class _DiseaseDetailState extends State<DiseaseDetail> {
  bool _hasDisease = false;

  @override
  void initState() {
    _checkDisease();
    super.initState();
  }

  _checkDisease() {
    _hasDisease = widget.agricultureType.agricultureName.any((element) {
      return element.disease.isNotEmpty ? true : false;
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: CustomAppBar(
        title: LocaleKeys.diseaseTitle.tr(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: CustomTheme.symmetricHozPadding.wp),
          child: !_hasDisease
              ? const CommonNoDataWidget()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 15.hp),
                    ...List.generate(
                        widget.agricultureType.agricultureName.length, (index) {
                      final value =
                          widget.agricultureType.agricultureName[index];

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ...List.generate(value.disease.length, (i) {
                            final disease = value.disease[i];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                if (i == 0)
                                  Text(
                                    "${value.name.name} ${LocaleKeys.diseaseTitle.tr()}:",
                                    style: textTheme.headlineMedium!.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: CustomTheme.darkGrey),
                                  ),
                                if (i == 0) const Divider(),
                                SizedBox(height: 10.hp),
                                Text(
                                  "${disease.title}:",
                                  style: textTheme.titleLarge!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: CustomTheme
                                          .primarymaterialcolor.shade900),
                                ),
                                SizedBox(height: 10.hp),
                                HtmlWidget(
                                  disease.description,
                                  textStyle: textTheme.bodyLarge!.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: CustomTheme.darkGrey),
                                ),
                                if (disease.media != null &&
                                    disease.media!.medias.isNotEmpty)
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 20.hp,
                                        ),
                                        Row(
                                          children: [
                                            ...List.generate(
                                              disease.media!.medias.length,
                                              (a) {
                                                final path = disease
                                                    .media!.medias[a].path;
                                                return Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        viewImageDialog(
                                                          context,
                                                          path,
                                                        );
                                                      },
                                                      child: CustomNetWorkImage(
                                                        imageUrl: path,
                                                        boxFit: BoxFit.cover,
                                                        height: 100.hp,
                                                        width: 100.wp,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10.wp,
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                SizedBox(height: 20.hp),
                                if (i != value.disease.length - 1)
                                  const Divider(),
                                if (i == value.disease.length - 1)
                                  SizedBox(height: 20.hp),
                              ],
                            );
                          })
                        ],
                      );
                    })
                  ],
                ),
        ),
      ),
    );
  }
}
