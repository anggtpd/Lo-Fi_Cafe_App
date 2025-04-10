import 'package:flutter/material.dart';
import 'package:loficafe/models/product_model.dart';
import 'package:loficafe/models/cart_items_model.dart';

class CartProvider extends ChangeNotifier {
  List<CartItem> _cartItems = [];
  List<CartItem> get cartItems => _cartItems.reversed.toList();

  void addToCart(Product product) {
    final index =
        _cartItems.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      _cartItems[index].increaseQuantity();
    } else {
      _cartItems.add(CartItem(product: product));
    }
    notifyListeners();
  }

  void increaseQuantity(Product product) {
    final index =
        _cartItems.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      _cartItems[index].increaseQuantity();
      notifyListeners();
    }
  }

  void decreaseQuantity(Product product) {
    final index =
        _cartItems.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      if (_cartItems[index].quantity > 1) {
        _cartItems[index].decreaseQuantity();
      } else {
        // If quantity is 1, remove item from cart
        _cartItems.removeAt(index);
      }
      notifyListeners();
    }
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cartItems.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  int get itemCount =>
      _cartItems.fold(0, (sum, cartItems) => sum + cartItems.quantity);

  int get totalPrice => _cartItems.fold(
        0,
        (sum, cartItems) => sum + cartItems.totalPrice,
      );
}
