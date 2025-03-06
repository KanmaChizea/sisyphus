import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:sisyphus/screens/home/chart_state.dart';
import 'package:sisyphus/screens/home/home_viewmodel.dart';
import 'package:sisyphus/theme/extension.dart';
import 'package:sisyphus/widgets/shared/icons.dart';
import 'package:sisyphus/widgets/shared/typography.dart';

class Candlestick extends StatelessWidget {
  const Candlestick({super.key});
  @override
  Widget build(BuildContext context) {
    final vm = context.read<HomeViewmodel>();
    final state = context.watch<HomeViewmodel>().state.chartState;
    const spacing = SizedBox(width: 4);
    return Column(
      children: [
        SizedBox(
          height: 32,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                AppText('Time', color: Theme.of(context).appColors.grey1),
                spacing,
                ...ChartFilter.values.map(
                  (item) => GestureDetector(
                    onTap: () {
                      vm.initializeCandleStick(item);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color:
                            item == state.filter
                                ? Theme.of(context).appColors.grey2
                                : Colors.transparent,
                      ),
                      child: AppText(
                        item.value.toUpperCase(),
                        color:
                            item == state.filter
                                ? Theme.of(context).appColors.text
                                : Theme.of(context).appColors.grey1,
                      ),
                    ),
                  ),
                ),
                VerticalDivider(color: Theme.of(context).appColors.grey1),
                AppIcons.svg(AppIcons.chart, size: 20),
                VerticalDivider(color: Theme.of(context).appColors.grey1),
                AppText(
                  'FX Indicators',
                  color: Theme.of(context).appColors.grey1,
                ),
                VerticalDivider(color: Theme.of(context).appColors.grey1),
                AppIcons.svg(
                  AppIcons.undo,
                  size: 16,
                  color: Theme.of(context).appColors.grey1,
                ),
                spacing,
                AppIcons.svg(
                  AppIcons.redo,
                  size: 16,
                  color: Theme.of(context).appColors.grey1,
                ),
              ],
            ),
          ),
        ),
        if (state.options.isNotEmpty)
          SizedBox(height: 400, child: Echarts(option: state.options)),
      ],
    );
  }
}
