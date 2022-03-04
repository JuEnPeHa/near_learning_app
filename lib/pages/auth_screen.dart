import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:near_learning_app/utils/constants.dart';

import '../widgets/widgets.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late final LiquidController _liquidController;

  @override
  void initState() {
    // TODO: implement initState
    _liquidController = LiquidController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  var textLogin = "Don't have an account yet?";
  var textRegister = "Already have an account?";
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    final pages = [
      LoginWidget(context: context),
      RegisterWidget(context: context),
    ];

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: LiquidSwipe(
          pages: pages,
          enableLoop: true,
          fullTransitionValue: 400,
          slideIconWidget: SizedBox(
            width: MediaQuery.of(context).size.width * 0.35,
            child: TextButton.icon(
                label: Text(isLogin ? textLogin : textRegister,
                    textAlign: TextAlign.end,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis),
                onPressed: () {
                  if (_liquidController.currentPage == 0) {
                    _liquidController.animateToPage(page: 1, duration: 750);
                    // setState(() {
                    //   isLogin = false;
                    // });
                  } else if (_liquidController.currentPage == 1) {
                    _liquidController.animateToPage(page: 0, duration: 750);
                    // setState(() {
                    //   isLogin = true;
                    // });
                  }
                },
                icon: isLogin
                    ? const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      )
                    : const Icon(Icons.arrow_forward_ios)),
          ),
          waveType: WaveType.liquidReveal,
          positionSlideIcon: 0.8,
          enableSideReveal: true,
          liquidController: _liquidController,
          onPageChangeCallback: (page) {
            print(page);
            if (page == 0) {
              setState(() {
                isLogin = true;
              });
            } else if (page == 1) {
              setState(() {
                isLogin = false;
              });
            }
          },
        ),
      ),
    );
  }
}
