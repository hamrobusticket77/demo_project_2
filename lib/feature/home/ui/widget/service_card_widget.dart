// import 'package:flutter/material.dart';
// import 'package:nagarpalika_services_mobile_app/common/app/theme.dart';
// import 'package:nagarpalika_services_mobile_app/common/widget/button/custom_icon_button.dart';

// class ServiceCardWidget extends StatelessWidget {
//   final String serviceTitle;
//   final Function() onPressed;
//   final String svgPath;
//   final IconData icon;
//   final Color? backGroundColor;
//   final double fontSize;
//   final double borderRadius;
//   final double iconSize;

//   const ServiceCardWidget(
//       {super.key,
//       required this.serviceTitle,
//       required this.onPressed,
//       required this.svgPath,
//       required this.icon,
//       this.backGroundColor,
//       this.fontSize = 12,
//       this.borderRadius = 20,
//       this.iconSize = 18});

//   @override
//   Widget build(BuildContext context) {
//     final textTheme = Theme.of(context).textTheme;
//     return Material(
//       elevation: 0.1,
//       borderRadius: BorderRadius.circular(borderRadius),
//       child: InkWell(
//         onTap: onPressed,
//         borderRadius: BorderRadius.circular(borderRadius),
//         child: Container(
//           decoration: BoxDecoration(
//             // color: CustomTheme.primarymaterialcolorAccent.shade100
//             //     .withOpacity(0.2),
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 CustomTheme.primarymaterialcolorAccent.shade100
//                     .withOpacity(0.45),
//                 CustomTheme.primarymaterialcolorAccent.shade100
//                     .withOpacity(0.1),

//                 // Theme.of(context).primaryColor,
//               ],
//             ),
//             borderRadius: BorderRadius.circular(
//               borderRadius,
//             ),
//           ),
//           padding: const EdgeInsets.all(5),
//           child: Center(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 CustomIconButton(
//                   icon: icon,
//                   iconSize: iconSize,
//                   backgroundColor: Theme.of(context).primaryColor.withOpacity(0.07),
//                   iconColor: Theme.of(context).primaryColor,
//                 ),
//                 const SizedBox(height: 10),
//                 Text(
//                   serviceTitle,
//                   textAlign: TextAlign.center,
//                   style: textTheme.labelLarge!.copyWith(fontSize: fontSize),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
