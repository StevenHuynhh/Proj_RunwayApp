import 'package:flutter/material.dart';
import 'package:hello_world/models/product.dart';
import 'package:hello_world/models/shop.dart';
import 'package:provider/provider.dart';

import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

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

  String extractFirstValidUrl(String urls) {
    // Remove unwanted characters and split by spaces
    final urlList =
        urls.replaceAll(RegExp(r'[^\w\s:/\.\-]'), '').split(RegExp(r'\s+'));
    for (var url in urlList) {
      // Check if the URL is valid
      final cleanedUrl = url.trim();
      if (Uri.tryParse(cleanedUrl)?.hasAbsolutePath ?? false) {
        return cleanedUrl;
      }
    }
    // Return a placeholder URL if no valid URL is found
    return 'lib/images/placeholder.png';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Shop>(
      builder: (context, shop, child) {
        final isInCart = shop.cart.contains(product);

        // Extract the first valid URL
        String imageUrl = extractFirstValidUrl(product.imagePath);

        // Debug print to check the product's image path
        print('Product: ${product.name}, Image: $imageUrl');

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
                child: imageUrl.isNotEmpty
                    ? Image.network(
                        imageUrl,
                        errorBuilder: (context, error, stackTrace) {
                          // Handle any errors and use placeholder image if needed
                          print('Error loading image: $error');
                          return Image.asset('lib/images/placeholder.png');
                        },
                      )
                    : Image.asset(
                        'lib/images/placeholder.png'), // Fallback image
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
              Linkify(
                onOpen: (link) async {
                  if (!await launchUrl(Uri.parse(link.url))) {
                    throw Exception('Could not launch ${link.url}');
                  }
                },
                text: product.url,
                style: TextStyle(
                  color: Color.fromARGB(255, 211, 154, 245),
                  fontSize: 14,
                  decoration: TextDecoration.underline,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
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
