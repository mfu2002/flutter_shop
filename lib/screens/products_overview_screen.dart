import 'package:flutter/material.dart';
import 'package:flutter_shop/providers/products_provider.dart';
import 'package:flutter_shop/widgets/products_grid.dart';
import 'package:provider/provider.dart';

enum FilterOptions {
  Favourites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  ProductsOverviewScreen({Key key}) : super(key: key);

  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavourites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: const Text('Only Favourites'),
                value: FilterOptions.Favourites,
              ),
              PopupMenuItem(
                child: const Text('Show all'),
                value: FilterOptions.All,
              ),
            ],
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                switch (selectedValue) {
                  case FilterOptions.Favourites:
                    _showOnlyFavourites = true;
                    break;
                  case FilterOptions.All:
                    _showOnlyFavourites = false;
                    break;
                }
              });
            },
          )
        ],
      ),
      body: ProductsGrid(showOnlyFavourites: _showOnlyFavourites),
    );
  }
}
