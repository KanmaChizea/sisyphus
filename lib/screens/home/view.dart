import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sisyphus/core/constants/images.dart';
import 'package:sisyphus/screens/home/view_model.dart';
import 'package:sisyphus/theme/extension.dart';
import 'package:sisyphus/utils/viewmodel/viewmodel_widget.dart';
import 'package:sisyphus/widgets/button.dart';
import 'package:sisyphus/widgets/home/avi.dart';
import 'package:sisyphus/widgets/home/data_content.dart';
import 'package:sisyphus/widgets/home/menu_button.dart';
import 'package:sisyphus/widgets/home/orders.dart';
import 'package:sisyphus/widgets/home/top_info.dart';
import 'package:sisyphus/widgets/icons.dart';

class HomeView extends ViewModelWidget {
  const HomeView({super.key});

  @override
  BlocBase createViewModel(BuildContext context) => HomeViewmodel();

  @override
  Widget buildView(BuildContext context, BlocBase viewModel) {
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          spacing: 8,
          children: [
            TopInfo(),
            DataContent(),
            const Orders(),
            Container(
              color:
                  Theme.of(context)
                      .appColors
                      .foreground, //light and dark mode not consistent here
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(top: 80),
              child: Row(
                spacing: 12,
                children: [
                  CustomButton(
                    text: 'Buy',
                    backgroundColor: Theme.of(context).appColors.green,
                  ),
                  CustomButton(
                    text: 'Sell',
                    backgroundColor: Theme.of(context).appColors.red,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
