import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/button/custom_icon_button.dart';

class CommonDropDownWrapper extends StatelessWidget {
  final Widget child;

  final String title;
  final VoidCallback? onSearch;
  const CommonDropDownWrapper(
      {super.key,
      required this.child,
      required,
      required this.title,
      this.onSearch});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      insetPadding: EdgeInsets.symmetric(
          horizontal: CustomTheme.symmetricHozPadding.wp, vertical: 50.hp),
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.hp, vertical: 20.hp),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20.hp),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: textTheme.headlineSmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  if (onSearch != null)
                    const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [],
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  child
                  // Expanded(child: child),
                ],
              ),
            ),
            Positioned(
                right: 10,
                top: 10,
                child: CustomIconButton(
                  icon: Icons.cancel,
                  iconColor: CustomTheme.grey,
                  onPressed: () {
                    NavigationService.pop();
                  },
                ))
          ],
        ),
      ),
    );
  }
}
