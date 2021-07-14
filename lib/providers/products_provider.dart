import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop/models/http_exception.dart';
import 'package:flutter_shop/providers/product_provider.dart';
import 'package:http/http.dart' as http;

class ProductsProvider with ChangeNotifier {
  //static const _firebaseUrl = 'flutter-shop-b2b69-default-rtdb.firebaseio.com';
  //static const _firebaseProducts = '/products.json';

  List<ProductProvider> _items = [];

  final String authToken;
  final String userId;
  ProductsProvider(this.authToken, this.userId, this._items);

  List<ProductProvider> get items {
    return [..._items];
  }

  List<ProductProvider> get favouriteItems {
    return items.where((product) => product.isFavourite).toList();
  }

  ProductProvider findById(String id) =>
      _items.firstWhere((product) => product.id == id);

  Future<void> fetchAndSetProducts({bool filterByUser = false}) async {
    final filterString =
        filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    final url = Uri.parse(
        'https://flutter-shop-b2b69-default-rtdb.firebaseio.com/products.json?auth=$authToken&$filterString');

    try {
      final respoonse = await http.get(url);
      final extractedData = json.decode(respoonse.body) as Map<String, dynamic>;
      if (extractedData == null) return;
      final favouriteUrl = Uri.parse(
          'https://flutter-shop-b2b69-default-rtdb.firebaseio.com/userFavourites/$userId.json?auth=$authToken');
      final favouriteResponse = await http.get(favouriteUrl);

      final favouriteData = json.decode(favouriteResponse.body);

      final List<ProductProvider> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(ProductProvider(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          imageUrl: prodData['imageUrl'],
          isFavourite:
              favouriteData == null ? false : favouriteData[prodId] ?? false,
        ));
        _items = loadedProducts;
        notifyListeners();
      });
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addProduct(ProductProvider product) async {
    final url = Uri.parse(
        'https://flutter-shop-b2b69-default-rtdb.firebaseio.com/products.json?auth=$authToken');
    final response = await http.post(url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'creatorId': userId
        }));
    final newProduct = ProductProvider(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl);

    _items.add(newProduct);
    notifyListeners();
  }

  Future<void> updateProduct(ProductProvider product) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == product.id);
    if (prodIndex >= 0) {
      final url = Uri.parse(
          'https://flutter-shop-b2b69-default-rtdb.firebaseio.com/products/${product.id}.json?auth=$authToken');
      http.patch(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
          }));
      _items[prodIndex] = product;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String prdId) async {
    final url = Uri.parse(
        'https://flutter-shop-b2b69-default-rtdb.firebaseio.com/products/$prdId.json?auth=$authToken');

    final existingProductIndex =
        _items.indexWhere((element) => element.id == prdId);
    var existingProduct = _items[existingProductIndex];

    _items.removeAt(existingProductIndex);
    notifyListeners();

    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete the product.');
    }
    existingProduct = null;
  }
}
