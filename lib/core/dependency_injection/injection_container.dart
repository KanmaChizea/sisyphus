import 'package:sisyphus/navigation/navigation_service.dart';
import 'package:sisyphus/services/binance_interface.dart';
import 'package:sisyphus/services/binance_service.dart';

import 'package:get_it/get_it.dart';
import 'package:sisyphus/utils/helpers/network_status_checker.dart';

final sl = GetIt.instance;

void init() {
  sl.registerLazySingleton<NavigationService>(
    () => NavigationService(navigatorKey: navigatorKey),
  );

  sl.registerLazySingleton<IBinanceService>(() => BinanceService());
  sl.registerLazySingleton<NetworkStatusChecker>(() => NetworkStatusChecker());
}
