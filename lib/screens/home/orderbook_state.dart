import 'package:equatable/equatable.dart';

import 'package:sisyphus/models/order.dart';

enum OrderbookFilter { both, bids, asks }

class OrderbookState extends Equatable {
  const OrderbookState({
    required this.selectedFilter,
    required this.bids,
    required this.asks,
    required this.limit,
    required this.bidLength,
    required this.askLength,
    required this.averageBid,
    required this.averageAsk,
    required this.averageProfit,
  });

  final OrderbookFilter selectedFilter;
  final List<Order> bids;
  final List<Order> asks;
  final int limit;
  final int bidLength;
  final int askLength;
  final double averageBid;
  final double averageAsk;
  final bool averageProfit;

  factory OrderbookState.initial() => const OrderbookState(
    selectedFilter: OrderbookFilter.both,
    bids: [],
    asks: [],
    limit: 10,
    bidLength: 5,
    askLength: 5,
    averageBid: 0.0,
    averageAsk: 0.0,
    averageProfit: false,
  );

  @override
  List<Object?> get props => [
    selectedFilter,
    bids,
    asks,
    limit,
    bidLength,
    askLength,
    averageBid,
    averageAsk,
    averageProfit,
  ];

  OrderbookState copyWith({
    OrderbookFilter? selectedFilter,
    List<Order>? bids,
    List<Order>? asks,
    int? limit,
    int? bidLength,
    int? askLength,
    double? averageBid,
    double? averageAsk,
    bool? averageProfit,
  }) {
    return OrderbookState(
      selectedFilter: selectedFilter ?? this.selectedFilter,
      bids: bids ?? this.bids,
      asks: asks ?? this.asks,
      limit: limit ?? this.limit,
      bidLength: bidLength ?? this.bidLength,
      askLength: askLength ?? this.askLength,
      averageBid: averageBid ?? this.averageBid,
      averageAsk: averageAsk ?? this.averageAsk,
      averageProfit: averageProfit ?? this.averageProfit,
    );
  }
}
