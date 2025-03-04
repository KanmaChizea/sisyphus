import 'package:flutter/material.dart';
import 'package:sisyphus/theme/extension.dart';
import 'package:sisyphus/widgets/empty.dart';
import 'package:sisyphus/widgets/tab.dart';

class Orders extends StatelessWidget {
  const Orders({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).appColors.foreground,
      padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
      child: Column(
        children: [
          CustomTab(
            scrollable: true,
            tabWidth: 100,
            tabTitles: const [
              'Open Orders',
              'Positions',
              'Order History',
              'Trade History',
            ],
            children: const [
              Padding(
                padding: EdgeInsets.only(right: 8),
                child: EmptyState(
                  title: 'No Open Orders',
                  text:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Id pulvinar nullam sit imperdiet pulvinar.',
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 8),
                child: EmptyState(
                  title: 'No Positions',
                  text:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Id pulvinar nullam sit imperdiet pulvinar.',
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 8),
                child: EmptyState(
                  title: 'No Order History',
                  text:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Id pulvinar nullam sit imperdiet pulvinar.',
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 8),
                child: EmptyState(
                  title: 'No Trade History',
                  text:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Id pulvinar nullam sit imperdiet pulvinar.',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
