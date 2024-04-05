import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';

class HomeServiceTitleWidget extends StatelessWidget {
  final String title;
  final bool hasViewAll;
  final Function()? onPressed;
  const HomeServiceTitleWidget({
    super.key,
    required this.title,
    this.hasViewAll = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: textTheme.displaySmall,
            ),
            if (hasViewAll)
              Material(
                child: InkWell(
                  borderRadius: BorderRadius.circular(5),
                  onTap: onPressed,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      LocaleKeys.viewall.tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 13,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
