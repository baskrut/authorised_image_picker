import 'package:authorised_image_picker/consts.dart';
import 'package:authorised_image_picker/models/app_base_response.dart';
import 'package:authorised_image_picker/servises/token_service.dart';

class AuthService {
  final TokenService _tokenService = TokenService.instance;

  AuthService();

  Future<AppBaseResponse<String>> login({required String email, required String password}) async {
    return await Future.delayed(Duration(milliseconds: mockDelay)).then((_) {
      _tokenService.setToken('djcnxnxcc');
      return AppBaseResponse(result: 'djcnxnxcc');
    });
  }
}
