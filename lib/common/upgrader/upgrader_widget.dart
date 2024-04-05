// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:upgrader/upgrader.dart';

// typedef UpgradeWidgetBuilder = Widget Function(
//   BuildContext context,
//   Upgrader upgrader,
// );

// class UpgradeWidget extends UpgradeBase {
//   UpgradeWidget({
//     Key? key,
//     Upgrader? upgrader,
//     required this.builder,
//   }) : super(upgrader ?? Upgrader.sharedInstance as Upgrader, key: key);

//   final UpgradeWidgetBuilder builder;

//   @override
//   Widget build(BuildContext context, UpgradeBaseState state) {
//     if (upgrader.debugLogging) {
//       log('UpgradeWidget: build UpgradeWidget');
//     }

//     return FutureBuilder(
//       future: state.initialize(),
//       builder: (BuildContext context, AsyncSnapshot<bool> processed) {
//         if (processed.connectionState == ConnectionState.done &&
//             processed.data != null &&
//             processed.data!) {
//           if (upgrader.shouldDisplayUpgrade()) {
//             if (upgrader.debugLogging) {
//               log('UpgradeWidget: will call builder');
//             }
//             return builder.call(context, upgrader);
//           }
//         }

//         return const SizedBox.shrink();
//       },
//     );
//   }
// }
