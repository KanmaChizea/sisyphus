import 'dart:async';
import 'dart:convert';
import 'package:sisyphus/models/order_book.dart';
import 'package:sisyphus/models/ticker.dart';
import 'package:sisyphus/services/binance_interface.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class BinanceService implements IBinanceService {
  WebSocketChannel? _channel;

  final StreamController<Ticker> _tickerController =
      StreamController<Ticker>.broadcast();

  final StreamController<OrderBook> _orderbookController =
      StreamController<OrderBook>.broadcast();

  @override
  Stream<OrderBook> get orderbookStream => _orderbookController.stream;

  @override
  Stream<Ticker> get tickerStream => _tickerController.stream;

  @override
  Future<void> connect() async {
    try {
      final channel = WebSocketChannel.connect(
        Uri.parse(
          "wss://fstream.binance.com/stream?streams=btcusdt@ticker/btcusdt@depth@500ms",
        ),
      );
      await channel.ready;

      channel.stream.listen((message) {
        var getData = jsonDecode(message);
        if (getData['stream'] == 'btcusdt@ticker') {
          _tickerController.add(Ticker.fromMap(getData['data']));
        } else if (getData['stream'] == 'btcusdt@depth@500ms') {
          _orderbookController.add(OrderBook.fromMap(getData['data']));
        }
      });
    } catch (e) {
      //TODO: handle error
      return;
    }
  }

  @override
  void dispose() {
    _channel?.sink.close();
    _channel = null;
    _orderbookController.close();
    _tickerController.close();
  }
}
