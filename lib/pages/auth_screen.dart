import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:near_learning_app/utils/constants.dart';

import '../widgets/widgets.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // late final LiquidController _liquidController;

  @override
  void initState() {
    // TODO: implement initState
    // _liquidController = LiquidController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  final String textLogin = "Don't have an account yet?";
  final String textRegister = "Already have an account?";
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    final pages = [
      LoginPage(),
      RegisterPage(),
    ];

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SizedBox(),
        ),
      ),
    );
  }
}
