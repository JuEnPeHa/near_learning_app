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

      ConstsFunctions.showSnackBar(
          message: "Signup successful : $userEmail", context: context);
      Navigator.pushReplacementNamed(context, 'account',
          arguments: response.data!.user);
    } else {
      ConstsFunctions.showSnackBar(
          message: "Signup failed : ${response.error!.message}",
          context: context,
          isError: true);
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
      Navigator.of(context).popUntil((route) => route.isFirst);

      ConstsFunctions.showSnackBar(
          message: "Login successful : $userEmail", context: context);
      Navigator.pushReplacementNamed(context, 'account',
          arguments: response.data!.user);
    } else {
      ConstsFunctions.showSnackBar(
          message: "Login failed : ${response.error!.message}",
          context: context,
          isError: true);
    }
  }

  Future<String?> logout({
    required BuildContext context,
  }) async {
    final EncryptedSharedPreferences prefs = EncryptedSharedPreferences();
    GotrueResponse response = await SupabaseKeys.supabaseClient.auth.signOut();
    if (response.error == null) {
      await prefs.clear();
      hiveDataSingleton.deleteAll();
      Navigator.of(context).popUntil((route) => route.isFirst);
      ConstsFunctions.showSnackBar(
          message: "Logout successful", context: context);

      Navigator.pushReplacementNamed(context, 'login');
    } else {
      ConstsFunctions.showSnackBar(
          message: "Logout failed : ${response.error!.message}",
          context: context,
          isError: true);
    }
  }

  Future<String?> recoverSession({
    required BuildContext context,
  }) async {
    final EncryptedSharedPreferences prefs = EncryptedSharedPreferences();
    final session = await prefs.getString("token");
    GotrueSessionResponse response =
        await SupabaseKeys.supabaseClient.auth.recoverSession(session);
    if (response.error == null) {
      print("Here everything is ok 1 + ${response.data!.user!.email}");
      await prefs.setString("token", response.data!.persistSessionString);
      print("Here everything is ok 2");
      final UserApp? user = hiveDataSingleton.getUserApp();
      print("This is the paramenter $user");
      if (user != null) {
        //await Future.delayed(Duration(milliseconds: 500));

        ConstsFunctions.showSnackBar(
            message: "Recover session successful with user $user",
            context: context);
        Navigator.pushReplacementNamed(context, 'home');
      } else if (user == null) {
        //await Future.delayed(Duration(milliseconds: 500));

        ConstsFunctions.showSnackBar(
            message: "Recover session successful without user",
            context: context);
        Navigator.pushReplacementNamed(context, 'account',
            arguments: response.data!.user!);
      }
    } else {
      await Future.delayed(Duration(milliseconds: 500));

      ConstsFunctions.showSnackBar(
          message: "Recover session failed : ${response.error!.message}",
          context: context,
          isError: true);
      Navigator.pushReplacementNamed(context, 'login');
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
      ConstsFunctions.showSnackBar(
          message: "Get profile failed : ${error.message}",
          context: context,
          isError: true);
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
      await SupabaseKeys.supabaseClient
          .from('profiles')
          .insert({
            'id': userId,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .execute()
          .then((value) => print(value.error));
      return profile;
    } else {
      ConstsFunctions.showSnackBar(
          message: "Get profile failed : ${error?.message}",
          context: context,
          isError: true);
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
      ConstsFunctions.showSnackBar(
          message: "Update profile failed : ${error.message}",
          context: context,
          isError: true);
    } else {
      await hiveDataSingleton.setFirstTime();
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

      ConstsFunctions.showSnackBar(
          message: "Update profile successful", context: context);
      await hiveDataSingleton
          .saveUserApp(user: user)
          .then((value) => Navigator.popAndPushNamed(context, 'home'));
    }
  }

  Future<void> shouldOnboardingBeShown({
    required BuildContext context,
  }) async {
    hiveDataSingleton.isFirstTime.then((value) async {
      if (value) {
        await Future.delayed(const Duration(milliseconds: 500));
        Navigator.pushReplacementNamed(context, 'onboarding');
      } else {
        Future.delayed(const Duration(milliseconds: 500))
            .then((_) => recoverSession(context: context));
      }
    });
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

//     abstract class HiveDataSingleton {
//   Future<void> saveUserApp({required UserApp user});
//   Future<UserApp?> getUserApp();
//   Future<void> setFirstTime();
//   Future<bool> get isFirstTime;
// }

class ConstsFunctions {
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
      {required String message,
      required BuildContext context,
      bool isError = false}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: isError ? Colors.red : Colors.green,
      // action: SnackBarAction(
      //   label: 'OK',
      //   onPressed: () {
      //     ScaffoldMessenger.maybeOf(context)?.hideCurrentSnackBar();
      //   },
      // ),
      dismissDirection: DismissDirection.horizontal,
      duration: const Duration(seconds: 2),
      elevation: 15.0,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ));
  }
}
