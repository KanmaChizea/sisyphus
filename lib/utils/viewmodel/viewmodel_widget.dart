import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// This widget provides base functionality for MVVM architechture using BLOC/Cubits
/// It binds view model to view easily
abstract class ViewModelWidget<T extends BlocBase> extends StatelessWidget {
  const ViewModelWidget({super.key});

  /// Creates the view model
  T createViewModel(BuildContext context);

  /// The equivalent of stateless widget's build function
  /// Builds the view for the viewmodel
  Widget buildView(BuildContext context, T viewModel);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: createViewModel,
      child: Builder(
        builder: (context) {
          return buildView(
            context,
            context.read<T>(),
          );
        },
      ),
    );
  }
}
