import 'dart:math';

import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/material.dart';
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
  late final AuthenticationNotifier authenticationNotifier;
  late final AnimationController animationController;
  final HiveData hiveData = HiveData();
  late UserApp? userApp;
  late bool isFirstTime;

  

  @override
  void initState() {
    //recoverSupabaseSession();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 30));
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      authenticationNotifier =
          Provider.of<AuthenticationNotifier>(context, listen: false);
      authenticationNotifier.recoverSession(context: context);
    });
    animationController.repeat();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    authenticationNotifier.dispose();
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
