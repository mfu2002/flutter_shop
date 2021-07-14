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
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Orders'),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
            future: Provider.of<OrdersProvider>(context, listen: false)
                .fetchAndSetOrders(),
            builder: (ctx, data) {
              if (data.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (data.error != null) {
                return Center(
                  child: const Text('An error occured!'),
                );
              } else {
                return Consumer<OrdersProvider>(
                  builder: (_, orderData, _2) => ListView.builder(
                    itemCount: orderData.orderCount,
                    itemBuilder: (ctx, index) => OrderListItem(
                      orderItem: orderData.orders[index],
                    ),
                  ),
                );
              }
            }));
  }
}
