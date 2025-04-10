import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:loficafe/provider/cart_provider.dart';
import 'package:loficafe/models/cart_items_model.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final List<CartItem> products = context.watch<CartProvider>().cartItems;
    int itemCount = context.read<CartProvider>().itemCount;
    int totalPrice = context.read<CartProvider>().totalPrice;
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                context.read<CartProvider>().clearCart();
              },
              icon: const Icon(Icons.remove_shopping_cart))
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Container(
            margin: const EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    product.product.imageUrl, // Assuming this exists
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.product.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      Text('Rp${product.product.price.toString()}'),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              context
                                  .read<CartProvider>()
                                  .decreaseQuantity(product.product);
                            },
                            icon: const Icon(Icons.remove),
                          ),
                          Text('${product.quantity}'),
                          IconButton(
                            onPressed: () {
                              context
                                  .read<CartProvider>()
                                  .increaseQuantity(product.product);
                            },
                            icon: const Icon(Icons.add),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          children: [
            Text('Total $itemCount Products'),
            SizedBox(
              width: 20,
            ),
            Text('Rp$totalPrice'),
            Spacer(),
            ElevatedButton(onPressed: () {}, child: Text('Check Out'))
          ],
        ),
      ),
    );
  }
}
