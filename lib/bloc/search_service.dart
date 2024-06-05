import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../models/doctor_model.dart';
import '../utils/token.dart';

class SearchService {
  Future<Doctor?> getDoctorsByEmail(String email) async {
    //todo: remove hardcore token initialization
    Token.token =
        "eyJhbGciOiJIUzUxMiJ9.eyJwaG9uZU51bWJlciI6Iis1NSAoNzk5KSA4MDYtNDAzNCIsIm5hbWUiOiJNYXllIiwiaWQiOjEsInN1YiI6Im1yYWdnaXR0MEB3YXNoaW5ndG9ucG9zdC5jb20iLCJpYXQiOjE3MTc1MDMxMDUsImV4cCI6MTcxNzY0NzEwNX0.7JmcuDYkDbvRXHxLKzf25iFjcm-yzG5M7vKTg2aFf8On2pBfiQgnuhVKJ75XEgb3DPETMryNVRKPZGZ0Ir8-9Q";
    Options options = Options(
        headers: {HttpHeaders.authorizationHeader: 'Bearer ${Token.token}'});

    Response<dynamic> responseGetMatchingDoctors = await Dio().get(
      'http://10.0.2.2:8080/users?userEmail=${email.trim()}&role=DOCTOR',
      options: options,
    );

    print(responseGetMatchingDoctors);
    if (responseGetMatchingDoctors.data.length > 0) {
      //todo remove hardcode data[0]
      return Doctor.fromJson(responseGetMatchingDoctors.data[0]);
    } else {
      return null;
    }
  }
}
