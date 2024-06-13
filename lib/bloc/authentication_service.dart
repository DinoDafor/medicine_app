import 'dart:io';

import 'package:dio/dio.dart';
import 'package:medicine_app/utils/globals.dart';

import '../utils/token.dart';

class AuthService {
  final Dio _dio = Dio();

  //todo async await statuscode exepstions try catch
  Future<Response> sighUpUser(String email, String password, String userName,
      String phoneNumber) async {
    //todo прокидываем исключение?
    //todo URL

    var response = await _dio.post('http://10.0.2.2:8080/auth/register', data: {
      "email": email.trim(),
      "password": password.trim(),
      "name": userName.trim(),
      "phoneNumber": phoneNumber.trim(),
      //todo confirm password
      "confirmPassword": password.trim(),
    });
    return response;
  }

  Future<Response> sighInUser(String email, String password) async {
    var response = await _dio.post(
        'http://${GlobalConfig.host}:${GlobalConfig.port}/auth/login',
        data: {
          "email": email.trim(),
          "password": password.trim(),
        });
    return response;
  }

  Future<Response> getUser(String email) async {
    print("Token auth ${Token.token}");
    Options options = Options(
        headers: {HttpHeaders.authorizationHeader: 'Bearer ${Token.token}'});

    var response = await _dio.get(
        'http://${GlobalConfig.host}:${GlobalConfig.port}/users',
        options: options,
        queryParameters: {"email": email});
    return response;
  }
}
