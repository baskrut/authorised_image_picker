import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:authorised_image_picker/consts.dart';
import 'package:authorised_image_picker/models/app_base_response.dart';
import 'package:authorised_image_picker/servises/token_service.dart';
import 'package:http/http.dart';

enum RequestType {
  get,
  patch,
  post,
  put,
  delete,
}

class ApiBaseRequester {
  ApiBaseRequester._privateConstructor();

  static final ApiBaseRequester instance = ApiBaseRequester._privateConstructor();

  final TokenService _tokenService = TokenService.instance;

  Future<AppBaseResponse> handleRequest({
    required RequestType type,
    required String url,
    Map<String, dynamic>? body,
    bool needToken = true,

    bool shouldRefresh = true,
  }) async   {
    final Map<String, String> header = needToken ? tokenHeaders : withoutTokenHeaders;

    log('~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
        '\n\nrequest $url, type: $type,\nrequest header: $header\nrequest body: ${body ?? ''}');



    final Response response;
    switch (type) {
      case RequestType.get:
        response = await get(
          Uri.parse(url),
          headers: header,
        ).onError((e, stackTrace) {
          log(e.runtimeType.toString());
          return Response('', httpErrorCode);
        }).timeout(const Duration(seconds: requestTimeOut), onTimeout: () async {
          log('onTimeout');
          return Response('', httpTimeOutCode);
        });
        break;
      case RequestType.post:
        response = await post(
          Uri.parse(url),
          headers: header,
          body: body != null ? json.encode(body) : '',
        ).onError((e, stackTrace) {
          log(e.runtimeType.toString());
          return Response('', httpErrorCode);
        }).timeout(const Duration(seconds: requestTimeOut), onTimeout: () async {
          log('onTimeout');
          return Response('', httpTimeOutCode);
        });
        break;
      case RequestType.patch:
        response = await patch(
          Uri.parse(url),
          headers: header,
          body: body != null ? json.encode(body) : '',
        ).onError((e, stackTrace) {
          log(e.runtimeType.toString());
          return Response('', httpErrorCode);
        }).timeout(const Duration(seconds: requestTimeOut), onTimeout: () async {
          log('onTimeout');
          return Response('', httpTimeOutCode);
        });
        break;
      case RequestType.put:
        response = await put(
          Uri.parse(url),
          headers: header,
          body: body != null ? json.encode(body) : '',
        ).onError((e, stackTrace) {
          log(e.runtimeType.toString());
          return Response('', httpErrorCode);
        }).timeout(const Duration(seconds: requestTimeOut), onTimeout: () async {
          log('onTimeout');
          return Response('', httpTimeOutCode);
        });
        break;
      case RequestType.delete:
        response = await delete(
          Uri.parse(url),
          headers: header,
          body: body != null ? json.encode(body) : '',
        ).onError((e, stackTrace) {
          log(e.runtimeType.toString());
          return Response('', httpErrorCode);
        }).timeout(const Duration(seconds: requestTimeOut), onTimeout: () async {
          log('onTimeout');
          return Response('', httpTimeOutCode);
        });
        break;
    }

    log('statusCode ${response.statusCode}\nresponse body\n ${response.body.isEmpty ? 'empty' : response.body}\n');

    if (response.statusCode == 200 ) {
      return AppBaseResponse(body: response.body, isSuccess: true,);
    } else if (response.statusCode == 401) {
      if (shouldRefresh) {
      return  await refresh(lastTry: true).then((_) async {
          return handleRequest(type: type, url: url, body: body, needToken: needToken, shouldRefresh: false);
        });
      } else {
        return AppBaseResponse(
          isSuccess: false,
          errorText: json.decode(response.body)?["error"]?['message'] ?? 'Помилка аторизації',
        );
      }
    } else if (response.statusCode == httpTimeOutCode || response.statusCode == httpErrorCode) {

      return AppBaseResponse(isSuccess: false);
    } else if (response.statusCode == 422) {
      return AppBaseResponse(errorText: json.decode(response.body)?["error"]?['message'] ?? 'Щось пішло не так', isSuccess: false);
    } else {
      return AppBaseResponse(errorText: response.body.isNotEmpty ? json.decode(response.body)?["error"]?['message'] ?? 'Щось пішло не так' : 'Щось пішло не так', isSuccess: false);
    }
  }

  Map<String, String> get tokenHeaders {
    return {

      "Authorization": "Bearer ${_tokenService.accessToken}",

      "Content-Type": "application/json",
      "Accept": "application/json",
    };
  }

  Map<String, String> withoutTokenHeaders = {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "Accept-Encoding": "gzip, deflate, br",
  };

  refresh({bool? lastTry}) async {
    log('***********************TokenService try refresh ***********************');
    log('\n*\n***********${DateTime.now()}*\n*\n*');

    Response response = await get(
      Uri.parse('$baseUrl/token'),
      headers: withoutTokenHeaders,
    ).onError((e, stackTrace) async {
      if (lastTry == true) {
        return Response('', httpErrorCode);
      } else if (lastTry == false) {
        return await refresh(lastTry: true);
      } else {
        return await refresh(lastTry: false);
      }
    }).timeout(const Duration(seconds: 120), onTimeout: () async {
      if (lastTry == true) {
        return Response('', httpTimeOutCode);
      } else if (lastTry == false) {
        return await refresh(lastTry: true);
      } else {
        return await refresh(lastTry: false);
      }
    });

    log('TokenService.refresh statusCode ${response.statusCode}');
    log('token response.body\n${response.body}');

    if (response.statusCode == HttpStatus.ok) {
      return await _tokenService.setToken(json.decode(response.body)['data']).then((_) {
        return response;
      });
    } else if (response.statusCode >= 500) {
      if (lastTry == true) {
        return Response('', httpErrorCode);
      } else if (lastTry == false) {
        return await refresh(lastTry: true);
      } else {
        return await refresh(lastTry: false);
      }
    } else if (response.statusCode == 401) {
      throw UnauthorisedException();
    } else {
      return Response('', httpErrorCode);
    }
  }
}

class UnauthorisedException implements Exception {
  UnauthorisedException();
}

class TimeOutException implements Exception {
  TimeOutException();
}
