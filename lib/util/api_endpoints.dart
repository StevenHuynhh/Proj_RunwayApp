class ApiEndpoints {
  static const baseUrl =
      'https://cop4331-runway-0afcfa4da5a9.herokuapp.com/api';

  static _AuthEndPoints authEndPoints = _AuthEndPoints(); // <- Change this line
}

class _AuthEndPoints {
  final String loginEmail = '/signin';
  final String registerEmail = '/signup';
}
