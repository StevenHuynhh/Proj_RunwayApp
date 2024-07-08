import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:hello_world/models/product.dart';
import 'package:hello_world/models/shop.dart';
import 'package:provider/provider.dart';

class ProductTile extends StatelessWidget {
  final Product product;

  const ProductTile({
    Key? key,
    required this.product,
  }) : super(key: key);

  void addToCart(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("Add this item to your wishlist?"),
        actions: [
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<Shop>().addToCart(product);
            },
            child: Text("Add"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 212, 170, 216),
        border: Border.all(
          color: Color.fromARGB(255, 250, 233, 233),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      margin: const EdgeInsets.all(35),
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            padding:
                EdgeInsets.all(10), // Increased padding to make the icon larger
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 253, 253),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(product.imagePath),
          ),
          SizedBox(height: 20), // Height between image and product
          Text(
            product.name,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 5),
          Text(
            product.description,
            style: TextStyle(
              fontSize: 18,
              color: Color.fromARGB(255, 93, 33, 99),
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 20), // Adjusted height for spacing
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(''),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 59, 16, 87),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  onPressed: () => addToCart(context),
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.redAccent,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
