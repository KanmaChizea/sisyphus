import 'package:equatable/equatable.dart';

class Order extends Equatable {
  final double price;
  final double quantity;
  final double total;
  const Order({required this.price, required this.quantity})
    : total = price * quantity;

  factory Order.fromList(List list) {
    final price = double.tryParse(list[0]) ?? 0;
    final quantity = double.tryParse(list[1]) ?? 0;
    return Order(price: price, quantity: quantity);
  }

  @override
  List<Object?> get props => [price, quantity, total];
}
