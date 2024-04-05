import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';

class DashBoardBottomBar extends StatefulWidget {
  final PageController pageController;
  final ValueNotifier<int> selectedIndex;

  const DashBoardBottomBar(
      {super.key, required this.pageController, required this.selectedIndex});

  @override
  State<DashBoardBottomBar> createState() => _DashBoardBottomBarState();
}

class _DashBoardBottomBarState extends State<DashBoardBottomBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: CustomTheme.white,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: CustomTheme.grey,
      currentIndex: widget.selectedIndex.value,
      selectedFontSize: 0,
      unselectedFontSize: 0,
      onTap: (index) {
        widget.pageController.jumpToPage(index);
        widget.selectedIndex.value = index;
      },
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home_filled),
          label: LocaleKeys.home.tr(),
          activeIcon: const Icon(Icons.home_filled),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.chat_rounded),
          label: LocaleKeys.chatTitle.tr(),
          activeIcon: const Icon(Icons.chat_rounded),
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person),
          label: LocaleKeys.profile.tr(),
          activeIcon: const Icon(Icons.person),
        ),
      ],
    );
  }
}
