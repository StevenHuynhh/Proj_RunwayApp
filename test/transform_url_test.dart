import 'package:hello_world/models/shop.dart';

import 'package:test/test.dart';

void main() {
  group('Test start, URL transformations', () {
    test('URL should transform', () {
      var shein_url =
          "https://storage.yandexcloud.net/clothes-and-wildberries/clothes-parsing-dataset/shein/2022/10/24/16665771928730b0d5e549be43bb6d9f2cc5c73b88_thumbnail_600x.webp";
      expect(transformUrl(shein_url),
          "https://img.ltwebstatic.com/images3_pi/2022/10/24/16665771928730b0d5e549be43bb6d9f2cc5c73b88_thumbnail_600x.webp");
    });

    test('URL should be unchanged', () {
      var amazon_url =
          "https://m.media-amazon.com/images/I/517c8G0AgSL._AC_UL320_.jpg";
      expect(transformUrl(amazon_url), amazon_url);
    });
  });
}
