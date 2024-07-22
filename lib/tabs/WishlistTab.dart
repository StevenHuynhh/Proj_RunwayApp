import 'package:flutter/material.dart';
import 'package:hello_world/models/product.dart';
import 'package:hello_world/models/shop.dart';
import 'package:provider/provider.dart';
import 'package:hello_world/components/product_tile.dart'; // Import the ProductTile widget

class WishlistTab extends StatelessWidget {
  const WishlistTab({super.key});

  void removeItemFromCart(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text("Remove this item from your cart?"),
        actions: [
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
              context
                  .read<Shop>()
                  .removeFromCart(product); // Remove item from cart
            },
            child: const Text("Remove"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<Shop>().cart; // Use cart instead of wishlist

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          // Title Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'These items spoke to you!',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final item = cart[index];
                return ProductTile(
                  product: item,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
