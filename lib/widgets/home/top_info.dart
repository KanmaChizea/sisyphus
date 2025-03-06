import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sisyphus/screens/home/home_viewmodel.dart';
import 'package:sisyphus/theme/extension.dart';
import 'package:sisyphus/utils/helpers/formatters.dart';
import 'package:sisyphus/widgets/shared/dropdown.dart';
import 'package:sisyphus/widgets/shared/icons.dart';
import 'package:sisyphus/widgets/shared/typography.dart';

class TopInfo extends StatelessWidget {
  const TopInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeViewmodel>().state.ticker;

    final values = [
      (
        type: 'change',
        icon: AppIcons.clock,
        value:
            '${Formatters.formatStringNumber(state.changeValue)} ${Formatters.stringToPercent(state.changePercentage)}',
      ),
      (
        type: 'high',
        icon: AppIcons.arrowUp,
        value:
            '${Formatters.formatStringNumber(state.highValue)} ${Formatters.stringToPercent(state.highPercentage)}',
      ),
      (
        type: 'low',
        icon: AppIcons.down,
        value:
            '${Formatters.formatStringNumber(state.lowValue)} ${Formatters.stringToPercent(state.lowPercentage)}',
      ),
      (
        type: 'volume',
        icon: AppIcons.volume,
        value: Formatters.formatStringNumber(state.volumeValue),
      ),
    ];
    return Container(
      padding: const EdgeInsets.all(16),
      color: Theme.of(context).appColors.foreground,
      child: Column(
        spacing: 14,
        children: [
          Row(
            children: [
              AppIcons.svg(AppIcons.currency),
              Dropdown(
                onChanged: (_) => {},
                list: const ['BTC/USDT'],
                value: 'BTC/USDT',
                iconSize: 20,
                child:
                    (p0) => SizedBox(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: AppText(p0 ?? '', size: 18),
                    ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: AppText(
                  '\$${state.currentRate}',
                  size: 18,
                  color: Theme.of(context).appColors.green,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 48,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,

              itemCount: values.length,
              separatorBuilder:
                  (context, index) => VerticalDivider(
                    width: 16,
                    color: Theme.of(
                      context,
                    ).appColors.grey1.withValues(alpha: 0.1),
                  ),
              itemBuilder: (context, index) {
                return Stat(
                  type: values[index].type,
                  icon: values[index].icon,
                  value: values[index].value,
                  color: index == 0 ? Theme.of(context).appColors.green : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Stat extends StatelessWidget {
  const Stat({
    super.key,
    required this.type,
    required this.icon,
    required this.value,
    this.color,
  });
  final String type;
  final String icon;
  final String value;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 30),
      child: Column(
        spacing: 4,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 4,
            children: [
              AppIcons.svg(icon, size: 16),
              AppText(
                '24h $type',
                color: Theme.of(context).appColors.grey1,
                size: 12,
                weight: FontWeight.w500,
              ),
            ],
          ),
          AppText(value, color: color),
        ],
      ),
    );
  }
}
