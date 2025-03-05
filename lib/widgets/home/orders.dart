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
            tabWidth: 159,
            tabTitles: const [
              'Open Orders',
              'Positions',
              'Order History',
              'Trade History',
            ],
            children:
                [
                      'No Open Orders',
                      'No Positions',
                      'No Order History',
                      'No Trade History',
                    ]
                    .map(
                      (elememt) => Padding(
                        padding: const EdgeInsets.fromLTRB(0, 128, 16, 54),
                        child: EmptyState(
                          title: elememt,
                          text:
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Id pulvinar nullam sit imperdiet pulvinar.',
                        ),
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
    );
  }
}
