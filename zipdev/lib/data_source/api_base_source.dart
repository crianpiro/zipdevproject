import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:zipdev/models/dto/result_model.dart';

class ApiBaseSource {
  final String baseUrl;
  final http.Client client;
  final String token;
  final Duration timeout = Duration(seconds: 5);
  ApiBaseSource(
    this.baseUrl,
    this.client,
    this.token,
  );

  Future<Result<T>> get<T>(String url, T Function(dynamic value) mapperFunction,
      {Map<String, String> headers}) async {
    try {
      headers = await getHeaders(headers);
      headers[HttpHeaders.contentTypeHeader] = 'application/json';
      headers[HttpHeaders.acceptHeader] = 'application/json';
      log(url, name: 'url');  
      log('GET', name: 'method');
      log(headers.toString(), name: 'headers');
      var response = await client.get(url, headers: headers).timeout(timeout);
      var responseManage = await _manageResponse(response, mapperFunction);
      return responseManage;
    } catch (ex) {
      log(ex.toString(), name: 'error');
      return Result<T>.error(message: "Error inesperado. Verifica tu conexión a internet.");
    }
  }
  
  Future<Result<T>> _manageResponse<T>(
      http.Response response, T Function(dynamic value) mapperFunction) async {
    log('MANAGE RESPONSE METHOD');
    log(response.statusCode.toString(), name: 'statusCode');
    log(response.body, name: 'responseBody');
    if (response.statusCode == 200 || response.statusCode == 201) {
      return Result<T>.success(mapperFunction(_getBody((response.body !=null) ? response.bodyBytes : null)));
    } else {
      return _manageError<T>(response);
    }
  }

  Result<T> _manageError<T>(http.Response response) {
    if (response.statusCode >= 500) {
      try {
        return Result<T>.error(message: "Error inesperado. Verifica tu conexión a internet.");
      } catch (ex) {
        log(ex.toString(), name: 'error');
        return Result<T>.error(message: "Error inesperado. Verifica tu conexión a internet.");
      }
    } else if (response.statusCode == 401) {
      return Result<T>.error(message: "Error inesperado. Verifica tu conexión a internet.");
    } else {
      return _errorFromMap(response);
    }
  }

  Result<T> _errorFromMap<T>(http.Response response) {
    try {
      Map<String, dynamic> body = jsonDecode(response.body);
      String description = body['message'];
      description = description ?? "Error inesperado. Verifica tu conexión a internet.";
      int code = body.containsKey('statusCode') ? int.parse(body['statusCode']) : 0;
      return Result<T>.error(message: description, code: code);
    } catch (ex) {
      log(ex.toString(), name: 'error');
      return Result<T>.error(
          message: "Error inesperado. Verifica tu conexión a internet.", code: response.statusCode);
    }
  }

  dynamic _getBody(body) {
    if(body!=null){
      var bodyString = utf8.decode(body);
      try {
        return json.decode(bodyString);
      } catch (ex) {
        log(ex.toString(), name: 'error');
        return bodyString;
      }
    }else{
      return {};
    }
  }

  Future<Map<String, String>> getHeaders(Map<String, String> headers) async {
    headers = headers ?? {};
    return headers;
  }
  
}