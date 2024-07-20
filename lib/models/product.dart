class Product {
  final String name;
  final String url;
  final String imagePath;

  Product({required this.name, required this.url, required this.imagePath});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      url: json['url'],
      imagePath: json['imageUrl'],
    );
  }
}
