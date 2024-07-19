import 'package:flutter/material.dart';
import 'package:hello_world/components/product_tile.dart';
import 'package:hello_world/models/product.dart';
import 'package:hello_world/models/shop.dart';
import 'package:provider/provider.dart';

class ExploreTab extends StatefulWidget {
  const ExploreTab({super.key});

  @override
  _ExploreTabState createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab> {
  TextEditingController _searchController = TextEditingController();
  List<Product> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _filteredProducts = context.read<Shop>().shop;
    _searchController.addListener(_filterProducts);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterProducts() {
    final query = _searchController.text.toLowerCase();
    final allProducts = context.read<Shop>().shop;

    setState(() {
      _filteredProducts = allProducts
          .where((product) => product.name.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(color: Colors.white), // Input text color
              decoration: InputDecoration(
                hintText: 'Search products...',
                hintStyle:
                    const TextStyle(color: Colors.white54), // Hint text color
                prefixIcon: const Icon(Icons.search,
                    color: Color.fromARGB(255, 184, 177, 177)), // Icon color
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide:
                      const BorderSide(color: Colors.white), // Border color
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                      color: Colors.white), // Focused border color
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredProducts.length,
              padding: const EdgeInsets.all(5),
              itemBuilder: (context, index) {
                final product = _filteredProducts[index];
                return ProductTile(product: product);
              },
            ),
          ),
        ],
      ),
    );
  }
}
