import 'package:app_template/presentation/screens/home/home_viewmodel.dart';
import 'package:app_template/utils/viewmodel/viewmodel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends ViewModelWidget {
  const HomeView({super.key});

  @override
  Widget buildView(BuildContext context, BlocBase viewModel) {
    return const Scaffold();
  }

  @override
  BlocBase createViewModel(BuildContext context) => HomeViewmodel();
}
