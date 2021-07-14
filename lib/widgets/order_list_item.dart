import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_shop/models/order_item.dart';
import 'package:intl/intl.dart';

class OrderListItem extends StatefulWidget {
  final OrderItem orderItem;

  const OrderListItem({
    Key key,
    this.orderItem,
  }) : super(key: key);

  @override
  _OrderListItemState createState() => _OrderListItemState();
}

class _OrderListItemState extends State<OrderListItem> {
  var _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: _isExpanded
          ? min(widget.orderItem.products.length * 20.0 + 110, 200)
          : 95,
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            ListTile(
              title: Text('\$${widget.orderItem.amount}'),
              subtitle: Text(DateFormat('dd/MM/yyyy hh:mm')
                  .format(widget.orderItem.dateTime)),
              trailing: IconButton(
                  onPressed: () => setState(() => _isExpanded = !_isExpanded),
                  icon: Icon(
                      _isExpanded ? Icons.expand_less : Icons.expand_more)),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: _isExpanded
                  ? min(widget.orderItem.products.length * 20.0 + 10, 100)
                  : 0,
              child: ListView.builder(
                itemBuilder: (_, index) {
                  final prod = widget.orderItem.products[index];
                  return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          prod.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${prod.quantity}x \$${prod.price}',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        )
                      ]);
                },
                itemCount: widget.orderItem.products.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
