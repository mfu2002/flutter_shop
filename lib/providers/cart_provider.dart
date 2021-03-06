import 'package:flutter/material.dart';
import 'package:flutter_shop/models/cart_item.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  void addItem(String prdId, double price, String title, {int quantity = 1}) {
    if (_items.containsKey(prdId)) {
      _items.update(
          prdId,
          (value) => CartItem(
              title: value.title,
              id: value.id,
              quantity: value.quantity + quantity,
              price: value.price));
    } else {
      _items.putIfAbsent(
          prdId,
          () => CartItem(
              title: title,
              id: DateTime.now().toString(),
              quantity: quantity,
              price: price));
    }
    notifyListeners();
  }

  int get itemCount => _items.length;

  double get totalAmount {
    var total = 0.0;
    _items.forEach((_, value) => total += value.price * value.quantity);
    return total;
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

  void removeSingleItem(String prdId) {
    if (!_items.containsKey(prdId)) return;
    if (_items[prdId].quantity > 1) {
      _items.update(
          prdId,
          (oldValue) => CartItem(
              title: oldValue.title,
              id: oldValue.id,
              quantity: oldValue.quantity - 1,
              price: oldValue.price));
    } else {
      _items.remove(prdId);
    }
    notifyListeners();
  }

  void removeItem(String prdId) {
    _items.remove(prdId);
    notifyListeners();
  }
}
