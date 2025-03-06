import 'package:flutter/material.dart';
import 'package:sisyphus/theme/extension.dart';
import 'package:sisyphus/widgets/home/candlestick.dart';
import 'package:sisyphus/widgets/home/order_book.dart';
import 'package:sisyphus/widgets/shared/tab.dart';

class DataContent extends StatelessWidget {
  const DataContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).appColors.foreground,
      padding: const EdgeInsets.all(16),
      child: CustomTab(
        tabTitles: const ['Charts', 'Orderbooks', 'Recent trades'],
        children: [
          const Candlestick(),
          const OrderBook(),
          Container(height: MediaQuery.of(context).size.height * 0.4),
        ],
      ),
    );
  }
}
