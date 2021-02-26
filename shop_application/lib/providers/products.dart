import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shop_application/models/http_exception.dart';

import './product.dart';

class Products with ChangeNotifier {
  List<Product> _products = [];

  Future<void> fetchAndSetProducts() async {
    const url =
        'https://fir-for-flutter-study-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];

      if (products == null) return;
      extractedData.forEach(
        (productId, productData) => loadedProducts.add(
          Product(
            id: productId,
            title: productData['title'],
            description: productData['description'],
            price: productData['price'],
            imageUrl: productData['imageUrl'],
            isFavorite: productData['isFavorite'],
          ),
        ),
      );
      _products = loadedProducts;
      notifyListeners();
    } catch (error) {
      // hanling error
      throw (error);
    }
  }

  ///Get an instance of List of Products
  List<Product> get products {
    return [..._products];
  }

  ///Get List of favorite products
  List<Product> get favoriteProducts {
    return _products.where((element) => element.isFavorite == true).toList();
  }

  /// Add a Product to products List
  Future<void> addProduct(Product product) async {
    const url =
        'https://fir-for-flutter-study-default-rtdb.firebaseio.com/products.json';

    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'isFavorite': product.isFavorite
        }),
      );

      final newProduct = Product(
        title: product.title,
        price: product.price,
        description: product.description,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );

      _products.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final productIndex = _products.indexWhere((element) => element.id == id);
    if (productIndex >= 0) {
      final url =
          'https://fir-for-flutter-study-default-rtdb.firebaseio.com/products/$id.json';
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price,
            'isFavorite': newProduct.isFavorite,
          }));
      _products[productIndex] = newProduct;
      notifyListeners();
    } else {
      print('Products not found!');
    }
  }

  Future<void> deleteProduct(String id) async {
    final url =
        'https://fir-for-flutter-study-default-rtdb.firebaseio.com/products/$id.json';

    final existingProductIndex =
        _products.indexWhere((element) => element.id == id);
    var existingProduct = _products[existingProductIndex];
    _products.removeAt(existingProductIndex);
    notifyListeners();

    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _products.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }

    existingProduct = null;
  }

  /// Get a product by id, return [null] if haven't
  Product getProductById(String id) {
    return _products.firstWhere((product) => product.id == id);
  }
}
