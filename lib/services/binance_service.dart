import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:sisyphus/models/ticker.dart';
import 'package:sisyphus/services/binance_interface.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class BinanceService implements IBinanceService {
  WebSocketChannel? _channel;
  final StreamController<Ticker> _tickerController =
      StreamController<Ticker>.broadcast();
  final StreamController<Map<String, dynamic>> _orderbookController =
      StreamController<Map<String, dynamic>>.broadcast();

  Stream<Map<String, dynamic>> get orderbookStream =>
      _orderbookController.stream;

  @override
  Stream<Ticker> get tickerStream => _tickerController.stream;

  @override
  Future<void> connect() async {
    try {
      final channel = WebSocketChannel.connect(
        Uri.parse("wss://fstream.binance.com/stream?streams=btcusdt@ticker"),
      );
      await channel.ready;

      channel.stream.listen((message) {
        var getData = jsonDecode(message);
        if (getData['stream'] == 'btcusdt@ticker') {
          _tickerController.add(Ticker.fromMap(getData['data']));
        }
        _orderbookController.add(getData);
      });
    } catch (e) {
      log('WebSocket error: $e');
      return;
    }
  }

  void dispose() {
    _channel?.sink.close();
    _channel = null;
    _orderbookController.close();
    _tickerController.close();
  }
}
