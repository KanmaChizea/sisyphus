import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sisyphus/core/dependency_injection/injection_container.dart';
import 'package:sisyphus/models/candle.dart';
import 'package:sisyphus/navigation/navigation_service.dart';
import 'package:sisyphus/screens/home/chart_state.dart';
import 'package:sisyphus/screens/home/home_state.dart';
import 'package:sisyphus/screens/home/orderbook_state.dart';
import 'package:sisyphus/services/binance_interface.dart';
import 'package:sisyphus/theme/extension.dart';
import 'package:sisyphus/utils/extensions/colors.dart';

class HomeViewmodel extends Cubit<HomeState> {
  HomeViewmodel() : super(HomeState.initial());

  final _binanceService = sl.get<IBinanceService>();
  void initialize() {
    _binanceService.connect('btcusdt');

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

  void initializeCandleStick([ChartFilter? filter]) {
    if (filter != state.chartState.filter) {
      emit(
        state.copyWith(chartState: state.chartState.copyWith(filter: filter)),
      );
    }
    _binanceService.subscribeToCandleStream(
      filter?.value ?? state.chartState.filter.value,
      'btcusdt',
    );
    _binanceService.candleStickStream.listen((data) {
      final isSameSymbol = data.symbol == state.chartState.data?.symbol;
      final combined =
          isSameSymbol ? state.chartState.data?.updateWith(data) ?? data : data;
      final update = jsonEncode(
        _getCandleOptions(
          combined,
          Theme.of(navigatorKey.currentContext!).appColors.text.toHex(),
        ),
      );
      emit(
        state.copyWith(
          chartState: state.chartState.copyWith(
            data: combined,
            options: update,
          ),
        ),
      );
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

  Map<String, dynamic> _getCandleOptions(Candle candle, String color) {
    return {
      "animation": false,
      "tooltip": {
        'trigger': 'item',
        "triggerOn": "click",
        "transitionDuration": 0,
        "confine": true,
        "borderRadius": 4,
        "borderWidth": 1,
        "borderColor": color,
        "backgroundColor": "rgba(0,0,0,0)",
        "textStyle": {"fontSize": 12, "color": color},
        'position': 'top',
      },
      "axisPointer": {
        "link": [
          {
            "xAxisIndex": [0, 1],
          },
        ],
      },
      "dataZoom": [
        {
          "type": "inside",
          "xAxisIndex": [0, 1],
          "start": 0,
          "end": (20 / candle.dates.length) * 100,
        },
        {
          "type": "inside",
          "xAxisIndex": [0, 1],
          "start": 0,
          "end": (20 / candle.dates.length) * 100,
        },
      ],
      "xAxis": [
        {
          "type": "category",
          "data": candle.dates,
          "boundaryGap": true,
          "axisLine": {
            "lineStyle": {"color": "#A7B1BC"},
          },
          "axisLabel": {"show": false},
          "min": "dataMin",
          "max": "dataMax",
          "axisPointer": {"show": true, "triggerTooltip": true},
        },
        {
          "type": "category",
          "gridIndex": 1,
          "data": candle.dates,
          "boundaryGap": true,
          "splitLine": {"show": false},
          "axisLabel": {"show": true},
          "axisTick": {"show": false},
          "axisLine": {
            "lineStyle": {"color": "#A7B1BC"},
          },
          "min": "dataMin",
          "max": "dataMax",
          "axisPointer": {"show": true, "triggerTooltip": true},
        },
      ],
      'yAxis': [
        {
          'scale': true,
          'axisLine': {
            'show': true,
            'lineStyle': {'color': '#A7B1BC'},
          },
          'splitLine': {'show': false},
          'axisTick': {'show': true},
          'axisLabel': {'formatter': '{value}'},
          'position': 'right',
          'axisPointer': {'show': true, "triggerTooltip": true},
        },
        {
          'scale': true,
          'gridIndex': 1,
          'splitNumber': 2,
          'axisLabel': {'show': true},
          'axisLine': {
            'show': true,
            'lineStyle': {'color': '#A7B1BC'},
          },
          'axisTick': {'show': true},
          'splitLine': {'show': false},
          'position': 'right',
          'axisPointer': {'show': true, "triggerTooltip": true},
        },
      ],
      "grid": [
        {"left": 0, "right": 55, "top": 24, "height": 200},
        {"left": 0, "right": 55, "height": 140, "top": 236},
      ],
      "series": [
        {
          "name": "Volume",
          "type": "bar",
          "xAxisIndex": 1,
          "yAxisIndex": 1,
          "itemStyle": {"color": "#7fbe9e"},
          "emphasis": {
            "itemStyle": {"color": "#140"},
          },
          "data": candle.volumes,
        },
        {
          "type": "candlestick",
          "data": candle.data,
          "itemStyle": {
            "color": '#FF6838',
            "color0": '#00C076',
            "borderColor": "#ef232a",
            "borderColor0": "#14b143",
          },
          "emphasis": {
            "itemStyle": {"borderColor": '#FF554A', "borderColor0": '#25C26E'},
          },
        },
      ],
    };
  }

  void dispose() {
    _binanceService.dispose();
  }
}
