import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/constant/locale_keys.dart';
import 'package:krishi_hub/common/utils/size_utils.dart';
import 'package:krishi_hub/common/widget/app_bar/custom_app_bar.dart';
import 'package:krishi_hub/feature/employee/ui/widget/elective_representive_widget.dart';
import 'package:krishi_hub/feature/employee/ui/widget/employee_list_widget.dart';
import 'package:krishi_hub/feature/employee/ui/widget/tab_bar_widget.dart';

class PalikaContactWidget extends StatefulWidget {
  const PalikaContactWidget({super.key});

  @override
  State<PalikaContactWidget> createState() => _RepresentativesWidgetState();
}

class _RepresentativesWidgetState extends State<PalikaContactWidget>
    with SingleTickerProviderStateMixin {
  final ValueNotifier<int> _currentIndex = ValueNotifier(0);
  late TabController _tabController;

  final List<String> _items = [
    LocaleKeys.electedrepresentative.tr(),
    LocaleKeys.employee.tr(),
  ];

  @override
  void initState() {
    _tabController = TabController(length: _items.length, vsync: this);
    // fetchEmployee();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
        appBar: CustomAppBar(
          title: LocaleKeys.palikaContact.tr(),
          centerMiddle: false,
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: CustomTheme.symmetricHozPadding.wp),
              child: TabBarWidget(
                selectedIndex: _currentIndex,
                items: _items,
                onChanged: (value) {
                  _currentIndex.value = value;
                  _tabController.animateTo(value);
                },
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: const [
                  ElectiveRepresentivewidget(),
                  EmployeeWidget(),
                ],
              ),
            ),
          ],
        ));
  }
}
