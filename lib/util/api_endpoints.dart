import 'package:http/http.dart' as http;

class ApiEndpoints {
  static const baseUrl =
      'https://projectrunway.tech/api';

  static _AuthEndPoints authEndPoints = _AuthEndPoints(); // <- Change this line
}

class _AuthEndPoints {
  final String loginEmail = '/signin';
  final String registerEmail = '/signup';
  final String search = '/search';
}

