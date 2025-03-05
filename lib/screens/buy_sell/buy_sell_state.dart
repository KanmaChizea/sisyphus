import 'package:equatable/equatable.dart';

enum FormTab { buy, sell }

enum TypeOptions { gtc, fok, ioc }

extension TypeOptionExtension on TypeOptions {
  String get value {
    switch (this) {
      case TypeOptions.gtc:
        return "Good till cancelled";
      case TypeOptions.fok:
        return "Fill or Kill";
      case TypeOptions.ioc:
        return "Immediate or cancel";
    }
  }
}

class BuySellState extends Equatable {
  const BuySellState({
    required this.postOnly,
    required this.totalValue,
    required this.totalAccount,
    required this.availablePrice,
    required this.openOrders,
    required this.selectedCurrency,
    required this.currencies,
    required this.activeTab,
    required this.typeOptions,
    required this.selectedType,
  });

  final bool postOnly;
  final double totalValue;
  final double totalAccount;
  final double availablePrice;
  final double openOrders;
  final String selectedCurrency;
  final List<String> currencies;
  final FormTab activeTab;
  final List<TypeOptions> typeOptions;
  final TypeOptions selectedType;

  factory BuySellState.initial() => const BuySellState(
    postOnly: false,
    totalValue: 0,
    totalAccount: 0,
    availablePrice: 0,
    openOrders: 0,
    selectedCurrency: 'NGN',
    currencies: ['NGN', 'USD'],
    activeTab: FormTab.buy,
    typeOptions: TypeOptions.values,
    selectedType: TypeOptions.gtc,
  );

  @override
  List<Object?> get props => [
    postOnly,
    totalValue,
    totalAccount,
    availablePrice,
    openOrders,
    selectedCurrency,
    currencies,
    activeTab,
    typeOptions,
    selectedType,
  ];

  BuySellState copyWith({
    bool? postOnly,
    double? totalValue,
    double? totalAccount,
    double? availablePrice,
    double? openOrders,
    String? selectedCurrency,
    List<String>? currencies,
    FormTab? activeTab,
    List<TypeOptions>? typeOptions,
    TypeOptions? selectedType,
  }) {
    return BuySellState(
      postOnly: postOnly ?? this.postOnly,
      totalValue: totalValue ?? this.totalValue,
      totalAccount: totalAccount ?? this.totalAccount,
      availablePrice: availablePrice ?? this.availablePrice,
      openOrders: openOrders ?? this.openOrders,
      selectedCurrency: selectedCurrency ?? this.selectedCurrency,
      currencies: currencies ?? this.currencies,
      activeTab: activeTab ?? this.activeTab,
      typeOptions: typeOptions ?? this.typeOptions,
      selectedType: selectedType ?? this.selectedType,
    );
  }
}
