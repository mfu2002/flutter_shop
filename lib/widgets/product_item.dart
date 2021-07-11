import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/providers/product_provider.dart';
import 'package:flutter_shop/screens/product_detail_screen.dart';
import 'package:provider/provider.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          onTap: () {
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                arguments: product.id);
          },
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            color: Theme.of(context).accentColor,
            icon: Icon(
                product.isFavourite ? Icons.favorite : Icons.favorite_outline),
            onPressed: product.toggleFavouriteStatus,
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            onPressed: product.toggleFavouriteStatus,
            icon: const Icon(Icons.shopping_cart),
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
