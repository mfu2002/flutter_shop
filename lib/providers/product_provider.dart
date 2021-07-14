import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop/models/http_exception.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;

  ProductProvider({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavourite = false,
  });

  Future<void> toggleFavouriteStatus(String authToken, String userId) async {
    final url = Uri.parse(
        'https://flutter-shop-b2b69-default-rtdb.firebaseio.com/userFavourites/$userId/$id.json?auth=$authToken');
    isFavourite = !isFavourite;
    notifyListeners();
    final response = await http.put(url, body: json.encode(isFavourite));
    if (response.statusCode >= 400) {
      isFavourite = !isFavourite;
      notifyListeners();
      throw HttpException('Unable to toggle favourite preference.');
    }
  }
}
