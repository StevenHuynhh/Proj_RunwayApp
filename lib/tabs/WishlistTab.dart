import 'package:flutter/material.dart';
import 'package:hello_world/models/product.dart';
import 'package:hello_world/models/shop.dart';
import 'package:provider/provider.dart';

class WishlistTab extends StatelessWidget {
  const WishlistTab({super.key});

  void removeItemFromCart(BuildContext context, Product product) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
                content: const Text("Remove this item from your wishlist?"),
                actions: [
                  MaterialButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel"),
                  ),
                  MaterialButton(
                    onPressed: () {
                      Navigator.pop(context);

                      context.read<Shop>().removeFromCart(product);
                    },
                    child: const Text("Remove"),
                  )
                ]));
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<Shop>().cart;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 244, 243, 245),
        body: Column(children: [
          Expanded(
              child: ListView.builder(
                  itemCount: cart.length,
                  itemBuilder: (context, index) {
                    final item = cart[index];

                    return ListTile(
                      title: Text(item.name),
                      trailing: IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () => removeItemFromCart(context, item)),
                    );
                  }))
        ]));
  }
}
