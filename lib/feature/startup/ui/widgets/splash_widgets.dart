import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krishi_hub/common/constant/constant_assets.dart';
import 'package:krishi_hub/common/constant/env.dart';
import 'package:krishi_hub/common/utils/device_info_utils.dart';
import 'package:krishi_hub/feature/auth/resource/auth_repository.dart';
import 'package:krishi_hub/feature/home/resource/home_repository.dart';
import '../../../../common/navigation/navigation_service.dart';
import '../../../../common/route/route.dart';
import '../../../../common/utils/size_utils.dart';

class SplashWidget extends StatefulWidget {
  const SplashWidget({super.key});

  @override
  State<SplashWidget> createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
  @override
  void initState() {
    Future.sync(() {
      RepositoryProvider.of<HomeRepository>(context).deviceConfig();
      RepositoryProvider.of<AuthRepository>(context).initial();
      DeviceInfoUtils.setAppVersion();
      Future.delayed(const Duration(seconds: 1)).then((value) {
        NavigationService.pushNamedReplacement(routeName: Routes.dashboardPage);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final env = RepositoryProvider.of<Env>(context);
    SizeUtils.init(context: context);

    return Scaffold(
      // bottomNavigationBar: SizedBox(
      //   height: 100,
      //   child: Row(
      //     mainAxisSize: MainAxisSize.min,
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Column(
      //         children: [
      //           Text(
      //            "",
      //             style: textTheme.bodyLarge,
      //           ),
      //           const SizedBox(height: 4),
      //           Text(
      //             "",
      //             style: textTheme.bodySmall!
      //                 .copyWith(fontStyle: FontStyle.italic),
      //           ),
      //         ],
      //       )
      //     ],
      //   ),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              Assets.appIcon,
              height: 100.hp,
              width: 100.wp,
            ),
            SizedBox(height: 24.hp),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.hp),
              child: Text(env.environment.appTitle,
                  textAlign: TextAlign.center,
                  style: textTheme.displaySmall!
                      .copyWith(color: Theme.of(context).primaryColor)),
            ),
            SizedBox(height: 24.hp),
          ],
        ),
      ),
    );
  }
}
