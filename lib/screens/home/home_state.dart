import 'package:equatable/equatable.dart';
import 'package:sisyphus/models/ticker.dart';

import 'package:sisyphus/screens/home/chart_state.dart';
import 'package:sisyphus/screens/home/orderbook_state.dart';

class HomeState extends Equatable {
  const HomeState({
    required this.ticker,
    required this.openOrders,
    required this.orderHistory,
    required this.tradeHistory,
    required this.positions,
    required this.recentTrades,
    required this.orderbook,
    required this.chartState,
  });
  final Ticker ticker;
  final List openOrders;
  final List orderHistory;
  final List tradeHistory;
  final List positions;
  final List recentTrades;
  final OrderbookState orderbook;
  final ChartState chartState;

  factory HomeState.initial() => HomeState(
    ticker: const Ticker(
      changeValue: '',
      changePercentage: '',
      highValue: '',
      highPercentage: '',
      lowValue: '',
      lowPercentage: '',
      volumeValue: '',
      currentRate: '',
    ),
    openOrders: const [],
    orderHistory: const [],
    tradeHistory: const [],
    positions: const [],
    recentTrades: const [],
    orderbook: OrderbookState.initial(),
    chartState: ChartState.initial(),
  );
  @override
  List<Object?> get props => [
    ticker,
    openOrders,
    orderHistory,
    tradeHistory,
    positions,
    recentTrades,
    orderbook.props,
    chartState.props,
  ];

  HomeState copyWith({
    Ticker? ticker,
    List? openOrders,
    List? orderHistory,
    List? tradeHistory,
    List? positions,
    List? recentTrades,
    OrderbookState? orderbook,
    ChartState? chartState,
  }) {
    return HomeState(
      ticker: ticker ?? this.ticker,
      openOrders: openOrders ?? this.openOrders,
      orderHistory: orderHistory ?? this.orderHistory,
      tradeHistory: tradeHistory ?? this.tradeHistory,
      positions: positions ?? this.positions,
      recentTrades: recentTrades ?? this.recentTrades,
      orderbook: orderbook ?? this.orderbook,
      chartState: chartState ?? this.chartState,
    );
  }
}
