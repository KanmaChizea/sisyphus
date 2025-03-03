import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// This widget provides base functionality for MVVM architechture using BLOC/Cubits
/// It binds view model to view easily
/// Use this when you need to use init and/or dispose functions for controllers and such
/// Else see ViewModelWidget
abstract class ViewModelStatefulWidget<T extends BlocBase>
    extends StatefulWidget {
  const ViewModelStatefulWidget({super.key});

  /// Creates the view model
  T createViewModel(BuildContext context);

  /// The equivalent of stateless widget's build function
  /// Builds the view for the viewmodel
  Widget buildView(BuildContext context, T viewModel);

  @override
  // ignore: library_private_types_in_public_api
  _ViewModelStatefulWidgetState<T> createState() =>
      _ViewModelStatefulWidgetState<T>();
}

class _ViewModelStatefulWidgetState<T extends BlocBase>
    extends State<ViewModelStatefulWidget<T>> {
  late T _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = widget.createViewModel(context);
  }

  @override
  void dispose() {
    _viewModel.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _viewModel,
      child: Builder(
        builder: (context) {
          return widget.buildView(
            context,
            context.read<T>(),
          );
        },
      ),
    );
  }
}
