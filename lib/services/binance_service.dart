import 'dart:async';
import 'dart:convert';
import 'package:sisyphus/models/candle.dart';
import 'package:sisyphus/models/order_book.dart';
import 'package:sisyphus/models/ticker.dart';
import 'package:sisyphus/services/binance_interface.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class BinanceService implements IBinanceService {
  WebSocketChannel? _channel;
  WebSocketChannel? _candleStickChannel;

  final StreamController<Ticker> _tickerController =
      StreamController<Ticker>.broadcast();

  final StreamController<OrderBook> _orderbookController =
      StreamController<OrderBook>.broadcast();
  final StreamController<Candle> _candlestickController =
      StreamController<Candle>.broadcast();

  @override
  Stream<OrderBook> get orderbookStream => _orderbookController.stream;

  @override
  Stream<Ticker> get tickerStream => _tickerController.stream;

  @override
  Stream<Candle> get candleStickStream => _candlestickController.stream;

  @override
  Future<void> connect(String symbol) async {
    try {
      _channel = WebSocketChannel.connect(
        Uri.parse(
          "wss://fstream.binance.com/stream?streams=$symbol@ticker/$symbol@depth@500ms",
        ),
      );
      await _channel?.ready;

      _channel?.stream.listen((message) {
        var getData = jsonDecode(message);
        if (getData['stream'] == '$symbol@ticker') {
          _tickerController.add(Ticker.fromMap(getData['data']));
        } else if (getData['stream'] == '$symbol@depth@500ms') {
          _orderbookController.add(OrderBook.fromMap(getData['data']));
        }
      });
    } catch (e) {
      //TODO: handle error
      return;
    }
  }

  @override
  Future<void> subscribeToCandleStream(String interval, String symbol) async {
    _candleStickChannel?.sink.close();
    try {
      _candleStickChannel = WebSocketChannel.connect(
        Uri.parse("wss://fstream.binance.com/ws/$symbol@kline_$interval"),
      );
      await _candleStickChannel?.ready;

      _candleStickChannel?.stream.listen((message) {
        var data = jsonDecode(message);
        _candlestickController.add(Candle.fromMap(data));
      });
    } catch (e) {
      //TODO: handle error
      return;
    }
  }

  @override
  void dispose() {
    _channel?.sink.close();
    _candleStickChannel?.sink.close();
    _channel = null;
    _candleStickChannel = null;
    _orderbookController.close();
    _tickerController.close();
    _candlestickController.close();
  }
}
