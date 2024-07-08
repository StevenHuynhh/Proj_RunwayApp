import 'package:flutter/material.dart';
import 'package:hello_world/components/product_tile.dart';
import 'package:hello_world/models/shop.dart';
import 'package:provider/provider.dart';

class ExploreTab extends StatelessWidget {
  const ExploreTab({super.key});

  @override
  Widget build(BuildContext context) {
    final products = context.watch<Shop>().shop;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView.builder(
          itemCount: products.length,
          padding: const EdgeInsets.all(5),
          itemBuilder: (context, index) {
            final product = products[index];

            return ProductTile(product: product);
          }),
    );
  }
}
