// import 'package:flutter/material.dart';
// import 'package:near_learning_app/utils/constants.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class AuthState<T extends StatefulWidget> extends SupabaseAuthState<T> {
//   @override
//   void onUnauthenticated() {
//     if (mounted) {
//       Navigator.of(context).pushNamedAndRemoveUntil('login', (route) => false);
//     }
//   }

//   @override
//   void onAuthenticated(Session session) {
//     if (mounted) {
//       Navigator.of(context)
//           .pushNamedAndRemoveUntil('account', (route) => false);
//     }
//   }

//   @override
//   void onPasswordRecovery(Session session) {}

//   @override
//   void onErrorAuthenticating(String message) {
//     context.showErrorSnackBar(message: message);
//   }
// }
