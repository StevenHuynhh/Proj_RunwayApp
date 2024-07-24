import 'package:hello_world/models/product.dart';
import 'package:hello_world/models/shop.dart';

import 'package:test/test.dart';

void main() {
  group('Test start, Shop', () {
    test('Initialize empty shop', () {
      final s = Shop();
      expect(s.shop, []);
      expect(s.cart, []);
    });

    test('Add a product to a shop', () {
      final p = Product(name: "Test", url: "https://test.com", imagePath: "https://test.com/image");
      final s = Shop();
      s.addToCart(p);
      expect(s.cart, [p]);
    });
  });
}