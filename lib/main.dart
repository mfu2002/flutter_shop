import 'package:flutter/material.dart';
import 'package:flutter_shop/providers/cart_provider.dart';
import 'package:flutter_shop/providers/orders_provider.dart';
import 'package:flutter_shop/providers/products_provider.dart';
import 'package:flutter_shop/screens/cart_screen.dart';
import 'package:flutter_shop/screens/orders_screen.dart';
import 'package:flutter_shop/screens/product_detail_screen.dart';
import 'package:flutter_shop/screens/products_overview_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductsProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => OrdersProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato,'),
        debugShowCheckedModeBanner: false,
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (_) => ProductDetailScreen(),
          CartScreen.routeName: (_) => CartScreen(),
          OrdersScreen.routeName: (_) => OrdersScreen(),
        },
      ),
    );
  }
}
