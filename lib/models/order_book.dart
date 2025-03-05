import 'package:equatable/equatable.dart';

import 'package:sisyphus/models/order.dart';

class OrderBook extends Equatable {
  final List<Order> bids;
  final List<Order> asks;
  const OrderBook({required this.bids, required this.asks});

  factory OrderBook.fromMap(Map<String, dynamic> map) {
    return OrderBook(
      bids: List<Order>.from(
        (map['b'] as List).map<Order>((x) => Order.fromList(x)),
      ),
      asks: List<Order>.from(
        (map['a'] as List).map<Order>((x) => Order.fromList(x)),
      ),
    );
  }

  @override
  List<Object?> get props => [bids, asks];
}
