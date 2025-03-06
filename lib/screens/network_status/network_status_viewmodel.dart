import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sisyphus/core/dependency_injection/injection_container.dart';
import 'package:sisyphus/navigation/navigation_service.dart';
import 'package:sisyphus/screens/network_status/network_staus_state.dart';
import 'package:sisyphus/utils/helpers/network_status_checker.dart';

class NetworkStatusViewmodel extends Cubit<NetworkStatusState> {
  NetworkStatusViewmodel(bool mounted)
    : super(const NetworkStatusState(isLoading: true)) {
    initialize(mounted);
  }

  final networkChecker = sl.get<NetworkStatusChecker>();
  final navigator = sl.get<NavigationService>();

  initialize(bool mounted) {
    emit(state.copyWith(isLoading: true));
    networkChecker.checkNetworkStatus().then((status) {
      emit(state.copyWith(isLoading: false, status: status));
    });
  }

  void goHome() => navigator.replace('/home');
}
