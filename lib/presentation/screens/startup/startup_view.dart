import 'package:app_template/presentation/screens/startup/startup_viewmodel.dart';
import 'package:app_template/utils/viewmodel/viewmodel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartupView extends ViewModelWidget {
  const StartupView({super.key});

  @override
  Widget buildView(BuildContext context, BlocBase viewModel) {
    return const Scaffold();
  }

  @override
  BlocBase createViewModel(BuildContext context) =>
      StartupViewmodel()..initialize();
}
