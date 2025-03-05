import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sisyphus/screens/home/home_viewmodel.dart';
import 'package:sisyphus/screens/home/orderbook_state.dart';
import 'package:sisyphus/theme/extension.dart';
import 'package:sisyphus/widgets/dropdown.dart';
import 'package:sisyphus/widgets/icons.dart';
import 'package:sisyphus/widgets/typography.dart';

class OrderBook extends StatelessWidget {
  const OrderBook({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<HomeViewmodel>();
    final state = context.watch<HomeViewmodel>().state.orderbook;
    return Column(
      spacing: 8,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FilterButtons(
              onPress: vm.setFilter,
              selected: state.selectedFilter,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Theme.of(context).appColors.grey2,
              ),
              child: Dropdown(
                onChanged: vm.selectOrderBookLimit,
                list: const [10, 20, 30],
                value: state.limit,

                child:
                    (p0) => SizedBox(
                      width: 24,
                      child: AppText(p0.toString(), size: 12),
                    ),
              ),
            ),
          ],
        ),

        Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            //Table header
            TableRow(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: AppText(
                    'Price\n(USDT)',
                    size: 9,
                    color: Theme.of(context).appColors.grey1,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: AppText(
                    'Amounts\n(BTC)',
                    textAlign: TextAlign.end,
                    size: 9,
                    color: Theme.of(context).appColors.grey1,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: AppText(
                    'Total\n',
                    textAlign: TextAlign.center,
                    size: 9,
                    color: Theme.of(context).appColors.grey1,
                  ),
                ),
              ],
            ),
            // Asks rows
            ...state.asks
                .sublist(0, state.askLength)
                .map(
                  (e) => TableRow(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: AppText(
                          e.price.toStringAsFixed(2),
                          textAlign: TextAlign.center,
                          size: 12,
                          color: Theme.of(context).appColors.red,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: AppText(
                          e.quantity.toStringAsFixed(2),
                          textAlign: TextAlign.center,
                          size: 12,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: AppText(
                          e.total.toStringAsFixed(2),
                          textAlign: TextAlign.center,
                          size: 12,
                        ),
                      ),
                    ],
                  ),
                ),
          ],
        ),
        if (state.selectedFilter == OrderbookFilter.both)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              spacing: 8,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                  state.averageAsk.toStringAsFixed(2),
                  size: 16,
                  color:
                      state.averageProfit
                          ? Theme.of(context).appColors.green
                          : Theme.of(context).appColors.red,
                ),
                AppIcons.svg(
                  state.averageProfit ? AppIcons.arrowUp : AppIcons.down,
                  color:
                      state.averageProfit
                          ? Theme.of(context).appColors.green
                          : Theme.of(context).appColors.red,
                ),
                AppText(state.averageBid.toStringAsFixed(2), size: 16),
              ],
            ),
          ),
        // Bids rows
        Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children:
              state.bids
                  .sublist(0, state.bidLength)
                  .map(
                    (e) => TableRow(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: AppText(
                            e.price.toStringAsFixed(2),
                            textAlign: TextAlign.center,
                            size: 12,
                            color: Theme.of(context).appColors.green,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: AppText(
                            e.quantity.toStringAsFixed(2),
                            textAlign: TextAlign.center,
                            size: 12,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: AppText(
                            e.total.toStringAsFixed(2),
                            textAlign: TextAlign.center,
                            size: 12,
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList(),
        ),
      ],
    );
  }
}

class FilterButtons extends StatelessWidget {
  const FilterButtons({
    super.key,
    required this.onPress,
    required this.selected,
  });

  final Function(OrderbookFilter) onPress;
  final OrderbookFilter selected;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 4,
      children:
          OrderbookFilter.values.map((item) {
            return GestureDetector(
              onTap: () => onPress(item),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 11,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color:
                      item == selected
                          ? Theme.of(context).appColors.grey2
                          : Colors.transparent,
                ),
                child: AppIcons.svg(switch (item) {
                  OrderbookFilter.asks => AppIcons.redLine,
                  OrderbookFilter.bids => AppIcons.greenLine,
                  _ => AppIcons.redGreenLine,
                }, size: 12),
              ),
            );
          }).toList(),
    );
  }
}
