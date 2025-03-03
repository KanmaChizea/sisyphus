import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sisyphus/screens/home/view_model.dart';
import 'package:sisyphus/utils/viewmodel/viewmodel_widget.dart';

class HomeView extends ViewModelWidget {
  const HomeView({super.key});

  @override
  BlocBase createViewModel(BuildContext context) => HomeViewmodel();

  @override
  Widget buildView(BuildContext context, BlocBase viewModel) {
    return const Scaffold();
  }
}
