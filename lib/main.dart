import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:near_learning_app/models/supabase_keys.dart';
import 'package:near_learning_app/pages/pages.dart';
import 'package:near_learning_app/router/routes.dart';
import 'package:near_learning_app/theme/app_theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: YOUR_SUPABASE_URL, anonKey: YOUR_SUPABASE_ANON_KEY, );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NEAR Learning App',
      theme: AppTheme.lightTheme /*NeumorphicThemeData()*/,
      // routes: AppRoutes.getAppRoutes(),
      // initialRoute: AppRoutes.initialRoute,
      // onGenerateRoute: AppRoutes.onGenerateRoute,
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => const SplashPage(),
        '/login': (BuildContext context) => const LoginPage2(),
        '/home': (BuildContext context) => const HomePage(),
        '/account': (BuildContext context) => const AccountPage(),
      },
    );
  }
}
