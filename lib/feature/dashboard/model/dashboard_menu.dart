import 'package:flutter/material.dart';

class DashboardMenu {
  final IconData selectedIcon;
  final IconData unSelectedIcon;
  final Function() onPressed;
  final String title;

  DashboardMenu({
    required this.onPressed,
    required this.selectedIcon,
    required this.title,
    required this.unSelectedIcon,
  });
}
