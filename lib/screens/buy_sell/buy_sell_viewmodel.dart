import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sisyphus/core/dependency_injection/injection_container.dart'
    show sl;
import 'package:sisyphus/navigation/navigation_service.dart';
import 'package:sisyphus/screens/buy_sell/buy_sell_state.dart';
import 'package:sisyphus/utils/helpers/formatters.dart';

class BuySellViewmodel extends Cubit<BuySellState> {
  BuySellViewmodel() : super(BuySellState.initial());

  final _navigator = sl.get<NavigationService>();
  double _limit = 0;
  double _amount = 0;

  void togglePostOnly(bool value) {
    emit(state.copyWith(postOnly: value));
  }

  void selectCurrency(String? value) {
    emit(state.copyWith(selectedCurrency: value));
  }

  void selectOrderType(TypeOptions? value) {
    emit(state.copyWith(selectedType: value));
  }

  void onLimitChange(String value) {
    final numberValue = Formatters.parseFormattedNumber(value);
    _limit = numberValue;
    emit(state.copyWith(totalValue: numberValue * _amount));
  }

  void onAmountChange(String value) {
    final numberValue = Formatters.parseFormattedNumber(value);
    _amount = numberValue;
    emit(state.copyWith(totalValue: numberValue * _limit));
  }

  void buyBtc() {
    _navigator.goBack();
  }

  void deposit() {
    _navigator.goBack();
  }
}
