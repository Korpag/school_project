// ignore_for_file: avoid_print
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart';
import 'package:school_project/utils/api_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum APIMethod {
  get,
  post,
  put,
  delete,
  patch,
}

class APIRequest {
  static late APIRequest instance;

  APIRequest();

  /// запрос
  send(String path, APIMethod method,
      {Map<String, dynamic>? data,
      Map<String, String>? headers,
      String? field,
      bool isMultipart = false,
      Stream<Uint8List>? stream,
      int? length}) async {
    /// Готовим headers
    var _headers = isMultipart
        ? {'Content-Type': 'multipart/form-data'}
        : {'Content-Type': 'application/json; charset=UTF-8'};
    _headers.addAll(headers ?? {});

    /// TODO Временно, пока не авторизации
    final SharedPreferences pref = await SharedPreferences.getInstance();
    _headers.addAll({"X-AUTH-TOKEN": pref.getString('key')!, "X-USER-ID": "3"});

    try {
      var response = await _sendRequest(path, method,
          data: data,
          field: field,
          headers: _headers,
          isMultipart: isMultipart,
          stream: stream,
          length: length);
      response = isMultipart ? await Response.fromStream(response) : response;

      /// Логируем результат запроса
      if (APIConfig.logging) {
        print('RESPONSE START -----------------------------------------');
        print('RESPONSE STATUS = ${response.statusCode}');
        print('RESPONSE DATA = ${response.body}');
        print('RESPONSE HEADERS =${jsonEncode(response.headers)}');
        print('RESPONSE END -------------------------------------------\n\n');
      }

      switch (response.statusCode) {
        // TODO обработать
        case 200:
          return response;
        case 201:
          dynamic responseData = json.decode(response.body);
          return {'data': responseData, 'statusCode': response.statusCode};
        case 401:
        case 403:
        default:
          return {
            'error': 'Неизвестная ошибка',
            'code': response.statusCode,
            'statusCode': response.statusCode
          };
      }
    } catch (err) {
      /// Логируем ошибку
      if (APIConfig.logging) {
        print('REQUEST ERROR !!!!!!!!!!!!!!!!!!!!!!!!!! ');
        print('REQUEST FAILED WITH ERROR — ${err.toString()}');
        print('REQUEST ERROR END !!!!!!!!!!!!!!!!!!!!!!!! \n\n');
      }
      return {'error': err.toString()};
    }
  }

  /// Получаем полный адрес
  _getFullUrl(String path) {
    return '${APIConfig.url}/$path';
  }

  /// Готовим запрос
  Future<dynamic> _sendRequest(String path, APIMethod method,
      {Map<String, dynamic>? data,
      Map<String, String>? headers,
      String? field,
      bool isMultipart = false,
      Stream<Uint8List>? stream,
      int? length}) async {
    Uri uri;
    if (method == APIMethod.get) {
      uri = Uri.parse(_getFullUrl(path));
      uri = uri.replace(queryParameters: data);
    } else {
      uri = Uri.parse(_getFullUrl(path));
    }

    /// Логируем запрос
    if (APIConfig.logging) {
      print('REQUEST START ---------------------------- ');
      print('REQUEST METHOD = ${method.toString().split('.').last}');
      print('REQUEST PATH = $uri');
      print('REQUEST DATA = ${jsonEncode(data)}');
      print('REQUEST HEADERS = ${jsonEncode(headers)}');
      print('REQUEST END ------------------------- \n\n');
    }

    switch (method) {
      case APIMethod.get:
        return await get(uri, headers: headers);
      case APIMethod.post:
        return await post(uri, headers: headers, body: jsonEncode(data));
      case APIMethod.put:
        return await put(uri, headers: headers, body: jsonEncode(data));
      case APIMethod.delete:
        return await delete(uri, headers: headers, body: jsonEncode(data));
      case APIMethod.patch:
        if (isMultipart) {
          var request = MultipartRequest('PATCH', uri)
            ..headers.addAll(headers!)
            ..files.add(MultipartFile(
              field ?? '',
              stream!,
              length!,
              filename: uri.toString(),
            ));
          return await request.send();
        }
        return await patch(uri, headers: headers, body: jsonEncode(data));
    }
  }
}
