import 'package:hello_world/components/product_tile.dart';
import 'package:hello_world/models/product.dart';

import 'package:test/test.dart';

void main() {
  group('Test start, URL extraction', () {
    test('Extract first valid URL', () {
      final p = Product(name: "", url: "", imagePath: "");
      final product_tile = ProductTile(product: p);
      var urls = "https://m.media-amazon.com/images/I/517c8G0AgSL._AC_UL320_.jpg";
      expect(product_tile.extractFirstValidUrl(urls), "https://m.media-amazon.com/images/I/517c8G0AgSL._AC_UL320_.jpg");
    });

    test('Return placeholder URL', () {
      final p = Product(name: "", url: "", imagePath: "");
      final product_tile = ProductTile(product: p);
      var urls = "lfjdksajfldksajflkdsajflkdsajflkdsjfldsa";
      expect(product_tile.extractFirstValidUrl(urls), "lib/images/placeholder.png");
    });
  });
}