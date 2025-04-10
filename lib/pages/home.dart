import "package:flutter/material.dart";
import "package:loficafe/pages/cart.dart";
import 'package:loficafe/provider/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:loficafe/data/product_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Lo-Fi Cafe'),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CartPage()));
                },
                icon: const Icon(Icons.shopping_cart))
          ],
        ),
        body: GridView.builder(
          padding: const EdgeInsets.all(8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product image
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: AssetImage(product.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 4),

                    // Product name
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                    // Product price
                    Text('Rp ${product.price}'),

                    // Add to cart or Quantity control
                    Consumer<CartProvider>(
                      builder: (context, cartProvider, _) {
                        final isInCart = cartProvider.cartItems
                            .any((item) => item.product == product);

                        if (!isInCart) {
                          return SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                cartProvider.addToCart(product);
                              },
                              child: const Text('Add to Cart'),
                            ),
                          );
                        } else {
                          final quantity = cartProvider.cartItems
                              .firstWhere((item) => item.product == product)
                              .quantity;

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  cartProvider.decreaseQuantity(product);
                                },
                              ),
                              Text('$quantity'),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  cartProvider.increaseQuantity(product);
                                },
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
