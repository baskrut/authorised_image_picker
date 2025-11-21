import 'package:authorised_image_picker/servises/prefs_servise.dart';

class TokenService {
  TokenService._privateConstructor();

  static final TokenService instance = TokenService._privateConstructor();

  final Prefs _prefs = Prefs();

  String _accessToken = '';

  setToken(String token) async {
    _accessToken = token;
    await updatePrefs();
  }

  String get accessToken {
    return _accessToken;
  }

  Future<void> updatePrefs() async {
    await _prefs.setAccessToken(_accessToken);
  }

  loadAccessToken() async {
    _accessToken = await _prefs.getAccessToken();
  }

  void logout() async {
    _accessToken = '';

    _prefs.clear();
  }
}
