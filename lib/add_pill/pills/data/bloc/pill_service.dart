import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:medicine_app/add_pill/pills/data/model/pill_entity.dart';
import 'package:medicine_app/add_pill/pills/data/model/pill_model.dart';

import 'package:medicine_app/utils/token.dart';
import 'package:intl/intl.dart';
import 'package:medicine_app/utils/user.dart';

class PillService {
  final Dio _dio = Dio();

  Future<Response> sendReminder(PillModel pill) async {
    //todo прокидываем исключение?
    //todo URL
    FirebaseMessaging _messaging = FirebaseMessaging.instance;
    print("Send post");
    print(pill.timeToDrink);
    print(DateTime.now().timeZoneName);
    print(DateFormat.Hm().format(pill.timeToDrink));
    print(DateFormat('EEEE').format(pill.timeToDrink).toUpperCase());
    Options options = Options(
        headers: {HttpHeaders.authorizationHeader: 'Bearer ${Token.token}'});
    var response = await _dio
        .post('http://10.0.2.2:8080/reminders', options: options, data: {
      "id": DateTime.now().millisecondsSinceEpoch,
      "userId": User.id,
      "medicineName": pill.name,
      "medicineForm": pill.image.toString(),
      "dosage": pill.countOfPills.toString(),
      "remindTime": DateFormat.Hm().format(pill.timeToDrink),
      "timeZone": 'Europe/Moscow',
      "remindDay": DateFormat('EEEE').format(pill.timeToDrink).toUpperCase(),
      "comment": pill.description,
      "clientToken": await _messaging.getToken(),
      "active": true,
      "soundNotificationEnabled": false
    });

    print("Success post");
    return response;
  }

  Future<Response> getReminder() async {
    var _response =
        await _dio.get("http://10.0.2.2:8080/user/${User.id}/reminders");
    return _response;
  }
}
