import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';

class BottomNavigationBarWrapper extends StatelessWidget {
  final Widget child;
  final Color backGroundColor;
  const BottomNavigationBarWrapper({
    super.key,
    required this.child,
    this.backGroundColor = CustomTheme.lightGray,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        color: backGroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            child,
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ));
  }
}
