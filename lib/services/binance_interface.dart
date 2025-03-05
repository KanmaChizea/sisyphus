import 'package:sisyphus/models/order_book.dart';
import 'package:sisyphus/models/ticker.dart';

abstract class IBinanceService {
  Stream<Ticker> get tickerStream;
  Stream<OrderBook> get orderbookStream;
  Future<void> connect();
  void dispose();
}
