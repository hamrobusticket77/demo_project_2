import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';

class DismissableWrapper extends StatelessWidget {
  final Widget child;
  final bool isDisable;
  final EdgeInsetsGeometry? margin;
  final Function(DismissDirection direction) onDismissed;
  final Future<bool> Function(DismissDirection direction) onConfirmDismiss;
  final String id;
  final DismissDirection dismissDirection;

  const DismissableWrapper(
      {super.key,
      this.margin,
      required this.child,
      this.isDisable = false,
      required this.onDismissed,
      required this.onConfirmDismiss,
      required this.id,
      this.dismissDirection = DismissDirection.horizontal});

  @override
  Widget build(BuildContext context) {
    return isDisable
        ? child
        : Dismissible(
            direction: dismissDirection,
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.startToEnd) {
              } else {
                onDismissed(direction);
              }
              return onConfirmDismiss(direction);
            },
            onDismissed: (direction) {
              onDismissed(direction);
            },
            background: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: CustomTheme.lightGray,
              ),
              margin: margin ??
                  EdgeInsets.symmetric(
                      horizontal: CustomTheme.symmetricHozPadding.wp,
                      vertical: 10.hp),
              child: Icon(
                Icons.edit_square,
                color: Theme.of(context).primaryColor,
              ),
            ),
            secondaryBackground: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: CustomTheme.red,
              ),
              margin: margin ??
                  EdgeInsets.symmetric(
                      horizontal: CustomTheme.symmetricHozPadding.wp,
                      vertical: 10.hp),
              child: const Icon(
                Icons.delete,
                color: CustomTheme.white,
              ),
            ),
            key: Key(id),
            child: child,
          );
  }
}
