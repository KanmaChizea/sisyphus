import 'package:sisyphus/models/ticker.dart';

abstract class IBinanceService {
  Stream<Ticker> get tickerStream;
  Future<void> connect();
  void dispose();
}
