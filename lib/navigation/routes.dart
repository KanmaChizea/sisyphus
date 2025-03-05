import 'package:flutter/material.dart';
import 'package:sisyphus/screens/home/home_view.dart';

abstract class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final routeName = settings.name;
    final builder = getRouteWidget(settings)[routeName];
    if (builder != null) {
      return MaterialPageRoute(builder: builder, settings: settings);
    } else {
      return MaterialPageRoute(
        builder:
            (_) => const Scaffold(body: Center(child: Text('PAGE NOT FOUND'))),
        settings: settings,
      );
    }
  }

  /// Returns a map of all the routes in the app.
  static Map<String, WidgetBuilder> getRouteWidget(RouteSettings settings) => {
    '/': (_) => const HomeView(),
  };
}
