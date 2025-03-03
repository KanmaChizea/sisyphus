import 'package:app_template/core/dependency_injection/injection_container.dart';
import 'package:app_template/navigation/navigation_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum StartupState { initial, login, home }

class StartupViewmodel extends Cubit<StartupState> {
  StartupViewmodel() : super(StartupState.initial);

  final _navigator = sl.get<NavigationService>();
  Future<void> initialize() async {
    if (state == StartupState.login) {
      _navigator.resetWith('/login');
    } else {
      _navigator.resetWith('/home');
    }
  }
}
