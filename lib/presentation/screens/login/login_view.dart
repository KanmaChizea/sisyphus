import 'package:app_template/presentation/screens/login/login_viewmodel.dart';
import 'package:app_template/utils/viewmodel/viewmodel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends ViewModelWidget {
  const LoginView({super.key});

  @override
  Widget buildView(BuildContext context, BlocBase viewModel) {
    return const Scaffold();
  }

  @override
  BlocBase createViewModel(BuildContext context) => LoginViewmodel();
}
