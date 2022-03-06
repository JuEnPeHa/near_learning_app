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

  Future<String?> recoverSession({
    required BuildContext context,
  }) async {
    try {
      await _authenticationService.recoverSession(
        context: context,
      );
    } catch (e) {
      print(e);
    }
  }

  Future<List<String>?> getProfile({
    required BuildContext context,
    required String userId,
  }) async {
    try {
      await _authenticationService.getProfile(
        context: context,
        userId: userId,
      );
    } catch (e) {
      print(e.toString() + e.toString() + e.toString());
    }
  }

  Future<void> updateProfile({
    required BuildContext context,
    required String username,
    required String email,
    String? avatarUrl,
    String firstName = "",
    String nearAccount = "",
  }) async {
    try {
      await _authenticationService.updateProfile(
        username: username,
        context: context,
        avatarUrl: avatarUrl,
        firstName: firstName,
        email: email,
      );
    } catch (e) {
      print(e);
    }
  }
}
