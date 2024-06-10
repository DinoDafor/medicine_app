import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:medicine_app/add_pill/pills/data/model/pill_entity.dart';
import 'package:medicine_app/add_pill/pills/data/model/pill_model.dart';
import 'package:medicine_app/utils/firebase_options.dart';
import 'package:medicine_app/utils/token.dart';
import 'package:intl/intl.dart';
import 'package:medicine_app/utils/user.dart';

class PillService {
  final Dio _dio = Dio();

  Future<Response> sendReminder(PillModel pill) async {
    //todo прокидываем исключение?
    //todo URL
    print("Send post");
    print(pill.timeToDrink);
    print(DateTime.now().timeZoneName);
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
      "timeZone": DateTime.now().timeZoneName,
      "remindDay": DateFormat('EEEE').format(pill.timeToDrink).toUpperCase(),
      "comment": pill.description,
      "clientToken":
          "cwby_VOp_T8:APA91bFKVw5fPbV6cE70Qg5oqkXAZLrt1-hp3bEuckmmIwf-XDb5f6YKQb1mDiYibLCEixux_ZO0_XE5AoRd7tvUvxi97Kf_KmFqtixZqRSvzVbAMf5fnkEaSP2by_wy3DCOPLWb6fQr",
      "active": true,
      "soundNotificationEnabled": false
    });

    print("Success post");
    return response;
  }
}
