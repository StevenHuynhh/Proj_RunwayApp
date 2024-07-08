class ApiEndpoints {
  static final String baseUrl = 'http://restapi.adequateshop.com/api/';
  static _AuthEndPoints authEndPoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String registerEmail = 'authaccount/registration';
  final String loginEmail = 'authaccount/login';
}
