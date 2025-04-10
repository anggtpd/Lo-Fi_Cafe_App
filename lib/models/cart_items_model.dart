import 'package:loficafe/models/product_model.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  // Increase/decrease helpers
  void increaseQuantity() => quantity++;
  void decreaseQuantity() {
    if (quantity > 1) quantity--;
  }

  // Total price for this item
  int get totalPrice => product.price * quantity;
}
