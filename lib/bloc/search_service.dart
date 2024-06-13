import 'dart:io';

import 'package:dio/dio.dart';

import '../models/doctor_model.dart';
import '../utils/globals.dart';
import '../utils/token.dart';

class SearchService {
  Future<Doctor?> getDoctorsByEmail(String email) async {
    Options options = Options(
        headers: {HttpHeaders.authorizationHeader: 'Bearer ${Token.token}'});

    Response<dynamic> responseGetMatchingDoctors = await Dio().get(
      'http://${GlobalConfig.host}/users?userEmail=${email.trim()}&role=DOCTOR',
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

  Future<Response> createNewConversation(
      int firstParticipantId, int secondParticipantId) async {
    Options options = Options(
        headers: {HttpHeaders.authorizationHeader: 'Bearer ${Token.token}'});

    Response<dynamic> response =
        await Dio().post('http://${GlobalConfig.host}/conversations',
            data: {
              "firstParticipantId": firstParticipantId,
              "secondParticipantId": secondParticipantId,
            },
            options: options);
    return response;
  }
}
