import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sisyphus/screens/network_status/network_status_viewmodel.dart';
import 'package:sisyphus/screens/network_status/network_staus_state.dart';
import 'package:sisyphus/theme/extension.dart';
import 'package:sisyphus/utils/helpers/network_status_checker.dart';
import 'package:sisyphus/utils/viewmodel/viewmodel_widget.dart';
import 'package:sisyphus/widgets/shared/button.dart';
import 'package:sisyphus/widgets/shared/icons.dart';
import 'package:sisyphus/widgets/shared/typography.dart';

class NetworkStatusView extends StatelessWidget {
  const NetworkStatusView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelWidget<NetworkStatusViewmodel, NetworkStatusState>(
      viewModel: (_) => NetworkStatusViewmodel(context.mounted),
      listener: (context, state) {
        if (state.status == NetworkStatus.connected) {
          context.read<NetworkStatusViewmodel>().goHome();
        }
      },
      child:
          (vm, state) => Scaffold(
            body: SafeArea(
              child: Container(
                color: Theme.of(context).appColors.background,
                padding: const EdgeInsets.all(16),
                child:
                    state.isLoading
                        ? Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).appColors.text,
                          ),
                        )
                        : Column(
                          spacing: 8,
                          children: [
                            Expanded(child: Container()),
                            AppIcons.svg(
                              AppIcons.web,
                              size: 50,
                              color:
                                  state.status == NetworkStatus.connected
                                      ? Theme.of(context).appColors.green
                                      : Theme.of(context).appColors.text,
                            ),
                            AppText(
                              state.status?.description ?? '',
                              size: 20,
                              weight: FontWeight.w700,
                            ),
                            AppText(
                              state.status?.instruction ?? '',
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 32),
                            if (state.status != NetworkStatus.connected)
                              CustomButton(
                                text: 'Retry',
                                onPressed: () => vm.initialize(context.mounted),
                                backgroundColor:
                                    Theme.of(context).appColors.red,
                              ),
                            Expanded(flex: 3, child: Container()),
                          ],
                        ),
              ),
            ),
          ),
    );
  }
}
