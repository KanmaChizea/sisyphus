import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// This widget provides base functionality for MVVM architechture using BLOC/Cubits
/// It binds view model to view easily
/// A generic reusable widget that creates a BLoC-based view with a custom view model
class ViewModelWidget<B extends Cubit<S>, S> extends StatelessWidget {
  const ViewModelWidget({
    super.key,
    this.listener,
    required this.child,
    required this.viewModel,
  });

  /// Optional listener for state changes
  final void Function(BuildContext, S)? listener;
  final Widget Function(B viewmodel, S state) child;

  /// Abstract method to create the BLoC (view model)
  final B Function(BuildContext) viewModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<B>(
      create: (context) => viewModel(context),
      child: BlocConsumer<B, S>(
        listener: (context, state) {
          listener?.call(context, state);
        },
        builder: (context, state) {
          // Get the bloc instance from the context
          final bloc = context.read<B>();

          // Call the view creation method with context, bloc, and current state
          return child(bloc, state);
        },
      ),
    );
  }
}
