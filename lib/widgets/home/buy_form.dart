import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sisyphus/screens/buy_sell/buy_sell_state.dart';
import 'package:sisyphus/screens/buy_sell/buy_sell_viewmodel.dart';
import 'package:sisyphus/theme/extension.dart';
import 'package:sisyphus/widgets/button.dart';
import 'package:sisyphus/widgets/check_item.dart';
import 'package:sisyphus/widgets/dropdown.dart';
import 'package:sisyphus/widgets/dropdown_input.dart';
import 'package:sisyphus/widgets/icons.dart';
import 'package:sisyphus/widgets/input.dart';
import 'package:sisyphus/widgets/tab.dart';
import 'package:sisyphus/widgets/typography.dart';

class BuyForm extends StatefulWidget {
  const BuyForm({super.key});

  @override
  State<BuyForm> createState() => _BuyFormState();
}

class _BuyFormState extends State<BuyForm> {
  late TextEditingController limitController;
  late TextEditingController amountController;

  @override
  void initState() {
    super.initState();
    limitController = TextEditingController();
    amountController = TextEditingController();
  }

  @override
  void dispose() {
    limitController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currencySuffix = AppText(
      'USD',
      size: 12,
      weight: FontWeight.w500,
      color: Theme.of(context).appColors.grey1,
    );
    final state = context.watch<BuySellViewmodel>().state;
    final viewmodel = context.read<BuySellViewmodel>();
    return CustomTab(
      tabStyle: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Theme.of(context).appColors.grey2,
      ),
      tabContainerStyle: const BoxDecoration(
        color: Colors.transparent,
        boxShadow: [],
      ),
      tabBarIndicatorSize: TabBarIndicatorSize.label,
      tabTitles: const ['Limit', 'Market', 'Stop-Limit'],
      children: [
        SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [
              InputField(
                controller: limitController,
                label: 'Limit price',
                suffix: currencySuffix,
                fieldInfo: "The maximum price you're willing to pay",
                hintText: '0.00',
                keyboardType: TextInputType.number,
              ),
              InputField(
                controller: amountController,
                label: 'Amount',
                suffix: currencySuffix,
                fieldInfo: "how much you want to buy",
                hintText: '0.00',
                keyboardType: TextInputType.number,
              ),
              DropdownInput(
                label: 'Type',
                onChanged: viewmodel.selectOrderType,
                list: state.typeOptions,
                value: state.selectedType,
                fieldInfo:
                    """- GTC (Good Till Canceled): Order stays active until canceled.
- FOK (Fill or Kill): Must fill completely or cancel.
- IOC (Immediate or Cancel): Fills immediately, cancels unfilled portion.
""",
                child: (val) => AppText(val?.value ?? ''),
              ),
              CheckItem(
                isActive: state.postOnly,
                onChange: viewmodel.togglePostOnly,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 5,
                  children: [
                    AppText(
                      'Post-only',
                      size: 12,
                      weight: FontWeight.w500,
                      color: Theme.of(context).appColors.grey1,
                    ),
                    AppIcons.svg(AppIcons.info, size: 12),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: 12,
                children: [
                  AppText(
                    'Total',
                    size: 12,
                    weight: FontWeight.w500,
                    color: Theme.of(context).appColors.grey1,
                  ),
                  AppText(
                    state.totalValue.toStringAsFixed(2),
                    size: 12,
                    weight: FontWeight.w500,
                    color: Theme.of(context).appColors.grey1,
                  ),
                ],
              ),
              SizedBox(
                height: 32,
                child: CustomButton(
                  text: 'Buy BTC',
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF483BEB),
                      Color(0xFF7847E1),
                      Color(0xFFDD568D),
                    ],
                  ),
                  onPressed: viewmodel.buyBtc,
                ),
              ),
              Divider(color: Theme.of(context).appColors.border),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PriceValue(
                    title: 'Total account value',
                    value: state.totalAccount,
                  ),
                  Dropdown(
                    onChanged: viewmodel.selectCurrency,
                    list: state.currencies,
                    value: state.selectedCurrency,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PriceValue(title: 'Open Orders', value: state.openOrders),
                  PriceValue(title: 'Available', value: state.availablePrice),
                ],
              ),
              SizedBox(
                width: 80,
                child: CustomButton(
                  text: 'Deposit',
                  backgroundColor: const Color(0xFF2764FF),
                  onPressed: viewmodel.deposit,
                ),
              ),
            ],
          ),
        ),
        Container(height: MediaQuery.of(context).size.height * 0.6),
        Container(height: MediaQuery.of(context).size.height * 0.6),
      ],
    );
  }
}

class PriceValue extends StatelessWidget {
  const PriceValue({super.key, required this.title, required this.value});
  final String title;
  final double value;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        AppText(title, size: 12, color: Theme.of(context).appColors.grey1),
        AppText(value.toStringAsFixed(2), weight: FontWeight.w700),
      ],
    );
  }
}
