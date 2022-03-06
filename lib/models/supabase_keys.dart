import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:near_learning_app/hive_models/hive_data.dart';
import 'package:supabase/supabase.dart';

class SupabaseKeys {
  static const String YOUR_SUPABASE_URL =
      "https://gienbzcsmyedlkdwtzrp.supabase.co";
  static const String YOUR_SUPABASE_ANON_KEY =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdpZW5iemNzbXllZGxrZHd0enJwIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NDU4MDgyOTksImV4cCI6MTk2MTM4NDI5OX0.ZAk2Y59dtFeI85CPDkisq-af-QwKTlWNKAf7E5-P1pw";
  static SupabaseClient supabaseClient =
      SupabaseClient(YOUR_SUPABASE_URL, YOUR_SUPABASE_ANON_KEY);
}

class AuthenticationService {
  Future<String?> signup({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    final EncryptedSharedPreferences prefs = EncryptedSharedPreferences();
    GotrueSessionResponse response =
        await SupabaseKeys.supabaseClient.auth.signUp(email, password);

    if (response.error == null) {
      await prefs.setString("token", response.data!.persistSessionString);
      String? userEmail = response.data!.user!.email;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Signup successful : $userEmail"),
      ));
      Navigator.pushReplacementNamed(context, 'home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Signup failed : ${response.error!.message}"),
      ));
    }
  }

  Future<String?> login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    final EncryptedSharedPreferences prefs = EncryptedSharedPreferences();
    GotrueSessionResponse response = await SupabaseKeys.supabaseClient.auth
        .signIn(
            email: email,
            password: password,
            options: AuthOptions(redirectTo: SupabaseKeys.YOUR_SUPABASE_URL));
    if (response.error == null) {
      await prefs.setString("token", response.data!.persistSessionString);
      String? userEmail = response.data!.user!.email;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Login successful : $userEmail"),
      ));
      Navigator.pushReplacementNamed(context, 'home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Login failed : ${response.error!.message}"),
      ));
    }
  }

  Future<String?> logout({
    required BuildContext context,
  }) async {
    final EncryptedSharedPreferences prefs = EncryptedSharedPreferences();
    GotrueResponse response = await SupabaseKeys.supabaseClient.auth.signOut();
    if (response.error == null) {
      await prefs.clear();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Logout successful"),
      ));
      Navigator.pushReplacementNamed(context, 'login');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Logout failed : ${response.error!.message}"),
      ));
    }
  }

  Future<String?> recoverSession({
    required BuildContext context,
  }) async {
    final hiveData = HiveData();
    final EncryptedSharedPreferences prefs = EncryptedSharedPreferences();
    final session = await prefs.getString("token");
    GotrueSessionResponse response =
        await SupabaseKeys.supabaseClient.auth.recoverSession(session);
    if (response.error == null) {
      await prefs.setString("token", response.data!.persistSessionString);
      await hiveData.getUserApp();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Recover session successful"),
      ));
      await Future.delayed(Duration(seconds: 5));
      Navigator.pushReplacementNamed(context, 'home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Recover session failed : ${response.error!.message}"),
      ));
      await Future.delayed(Duration(seconds: 5));
      Navigator.pushReplacementNamed(context, 'auth');
    }
  }
}
