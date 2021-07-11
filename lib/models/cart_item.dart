import 'package:flutter/cupertino.dart';
import 'package:flutter_shop/providers/cart_provider.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  const CartItem({
    @required this.title,
    @required this.id,
    @required this.quantity,
    @required this.price,
  });
}
