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
    context.read<Shop>().addToCart(product);
  }

  void removeFromCart(BuildContext context) {
    context.read<Shop>().removeFromCart(product);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Shop>(
      builder: (context, shop, child) {
        final isInCart = shop.cart.contains(product);

        return Container(
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(
              color: Color.fromARGB(255, 146, 37, 247),
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
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: product.imagePath.isNotEmpty
                    ? Image.network(product.imagePath)
                    : Image.asset('assets/placeholder.png'), // Fallback image
              ),
              SizedBox(height: 10),
              Text(
                product.name,
                style: TextStyle(
                  color: Color.fromARGB(255, 146, 37, 247),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(''),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      onPressed: () => isInCart
                          ? removeFromCart(context)
                          : addToCart(context),
                      icon: Icon(
                        Icons.favorite,
                        color: isInCart
                            ? Color.fromARGB(255, 240, 122, 240)
                            : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
