import 'package:authorised_image_picker/consts.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

class Prefs {
  static final _prefs = EncryptedSharedPreferences();

  Future<void> setAccessToken(String token) async {
    await _prefs.setString(accessToken, token);
  }

  Future<String> getAccessToken() async {
    return await _prefs.getString(accessToken);
  }

  void clear() async {
    await _prefs.clear();
  }
}
