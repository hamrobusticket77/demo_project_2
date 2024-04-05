// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:nagarpalika_services_mobile_app/common/app/theme.dart';
// import 'package:nagarpalika_services_mobile_app/common/utils/size_utils.dart';

// class InformationCardWidget extends StatelessWidget {
//   final String serviceTitle;
//   final Function() onPressed;
//   final String svgPath;

//   const InformationCardWidget(
//       {super.key,
//       required this.serviceTitle,
//       required this.onPressed,
//       required this.svgPath});

//   @override
//   Widget build(BuildContext context) {
//     final textTheme = Theme.of(context).textTheme;
//     return Material(
//       elevation: 0.1,
//       borderRadius: BorderRadius.circular(10),
//       child: InkWell(
//         onTap: onPressed,
//         borderRadius: BorderRadius.circular(10),
//         child: Container(
//           decoration: BoxDecoration(
//             color: CustomTheme.primaryShdowColor.withOpacity(0.06),
//             borderRadius: BorderRadius.circular(
//               10,
//             ),
//           ),
//           padding: EdgeInsets.symmetric(horizontal: 10.wp, vertical: 6.hp),
//           child: Center(
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Expanded(
//                   flex: 1,
//                   child: SvgPicture.asset(
//                     svgPath,
//                     height: 40,
//                     width: 40,
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   flex: 2,
//                   child: Text(
//                     serviceTitle,
//                     style: textTheme.labelLarge,
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
