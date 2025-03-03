import 'package:app_template/navigation/navigation_service.dart';
import 'package:app_template/navigation/routes.dart';
import 'package:app_template/theme/colors.dart';
import 'package:app_template/theme/textstyles.dart';
import 'package:flutter/material.dart';
import 'core/dependency_injection/injection_container.dart' as di;

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: navigatorKey,
      theme: Theme.of(context).copyWith(extensions: [
        AppColorsTheme.light(),
        AppTextTheme.main(),
      ]),
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }          
}
