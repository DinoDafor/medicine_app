import "dart:async";
import "dart:convert";
import 'dart:developer';

import 'package:local_auth/local_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthenticationService {
  static final localAuth = LocalAuthentication();
  final _storage = new FlutterSecureStorage();

  final StreamController<bool> _isEnabledController =
      StreamController<bool>.broadcast();
  final StreamController<bool> _isNewUserController =
      StreamController<bool>.broadcast();

  StreamController<bool> get isEnabledController => _isEnabledController;
  StreamController<bool> get isNewUserController => _isNewUserController;

  Stream<bool> get isEnabledStream => _isEnabledController.stream;
  Stream<bool> get isNewUserStream => _isNewUserController.stream;

  Future<dynamic> read(String key) async {
    final val = await this._storage.read(key: key);
    return val != null ? jsonDecode(val) : '';
  }

  Future<void> clearStorage() async {
    this._storage.delete(key: 'pin');
  }

  Future<void> write(String key, dynamic value) async {
    await this._storage.write(key: key, value: jsonEncode(value));
  }

  Future<bool> verifyCode(String enteredCode) async {
    final pin = await this.read('pin');
    print("Pin is ${pin}");
    print("Pin type ${pin.runtimeType}");
    return pin == enteredCode;

    // if (pin != null && pin == enteredCode) {
    //   this.isNewUserController.add(false);
    //   this.isEnabledController.add(true);
    // } else {
    //   this.isNewUserController.add(true);
    //   this.write('pin', enteredCode);
    //   this.isEnabledController.add(false);
    // }
  }

  Future<void> supportBioAuth(bool isBio) async {
    log("Support bio auth");
    print(isBio);
    this.write('bio', isBio);
  }

  Future<bool> checkSupportBioAuth() async {
    final res = await this.read("bio");
    print(res);
    return res;
  }

  Future<void> codeForNewUser(
      String enteredCode, String email, String password) async {
    this.write('pin', enteredCode);

    log("WRITE PIN");
    Map<String, String> creds = {"email": email, "password": password};
    this.write('creds', creds);
    log("WRITE CREDS");
    final pin = await this.read('pin');
    this.isNewUserController.add(false);
    this.isEnabledController.add(true);
  }

  Future<Map<String, dynamic>?> getCreds() async {
    final creds = await this.read("creds");
    return creds;
  }

  Future<Map<String, dynamic>?> getCredsByCode(String enteredCode) async {
    final pin = await this.read('pin');
    if (pin != null && pin == enteredCode) {
      this.isNewUserController.add(false);
      final creds = await this.read('creds');
      print(creds);
      print("I GET CREDS");
      this.isEnabledController.add(true);
      return creds;
    }
    this.isEnabledController.add(true);
    return null;
  }

  Future<Map<String, dynamic>?> getCredsByBio() async {
    this.isNewUserController.add(false);
    final creds = await this.read('creds');
    print(creds);
    print(creds.runtimeType);

    ///Map<String, dynamic> valueMap = jsonDecode(creds);

    /// print(creds);
    return creds;
  }

  dispose() {
    this._isEnabledController.close();
    this._isNewUserController.close();
  }
}

final AuthenticationService authService = AuthenticationService();
final localAuth = AuthenticationService.localAuth;
