import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:near_learning_app/hive_models/hive_data.dart';
import 'package:near_learning_app/models/user_model.dart';
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
    final HiveData hiveData = HiveData();
    final EncryptedSharedPreferences prefs = EncryptedSharedPreferences();
    GotrueResponse response = await SupabaseKeys.supabaseClient.auth.signOut();
    if (response.error == null) {
      await prefs.clear();
      await hiveData.deleteUserApp();
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
      final user = await hiveData.getUserApp();
      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Recover session successful"),
        ));
        Navigator.pushReplacementNamed(context, 'home', arguments: user);
      } else if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Recover session successful"),
        ));
        Navigator.pushReplacementNamed(context, 'account',
            arguments: response.data!.user!);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Recover session failed : ${response.error!.message}"),
      ));
      Navigator.pushReplacementNamed(context, 'auth');
    }
  }

  Future<List<String>> getProfile({
    required String userId,
    required BuildContext context,
  }) async {
    final response = await SupabaseKeys.supabaseClient
        .from('profiles')
        .select()
        .eq('id', userId)
        .single()
        .execute();
    final error = response.error;
    List<String> profile = [];
    if (error != null && response.status != 406) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Get profile failed : ${error.message}"),
      ));
    }
    final data = response.data;
    if (data != null) {
      String username = (data['username'] ?? "") as String;
      String avatarUrl = (data['avatar_url'] ?? "") as String;
      String firstName = (data['first_name'] ?? "") as String;
      String nearAccount = (data['near_account_id'] ?? "") as String;
      print(username + " " + avatarUrl + " " + firstName + " " + nearAccount);
      profile.insert(0, username);
      profile.insert(1, avatarUrl);
      profile.insert(2, firstName);
      profile.insert(3, nearAccount);
      return profile;
    } else if (data == null) {
      await SupabaseKeys.supabaseClient.from('profiles').insert({
        'id': userId,
      }).execute().then((value) => print(value.error));
      return profile;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Get profile failed : ${error?.message}"),
      ));
      return profile;
    }
  }

  Future<void> updateProfile({
    required String userId,
    required BuildContext context,
    required String username,
    required String email,
    String? avatarUrl,
    String firstName = "",
    String nearAccount = "",
  }) async {
    final hiveData = HiveData();
    final updates = avatarUrl != null
        ? {
          'id': userId,
            'username': username,
            'avatar_url': avatarUrl,
            'first_name': firstName,
            'updated_at': DateTime.now().toIso8601String(),
          }
        : {
          'id': userId,
            'username': username,
            'first_name': firstName,
            'updated_at': DateTime.now().toIso8601String(),
          };
    final response = await SupabaseKeys.supabaseClient
        .from('profiles')
        .upsert(updates)
        .execute();
    final error = response.error;
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Update profile failed : ${error.message}"),
      ));
    } else {
      hiveData.setFirstTime();
      final UserApp user = UserApp(
        email: email,
        favoriteThemes: [],
        lastReadPath: '',
        lastReadSyncedPath: '',
        name: firstName,
        nearAccountId: nearAccount,
        preferedLanguage: '',
        userLastSyncedLevel: 0,
        userLevel: 0,
      );
      hiveData.saveUserApp(user: user).then((value) =>
          Navigator.popAndPushNamed(context, 'home', arguments: user));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Update profile successful"),
      ));
    }
  }
}
//final hiveData = HiveData();
    // final user = await hiveData.getUserApp();
    // if (user != null) {
    //   await hiveData.getUserApp();
    // } else {
    //   await hiveData.getUserApp();
    // }
    //} else {
    //   final profile = response.data!.data![0];
    //   final user = await HiveData().getUserApp();
    //   if (user != null) {
    //     user.profile = profile;
    //     await HiveData().setUserApp(user);
    //     Navigator.pushReplacementNamed(context, 'home', arguments: user);
    //   } else {
    //     Navigator.pushReplacementNamed(context, 'account');
    //   }