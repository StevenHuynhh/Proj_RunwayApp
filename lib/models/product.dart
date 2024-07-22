class Product {
  final String name;
  final String url;
  final String imagePath;

  Product({
    required this.name,
    required this.url,
    required this.imagePath,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'] ?? 'Unknown',
      url: json['url'] ?? 'Unknown',
      imagePath: json['images'] != null && json['images'].isNotEmpty
          ? json['images'][0]['src']
          : 'assets/placeholder.png', // Fallback image if no images are provided
    );
  }
}
