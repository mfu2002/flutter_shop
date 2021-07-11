import 'package:flutter/cupertino.dart';
import 'package:flutter_shop/models/cart_item.dart';
import 'package:flutter_shop/models/order_item.dart';

class OrdersProvider with ChangeNotifier {
  List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  int get orderCount => _orders.length;

  void addOrder(List<CartItem> cartProducts, double total) {
    _orders.insert(
      0,
      OrderItem(
        id: DateTime.now().toString(),
        amount: total,
        products: cartProducts,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
