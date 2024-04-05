// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:nagarpalika_services_mobile_app/common/app/theme.dart';
// import 'package:nagarpalika_services_mobile_app/common/constant/constant_assets.dart';
// import 'package:nagarpalika_services_mobile_app/common/constant/locale_keys.dart';
// import 'package:nagarpalika_services_mobile_app/common/navigation/navigation_service.dart';
// import 'package:nagarpalika_services_mobile_app/common/route/route.dart';
// import 'package:nagarpalika_services_mobile_app/common/utils/size_utils.dart';
// import 'package:nagarpalika_services_mobile_app/feature/home/ui/widget/information_card_widget.dart';

// class InformationWidget extends StatelessWidget {
//   const InformationWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GridView(
//       physics: const BouncingScrollPhysics(),
//       shrinkWrap: true,
//       scrollDirection: Axis.horizontal,
//       padding: EdgeInsets.symmetric(
//           horizontal: CustomTheme.symmetricHozPadding.wp, vertical: 5.hp),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 1,
//         childAspectRatio: 1 / 2,
//         crossAxisSpacing: 20,
//         mainAxisSpacing: 20,
//       ),
//       children: [
//         InformationCardWidget(
//             svgPath: Assets.about,
//             serviceTitle: LocaleKeys.aboutUs.tr(),
//             onPressed: () {
//               NavigationService.pushNamed(routeName: Routes.aboutUsPage);
//             }),
//         InformationCardWidget(
//             svgPath: Assets.feedBack,
//             serviceTitle: LocaleKeys.representativesAndEmployee.tr(),
//             onPressed: () {
//               NavigationService.pushNamed(routeName: Routes.representativePage);
//             }),
//         InformationCardWidget(
//             svgPath: Assets.employment,
//             serviceTitle: LocaleKeys.totalRecords.tr(),
//             onPressed: () {
//               NavigationService.pushNamed(routeName: Routes.recordPage);
//             }),
//         InformationCardWidget(
//             svgPath: Assets.feedBack,
//             serviceTitle: LocaleKeys.frequentlyAskQuestion.tr(),
//             onPressed: () {
//               NavigationService.pushNamed(routeName: Routes.faqPage);
//             }),
//       ],
//     );
//   }
// }
