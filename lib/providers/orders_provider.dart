import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_shop/models/cart_item.dart';
import 'package:flutter_shop/models/order_item.dart';
import 'package:http/http.dart' as http;

class OrdersProvider with ChangeNotifier {
  // static const _firebaseUrl = 'flutter-shop-b2b69-default-rtdb.firebaseio.com';
  // static const _firebaseProducts = '/orders.json';

  List<OrderItem> _orders = [];
  final String authToken;
  final String userId;

  OrdersProvider(this.authToken, this.userId, this._orders);

  List<OrderItem> get orders {
    return [..._orders];
  }

  int get orderCount => _orders.length;

  Future<void> fetchAndSetOrders() async {
    final url = Uri.parse(
        'https://flutter-shop-b2b69-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken');
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) return;
    final List<OrderItem> loadedOrders = [];
    extractedData.forEach((key, value) {
      loadedOrders.add(OrderItem(
        id: key,
        amount: value['amount'],
        dateTime: DateTime.parse(value['dateTime']),
        products: (value['products'] as List<dynamic>)
            .map(
              (item) => CartItem(
                title: item['title'],
                id: item['id'],
                quantity: item['quantity'],
                price: item['price'],
              ),
            )
            .toList(),
      ));
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = Uri.parse(
        'https://flutter-shop-b2b69-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken');
    final timestamp = DateTime.now();
    final response = await http.post(url,
        body: json.encode({
          'amount': total,
          'dateTime': timestamp.toIso8601String(),
          'products': cartProducts
              .map((cartProduct) => {
                    'id': cartProduct.id,
                    'title': cartProduct.title,
                    'quantity': cartProduct.quantity,
                    'price': cartProduct.price,
                  })
              .toList()
        }));
    _orders.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        products: cartProducts,
        dateTime: timestamp,
      ),
    );
    notifyListeners();
  }
}
