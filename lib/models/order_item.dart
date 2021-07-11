import 'package:flutter/cupertino.dart';
import 'package:flutter_shop/models/cart_item.dart';
import 'package:flutter_shop/providers/orders_provider.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  const OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}
