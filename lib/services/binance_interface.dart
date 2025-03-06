import 'package:sisyphus/models/candle.dart';
import 'package:sisyphus/models/order_book.dart';
import 'package:sisyphus/models/ticker.dart';

abstract class IBinanceService {
  Stream<Ticker> get tickerStream;
  Stream<OrderBook> get orderbookStream;
  Stream<Candle> get candleStickStream;
  Future<void> subscribeToCandleStream(String interval, String symbol);
  Future<void> connect(String symbol);
  void dispose();
}
