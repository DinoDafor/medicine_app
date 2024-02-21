//Логика взаимодействия по http
import 'package:dio/dio.dart';

class AuthService {
  final Dio _dio = Dio();
  final String _URL = '';

  //todo async await statuscode exepstions try catch
  void sighUpUser(
      String email, String password, String userName, String phoneNumber) async {
    // var response = await _dio.post(_URL, data: {
    //   "email": email.trim(),
    //   "password": password.trim(),
    //   "user_name": userName.trim(),
    //   "phone_number": phoneNumber.trim(),
    // });

  }

  void sighInUser(String email, String password) async {
    // var response = await _dio.post( 'https://5lzxc7kx-8000.euw.devtunnels.ms/auth/login', data: {
    //   "username": email.trim(),
    //   "password": password.trim(),
    // });

  }
}
