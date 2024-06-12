import 'dart:convert';

import 'package:dio/dio.dart';

import '../utils/globals.dart';
import '../utils/token.dart';
import '../utils/user.dart';

class ProfileEditService {
  Future<Response> postUpdatedData(Map<String, dynamic> updatedFields) {
    var response = Dio().post(
      'http://${GlobalConfig.host}:${GlobalConfig.port}/users/profile',
      data: json.encode({
        'userId': '${User.id}',
        'email': '${updatedFields['email']}',
        'firstName': '${updatedFields['firstName']}',
        'lastName': '${updatedFields['lastName']}',
        'gender': '${updatedFields['gender']}',
        'birthDate': '${updatedFields['birthDate']}',
        'phoneNumber': '${updatedFields['phoneNumber']}'
      }),
      options: Options(
        headers: {
          'Authorization': 'Bearer ${Token.token}',
        },
      ),
    );
    return response;
  }
}
