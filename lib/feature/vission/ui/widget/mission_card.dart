import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
//import 'package:flutter_html/flutter_html.dart';

import 'package:krishi_hub/feature/vission/model/vission_model.dart';

class MissionCard extends StatelessWidget {
  final Function()? onPressed;

  final EdgeInsetsGeometry? margin;

  final MissionModel missionModel;

  const MissionCard({
    super.key,
    required this.missionModel,
    required this.onPressed,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: HtmlWidget(
                  missionModel.visionAndMission,
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
