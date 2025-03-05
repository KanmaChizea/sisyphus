import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// This widget provides base functionality for MVVM architechture using BLOC/Cubits
/// It binds view model to view easily
/// A generic reusable widget that creates a BLoC-based view with a custom view model
abstract class ViewModelWidget<B extends Cubit<S>, S> extends StatelessWidget {
  /// Optional listener for state changes
  final void Function(BuildContext, S)? listener;

  const ViewModelWidget({super.key, this.listener});

  /// Abstract method to create the BLoC (view model)
  B createViewModel(BuildContext context);

  /// Abstract method to create the view widget that receives the BLoC and current state
  Widget createView(BuildContext context, B bloc, S state);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<B>(
      create: (context) => createViewModel(context),
      child: BlocConsumer<B, S>(
        listener: (context, state) {
          listener?.call(context, state);
        },
        builder: (context, state) {
          // Get the bloc instance from the context
          final bloc = context.read<B>();

          // Call the view creation method with context, bloc, and current state
          return createView(context, bloc, state);
        },
      ),
    );
  }
}
