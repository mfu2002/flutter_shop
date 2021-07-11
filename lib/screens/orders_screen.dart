import 'package:flutter/material.dart';
import 'package:flutter_shop/providers/orders_provider.dart';
import 'package:flutter_shop/widgets/app_drawer.dart';
import 'package:flutter_shop/widgets/order_list_item.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  const OrdersScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<OrdersProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: orders.orderCount,
        itemBuilder: (ctx, index) => OrderListItem(
          orderItem: orders.orders[index],
        ),
      ),
    );
  }
}
