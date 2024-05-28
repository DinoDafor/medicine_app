import "dart:async";
import "dart:convert";

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

  Future<void> verifyCode(String enteredCode) async {
    final pin = await this.read('pin');

    if (pin != null && pin == enteredCode) {
      this.isNewUserController.add(false);
    } else {
      this.isNewUserController.add(true);
      this.write('pin', enteredCode);
    }
    this.isEnabledController.add(true);
  }

  Future<void> codeForNewUser(
      String enteredCode, String email, String password) async {
    // this.write('pin', enteredCode);
    // Map<String, String> creds = {"email": email, "password": password};
    // this.write('creds', creds);
    final pin = await this.read('pin');
    this.isNewUserController.add(false);
    this.isEnabledController.add(true);
  }

  Future<Map<String, String>?> getCredsByCode(String enteredCode) async {
    final pin = await this.read('pin');
    if (pin != null && pin == enteredCode) {
      this.isNewUserController.add(false);
      final creds = await this.read('creds');
      return creds;
    }

    return null;
  }

  Future<Map<String, String>?> getCredsByBio() async {
    this.isNewUserController.add(false);
    final creds = await this.read('creds');
    return creds;
  }

  dispose() {
    this._isEnabledController.close();
    this._isNewUserController.close();
  }
}

final AuthenticationService authService = AuthenticationService();
final localAuth = AuthenticationService.localAuth;
