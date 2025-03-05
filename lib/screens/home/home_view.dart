import 'package:flutter/material.dart';
import 'package:sisyphus/core/constants/images.dart';
import 'package:sisyphus/screens/buy_sell/buy_sell_state.dart';
import 'package:sisyphus/screens/buy_sell/buy_sell_view.dart';
import 'package:sisyphus/screens/home/home_state.dart';
import 'package:sisyphus/screens/home/home_viewmodel.dart';
import 'package:sisyphus/theme/extension.dart';
import 'package:sisyphus/utils/viewmodel/viewmodel_widget.dart';
import 'package:sisyphus/widgets/button.dart';
import 'package:sisyphus/widgets/home/avi.dart';
import 'package:sisyphus/widgets/home/data_content.dart';
import 'package:sisyphus/widgets/home/menu_button.dart';
import 'package:sisyphus/widgets/home/orders.dart';
import 'package:sisyphus/widgets/home/top_info.dart';
import 'package:sisyphus/widgets/icons.dart';

class HomeView extends ViewModelWidget<HomeViewmodel, HomeState> {
  const HomeView({super.key});

  @override
  HomeViewmodel createViewModel(BuildContext context) => HomeViewmodel();

  @override
  Widget createView(context, viewModel, state) {
    return Scaffold(
      backgroundColor: Theme.of(context).appColors.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appColors.foreground,
        title: AppIcons.svg(AppIcons.logo, adaptable: true, size: 34),
        actions: [
          const Avatar(AppImages.avi),
          IconButton(icon: AppIcons.svg(AppIcons.web), onPressed: () {}),
          const HomeMenuButton(),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: TopInfo()),
          SliverToBoxAdapter(child: DataContent()),
          const SliverToBoxAdapter(child: Orders()),
          SliverToBoxAdapter(
            child: Container(
              color:
                  Theme.of(context)
                      .appColors
                      .foreground, //light and dark mode not consistent here
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(top: 80),
              child: Row(
                spacing: 12,
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'Buy',
                      backgroundColor: Theme.of(context).appColors.green,
                      onPressed:
                          () => {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder:
                                  (context) => const BuySellView(FormTab.buy),
                            ),
                          },
                    ),
                  ),
                  Expanded(
                    child: CustomButton(
                      text: 'Sell',
                      backgroundColor: Theme.of(context).appColors.red,
                      onPressed:
                          () => {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder:
                                  (context) => const BuySellView(FormTab.sell),
                            ),
                          },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
