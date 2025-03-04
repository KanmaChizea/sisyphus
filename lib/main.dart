import 'package:sisyphus/navigation/navigation_service.dart';
import 'package:sisyphus/navigation/routes.dart';
import 'package:sisyphus/theme/colors.dart';
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
      title: 'Sisyphus',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      // themeMode: ThemeMode.dark,
      themeMode: ThemeMode.system,
      theme: ThemeData(extensions: [AppColorsTheme.light()]),
      darkTheme: ThemeData(extensions: [AppColorsTheme.dark()]),
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
