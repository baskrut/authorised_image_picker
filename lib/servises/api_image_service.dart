import 'dart:convert';

import 'package:authorised_image_picker/consts.dart';
import 'package:authorised_image_picker/models/api_image_model.dart';
import 'package:authorised_image_picker/models/app_base_response.dart';
import 'package:authorised_image_picker/servises/api_requester.dart';

class ApiImageService {
  final ApiBaseRequester _apiRequester;

  ApiImageService(this._apiRequester);

  Future<AppBaseResponse<List<ApiImageModel>>> getImagesLIst({int? page}) async {
    String _page = '';
    if (page != null) _page = '&&page=$page';

    return await _apiRequester.handleRequest(type: RequestType.get, url: '$listUrl?limit=8$_page').then((
      response,
    ) async {
      if (response.body != null) {
        final List m = json.decode(response.body ?? '') ?? [];

        return AppBaseResponse(
          isSuccess: response.isSuccess,
          errorText: response.errorText,
          result: List<ApiImageModel>.from(m.map((e) => ApiImageModel.fromJson(e))),
        );
      } else {
        return AppBaseResponse(errorText: response.errorText, isSuccess: false);
      }
    });
  }
}
