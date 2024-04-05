import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/common_card_wapper.dart';
import 'package:krishi_hub/common/image/custom_cache_network_image.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/utils/text_utils.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/feature/krishi_knowledge/models/agriculture_model.dart';
import 'package:krishi_hub/feature/krishi_knowledge/ui/pages/view_all_data_page.dart';

class KrishiDetailWidget extends StatelessWidget {
  final AgricultureModel krishiModel;

  const KrishiDetailWidget({
    super.key,
    required this.krishiModel,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: CustomTheme.symmetricHozPadding.wp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 20.hp,
                  ),
                  ...List.generate(krishiModel.agricultureType.length, (index) {
                    final data = krishiModel.agricultureType[index];

                    return Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "${"${index + 1} ".toNepali()}.",
                              style: textTheme.headlineSmall!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            Text(
                              data.title.localize(),
                              style: textTheme.headlineSmall!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.hp),
                        ...List.generate(data.agricultureName.length, (index) {
                          final value = data.agricultureName[index];

                          return CommonCardWrapper(
                            onTap: () {
                              NavigationService.push(
                                  target: ViewAllDataPage(
                                agricultureName: value,
                              ));
                            },
                            margin: EdgeInsets.symmetric(vertical: 8.hp),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    value.name.name,
                                    style: textTheme.titleLarge!
                                        .copyWith(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                CustomCachedNetworkImage(
                                  url: value.media.medias.isNotEmpty
                                      ? value.media.medias.first.path
                                      : "",
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ),
                          );
                        }),
                        SizedBox(height: 20.hp),
                      ],
                    );
                  })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
