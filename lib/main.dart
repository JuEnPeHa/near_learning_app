import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:near_learning_app/hive_models/hive_data.dart';
import 'package:near_learning_app/models/supabase_keys.dart';
import 'package:near_learning_app/models/user_model.dart';
import 'package:near_learning_app/pages/home_screen.dart';
import 'package:near_learning_app/pages/pages.dart';
import 'package:near_learning_app/providers/authentication_notifier.dart';
import 'package:near_learning_app/providers/navigation_provider.dart';
import 'package:near_learning_app/providers/provider.dart';
import 'package:near_learning_app/router/routes.dart';
import 'package:near_learning_app/theme/app_theme.dart';
import 'package:near_learning_app/utils/themes.dart';
import 'package:near_learning_app/widgets/login_page.dart';
import 'package:near_learning_app/widgets/register_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAppAdapter());
  await Hive.openBox<UserApp>('user');
  // await Supabase.initialize(
  //   url: YOUR_SUPABASE_URL,
  //   anonKey: YOUR_SUPABASE_ANON_KEY,
  // );
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationNotifier()),
        ChangeNotifierProvider(create: (context) => NavigationProvider()),
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
          lazy: false,
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const String _title = 'Near Learning App';

  @override
  Widget build(BuildContext context) {
    precacheImage(
        const AssetImage("assets/logos_app/complete_logo_column.png"), context);
    precacheImage(
        const AssetImage("assets/logos_app/complete_logo_row.png"), context);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      theme: AppTheme.lightTheme.copyWith(
        primaryColor: Color(0xFF74959A),
      ) /*NeumorphicThemeData()*/,
      // routes: AppRoutes.getAppRoutes(),
      // initialRoute: AppRoutes.initialRoute,
      // onGenerateRoute: AppRoutes.onGenerateRoute,
      initialRoute: 'root', //'root',
      routes: <String, WidgetBuilder>{
        'root': (BuildContext context) => const SplashPage(),
        //'login': (BuildContext context) => const LoginPage2(),
        'home': (BuildContext context) => const HomeScreen(),
        'account': (BuildContext context) => AccountPage(),
        //'themes': (BuildContext context) => const ThemesPage(),
        'auth': (BuildContext context) => const AuthScreen(),
        'onboarding': (BuildContext context) => OnboardingPage(),
        'text': (BuildContext context) => TextLesson(
              child: a01(),
              title: "Example",
            ),
        'test': (BuildContext context) => const TestsPage(),
        'login': (BuildContext context) => LoginPage(),
        'register': (BuildContext context) => RegisterPage(),
      },
    );
  }
}
