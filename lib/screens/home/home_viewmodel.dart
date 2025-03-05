import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sisyphus/core/dependency_injection/injection_container.dart';
import 'package:sisyphus/screens/home/home_state.dart';
import 'package:sisyphus/services/binance_interface.dart';

class HomeViewmodel extends Cubit<HomeState> {
  HomeViewmodel() : super(HomeState.initial());

  final _binanceService = sl.get<IBinanceService>();

  void initialize() {
    _binanceService.connect();
    _binanceService.tickerStream.listen((data) {
      emit(state.copyWith(ticker: data));
    });
  }

  void dispose() {
    _binanceService.dispose();
  }
}
