import 'package:flutter/material.dart';
import 'package:medicine_app/presentation/login_as_screen/login_as_screen.dart';
import 'package:medicine_app/presentation/login_patient_screen/login_patient_screen.dart';
import 'package:medicine_app/presentation/reg_patient_screen/reg_patient_screen.dart';
import 'package:medicine_app/presentation/login_doctor_screen/login_doctor_screen.dart';
import 'package:medicine_app/presentation/reg_doctor_screen/reg_doctor_screen.dart';
import 'package:medicine_app/presentation/app_navigation_screen/app_navigation_screen.dart';
import 'package:medicine_app/presentation/testchat/chat_screen.dart';
import 'package:medicine_app/presentation/main_chat_screen/chat_container_screen.dart';

class AppRoutes {
  static const String loginAsScreen = '/login_as_screen';
  static const String loginPatientScreen = '/login_patient_screen';
  static const String regPatientScreen = '/reg_patient_screen';
  static const String loginDoctorScreen = '/login_doctor_screen';
  static const String regDoctorScreen = '/reg_doctor_screen';
  static const String appNavigationScreen = '/app_navigation_screen';
  static const String chatScreen = '/chat_screen';
  static const String thirtyfivePage = '/thirtyfive_page';
  static const String thirtyfiveTabContainerPage = '/thirtyfive_tab_container_page';
  static const String thirtyfiveContainerScreen = '/thirtyfive_container_screen';

  static Map<String, WidgetBuilder> routes = {
    loginAsScreen: (context) => LoginAsScreen(),
    loginPatientScreen: (context) => LoginPatientScreen(),
    regPatientScreen: (context) => RegPatientScreen(),
    loginDoctorScreen: (context) => LoginDoctorScreen(),
    regDoctorScreen: (context) => RegDoctorScreen(),
    appNavigationScreen: (context) => AppNavigationScreen(),
    ///chatScreen: (context) => ChatScreen(),
    thirtyfiveContainerScreen: (context) => ThirtyfiveContainerScreen(),
  };
}

