import 'package:flutter/material.dart';
import 'package:near_learning_app/models/supabase_keys.dart';

class AuthenticationNotifier extends ChangeNotifier {
  final AuthenticationService _authenticationService = AuthenticationService();

  Future<String?> signup({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      await _authenticationService.signup(
        context: context,
        email: email,
        password: password,
      );
    } catch (e) {
      print(e);
    }
  }

  Future<String?> login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      await _authenticationService.login(
        context: context,
        email: email,
        password: password,
      );
    } catch (e) {
      print(e);
    }
  }
  Future<void> logout({
    required BuildContext context,
  }) async {
    try {
      await _authenticationService.logout(
        context: context,
      );
    } catch (e) {
      print(e);
    }
  }
}
