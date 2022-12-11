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
      initialRoute: Navigation.root.name, //'root',
      routes: AppRoutes.getAppRoutes(),
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}

// Create Enum for Navigation
enum Navigation {
  root,
  home,
  account,
  themes,
  auth,
  onboarding,
  text,
  test,
  login,
  register,
}

// Function from Enum to String
extension NavigationExtension on Navigation {
  String get name {
    switch (this) {
      case Navigation.root:
        return 'root';
      case Navigation.home:
        return 'home';
      case Navigation.account:
        return 'account';
      case Navigation.themes:
        return 'themes';
      case Navigation.auth:
        return 'auth';
      case Navigation.onboarding:
        return 'onboarding';
      case Navigation.text:
        return 'text';
      case Navigation.test:
        return 'test';
      case Navigation.login:
        return 'login';
      case Navigation.register:
        return 'register';
    }
  }
}

// Create Class for Routes

class AppRoutes {
  static const String initialRoute = 'root';
  static const String home = 'home';
  static const String account = 'account';
  // static const String themes = 'themes';
  static const String auth = 'auth';
  static const String onboarding = 'onboarding';
  static const String text = 'text';
  static const String test = 'test';
  static const String login = 'login';
  static const String register = 'register';

  static Map<String, WidgetBuilder> getAppRoutes() {
    Navigation.values.forEach((element) {
      print(element.name);
    });
    return <String, WidgetBuilder>{
      initialRoute: (BuildContext context) => const SplashPage(),
      //'login': (BuildContext context) => const LoginPage2(),
      home: (BuildContext context) => const HomeScreen(),
      account: (BuildContext context) => AccountPage(),
      //'themes': (BuildContext context) => const ThemesPage(),
      auth: (BuildContext context) => const AuthScreen(),
      onboarding: (BuildContext context) => const OnboardingPage(),
      text: (BuildContext context) => TextLesson(
            child: a01(),
            title: "Example",
          ),
      test: (BuildContext context) => const TestsPage(),
      login: (BuildContext context) => LoginPage(),
      register: (BuildContext context) => RegisterPage(),
    };
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initialRoute:
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const SplashPage(),
        );
      case home:
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const HomeScreen(),
        );
      case account:
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => AccountPage(),
        );
      // case themes:
      //   return MaterialPageRoute<dynamic>(
      //     builder: (BuildContext context) => const ThemesPage(),
      //   );
      case auth:
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const AuthScreen(),
        );
      case onboarding:
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const OnboardingPage(),
        );
      case text:
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => TextLesson(
            child: a01(),
            title: "Example",
          ),
        );
      case test:
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const TestsPage(),
        );
      case login:
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => LoginPage(),
        );
      case register:
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => RegisterPage(),
        );
      default:
        return MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const SplashPage(),
        );
    }
  }
}
