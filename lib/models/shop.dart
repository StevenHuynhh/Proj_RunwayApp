import 'package:flutter/material.dart';
import 'package:hello_world/models/product.dart';

class Shop extends ChangeNotifier {
  final List<Product> _shop = [
    Product(
        name: "Product 1",
        description: "Item description",
        imagePath: 'lib/images/PradaShirt.png'),
    Product(
        name: "Product 2",
        description: "Item description",
        imagePath: 'lib/images/PradaShirt.png'),
    Product(
        name: "Product 3",
        description: "Item description",
        imagePath: 'lib/images/PradaShirt.png'),
    Product(
        name: "Product 4",
        description: "Item description",
        imagePath: 'lib/images/PradaShirt.png'),
  ];

  List<Product> _cart = [];

  List<Product> get shop => _shop;

  List<Product> get cart => _cart;

  void addToCart(Product item) {
    _cart.add(item);
    notifyListeners();
  }

  void removeFromCart(Product item) {
    _cart.remove(item);
    notifyListeners();
  }
}
