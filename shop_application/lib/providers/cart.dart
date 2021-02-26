import 'package:flutter/foundation.dart';

class CartItem {
  /// The id of the cartItem in the cart
  final String id;

  /// The title of product
  final String title;

  /// The quantity of product in the cartItem
  final int quantity;

  /// Price of product per item
  final double price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  ///String here is the productId
  Map<String, CartItem> _items = {};

  /// Get the list of products, this return [Map<String,CartItem>] instance
  Map<String, CartItem> get items {
    return {..._items};
  }

  /// Get the number of item in the list
  int get itemCount {
    return _items.length;
  }

  /// Add an Item to the cart list, if the item is already add, increase the [quantity] by 1
  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      //Change quantity
      _items.update(
        productId,
        (existingCartItem) => CartItem(
            id: existingCartItem.id,
            title: existingCartItem.title,
            quantity: existingCartItem.quantity + 1,
            price: existingCartItem.price),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          quantity: 1,
          price: price,
        ),
      );
    }
    notifyListeners();
  }

  /// Get the total price of the cart
  double get totalPrice {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  /// Remove the item from the cart, this take CartItem [id] which is key as argument
  void removeItem(String productId) {
    _items.removeWhere((key, value) => key == productId);
    notifyListeners();
  }

  /// This will check if contain product, if haven't => return
  /// else this will decrease the quantity by 1
  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) return;
    if (_items[productId].quantity > 1)
      _items.update(
          productId,
          (value) => CartItem(
              id: value.id,
              title: value.title,
              quantity: value.quantity - 1,
              price: value.price));
    else
      _items.removeWhere((key, value) => key == productId);
    notifyListeners();
  }

  /// Clear the cart
  void clear() {
    _items.clear();
    notifyListeners();
  }
}
