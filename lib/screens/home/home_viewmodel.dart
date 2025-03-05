import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sisyphus/core/dependency_injection/injection_container.dart';
import 'package:sisyphus/screens/home/home_state.dart';
import 'package:sisyphus/screens/home/orderbook_state.dart';
import 'package:sisyphus/services/binance_interface.dart';

class HomeViewmodel extends Cubit<HomeState> {
  HomeViewmodel() : super(HomeState.initial());

  final _binanceService = sl.get<IBinanceService>();

  void initialize() {
    _binanceService.connect();
    _binanceService.tickerStream.listen((data) {
      emit(state.copyWith(ticker: data));
    });
    _binanceService.orderbookStream.listen((data) {
      emit(
        state.copyWith(
          orderbook: state.orderbook.copyWith(
            asks: [...data.asks, ...state.orderbook.asks],
            bids: [...state.orderbook.bids, ...data.bids],
          ),
        ),
      );
      _calculateAverage();
    });
  }

  void selectOrderBookLimit(int? value) {
    emit(state.copyWith(orderbook: state.orderbook.copyWith(limit: value)));
    _calculateLength();
  }

  void setFilter(OrderbookFilter filter) {
    emit(
      state.copyWith(
        orderbook: state.orderbook.copyWith(selectedFilter: filter),
      ),
    );
    _calculateLength();
  }

  void _calculateLength() {
    int finalAsksLength = 0;
    int finalBidsLength = 0;
    final filter = state.orderbook.selectedFilter;
    final asksLength = state.orderbook.asks.length;
    final bidsLength = state.orderbook.bids.length;
    final totalLength = state.orderbook.limit;
    if (filter == OrderbookFilter.asks) {
      finalAsksLength = asksLength.clamp(0, totalLength);
    } else if (filter == OrderbookFilter.bids) {
      finalBidsLength = bidsLength.clamp(0, totalLength);
    } else {
      int halfTotal = (totalLength / 2).floor();
      finalAsksLength = asksLength.clamp(0, halfTotal);
      finalBidsLength = bidsLength.clamp(0, halfTotal);

      // Adjust if one list is smaller and the other can compensate
      int remaining = totalLength - (finalAsksLength + finalBidsLength);
      if (remaining > 0) {
        if (asksLength > finalAsksLength) {
          int extraAsks = (asksLength - finalAsksLength).clamp(0, remaining);
          finalAsksLength += extraAsks;
          remaining -= extraAsks;
        }
        if (remaining > 0 && bidsLength > finalBidsLength) {
          int extraBids = (bidsLength - finalBidsLength).clamp(0, remaining);
          finalBidsLength += extraBids;
        }
      }
    }

    emit(
      state.copyWith(
        orderbook: state.orderbook.copyWith(
          askLength: finalAsksLength,
          bidLength: finalBidsLength,
        ),
      ),
    );
    _calculateAverage();
  }

  void _calculateAverage() {
    final averageAsk =
        state.orderbook.asks.map((e) => e.price).reduce((a, b) => a + b) /
        state.orderbook.asks.length;
    final averageBid =
        state.orderbook.bids.map((e) => e.price).reduce((a, b) => a + b) /
        state.orderbook.bids.length;
    emit(
      state.copyWith(
        orderbook: state.orderbook.copyWith(
          averageAsk: averageAsk,
          averageBid: averageBid,
          averageProfit: averageBid > averageAsk,
        ),
      ),
    );
  }

  void dispose() {
    _binanceService.dispose();
  }
}
