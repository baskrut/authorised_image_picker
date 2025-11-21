import 'package:authorised_image_picker/servises/auth_service.dart';
import 'package:authorised_image_picker/servises/token_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginProvider = AsyncNotifierProvider<LoginNotifier, String?>(LoginNotifier.new);

class LoginNotifier extends AsyncNotifier<String?> {
  final _apiAutService = AuthService();

  @override
  Future<String?> build() async {
    return null;
  }

  Future<String?> login(String email, String password) async {
    try {
      state = const AsyncValue.loading();

      final token = await _apiAutService.login(email: email, password: password);

      state = AsyncValue.data(token.result);
      return token.result;
    } catch (e, st) {
      debugPrintStack(stackTrace: st);
      state = AsyncValue.error(e, st);
      return null;
    }
  }

  Future<void> logout() async {
    TokenService.instance.logout();
  }
}
