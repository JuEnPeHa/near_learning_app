import 'dart:math';

import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:near_learning_app/hive_models/hive_data.dart';
import 'package:near_learning_app/providers/authentication_notifier.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final EncryptedSharedPreferences prefs;
  late final AnimationController animationController;
  late HiveData hiveData;
  late final AuthenticationNotifier authenticationNotifier;

  //late bool isFirstTime;

  Future<void> _nextPage() async {
    await Future.delayed(const Duration(milliseconds: 5500));
    hiveData.isFirstTime.then((value) {
      print(value);
      if (value == true) {
        Navigator.pushReplacementNamed(context, 'onboarding');
      } else {
        Navigator.pushReplacementNamed(context, 'onboarding');
        authenticationNotifier.recoverSession(context: context);
      }
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      authenticationNotifier =
          Provider.of<AuthenticationNotifier>(context, listen: false);
    });
    //recoverSupabaseSession();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 15));
    hiveData = HiveData();
    animationController.repeat();
    _nextPage();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                return Transform.rotate(
                  angle: animationController.value * 10.0 * pi,
                  child: child,
                );
              },
              child: Container(
                height: MediaQuery.of(context).size.height / 3 * 1.75,
                width: MediaQuery.of(context).size.width / 3 * 1.75,
                child: Image.asset("assets/logos_app/phone_without_n.png"),
              ),
            ),
          ),
          Center(
            child: AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                return Transform.rotate(
                  angle: -animationController.value * 10.0 * pi,
                  child: child,
                );
              },
              child: Container(
                height: MediaQuery.of(context).size.height / 3 / 2,
                width: MediaQuery.of(context).size.width / 3 / 2,
                child: Image.asset("assets/logos_app/just_n.png"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
