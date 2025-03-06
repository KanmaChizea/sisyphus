import 'package:flutter/material.dart';
import 'package:sisyphus/screens/buy_sell/buy_sell_state.dart';
import 'package:sisyphus/screens/buy_sell/buy_sell_viewmodel.dart';
import 'package:sisyphus/theme/extension.dart';
import 'package:sisyphus/utils/viewmodel/viewmodel_widget.dart';
import 'package:sisyphus/widgets/home/buy_form.dart';
import 'package:sisyphus/widgets/tab.dart';

class BuySellView extends StatelessWidget {
  final FormTab initialTab;
  const BuySellView(this.initialTab, {super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelWidget(
      viewModel: (_) => BuySellViewmodel(),
      child:
          (viewModel, state) => Wrap(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 28,
                  horizontal: 32,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).appColors.background,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: CustomTab(
                  initialIndex: initialTab.index,
                  tabTitles: const ['Buy', 'Sell'],
                  tabStyle: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).appColors.green,
                    ),
                  ),
                  children: [
                    const BuyForm(),
                    Container(height: MediaQuery.of(context).size.height * 0.7),
                  ],
                ),
              ),
            ],
          ),
    );
  }
}
