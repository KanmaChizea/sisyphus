import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sisyphus/core/dependency_injection/injection_container.dart';
import 'package:sisyphus/navigation/navigation_service.dart';

class HomeState {}

class HomeViewmodel extends Cubit<HomeState> {
  HomeViewmodel() : super(HomeState());

  final _navigator = sl.get<NavigationService>();
}
