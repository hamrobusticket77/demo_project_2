import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';

class ScreenHeader extends StatelessWidget {
  const ScreenHeader(
      {Key? key,
      required this.title,
      required this.subtitle,
      this.onlyHeader = false,
      this.crossAxisAlignment = CrossAxisAlignment.start})
      : super(key: key);

  final String title, subtitle;
  final CrossAxisAlignment crossAxisAlignment;
  final bool onlyHeader;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        const SizedBox(
            // height: 20,
            ),
        Text(
          title,
          style: TextStyle(
              fontSize: 25,
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w600),
        ),
        if (!onlyHeader)
          const SizedBox(
            height: 10,
          ),
        if (!onlyHeader)
          Text(
            subtitle,
            style: const TextStyle(fontSize: 18, color: CustomTheme.grey),
          ),
        if (!onlyHeader)
          const SizedBox(
            height: 10,
          )
      ],
    );
  }
}
