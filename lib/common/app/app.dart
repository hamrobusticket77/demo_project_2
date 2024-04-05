import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:krishi_hub/common/app/notifiication_wrapper.dart';
import 'package:krishi_hub/common/app/theme.dart';
import 'package:krishi_hub/common/app/update_wrapper.dart';
import 'package:krishi_hub/common/constant/env.dart';
import 'package:krishi_hub/common/navigation/navigation_service.dart';
import 'package:krishi_hub/common/route/route.dart';
import 'package:krishi_hub/common/route/route_generator.dart';
import 'package:krishi_hub/common/wrapper/multi_bloc_wrapper.dart';
import 'package:krishi_hub/common/wrapper/multi_repository_wrapper.dart';

class App extends StatelessWidget {
  final Env env;

  const App({Key? key, required this.env}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryWrapper(
      env: env,
      child: MultiBlocWrapper(
        env: env,
        child: UpdateWrapper(
          child: NotificationWrapper(
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              locale: context.locale,
              navigatorKey: NavigationService.navigationKey,
              localizationsDelegates: [
                ...context.localizationDelegates,
              ],
              supportedLocales: context.supportedLocales,
              theme: CustomTheme.lightTheme,
              title: env.environment.appTitle,
              initialRoute: Routes.root,
              onGenerateRoute: RouteGenerator.generateRoute,
            ),
          ),
        ),
      ),
    );
  }
}
