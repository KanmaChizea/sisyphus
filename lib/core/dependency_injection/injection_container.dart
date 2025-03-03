import 'package:app_template/navigation/navigation_service.dart';
import 'package:app_template/utils/helpers/dio.dart';
import 'package:app_template/utils/helpers/local_storage.dart';
import 'package:app_template/utils/helpers/secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void init() {
  sl.registerLazySingleton<NavigationService>(
    () => NavigationService(navigatorKey: navigatorKey),
  );

  sl.registerLazySingleton<SecureStorageHelper>(() => SecureStorageHelper());

  sl.registerLazySingleton<LocalStorage>(() => LocalStorage());

  sl.registerLazySingleton<Dio>(() => DioHelper.instance);
}
