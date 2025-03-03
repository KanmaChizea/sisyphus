import 'package:sisyphus/navigation/navigation_service.dart';
import 'package:sisyphus/utils/helpers/dio.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void init() {
  sl.registerLazySingleton<NavigationService>(
    () => NavigationService(navigatorKey: navigatorKey),
  );

  sl.registerLazySingleton<Dio>(() => DioHelper.instance);
}
