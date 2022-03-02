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

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  final liquidPages = [
    Container(
      child: LoginForm(),
    ),
    Container(
      child: RegisterForm(),
    ),
    Container(
      color: Colors.white,
      child: Center(
        child: Text(
          'Welcome to Near',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    ),
  ];

  bool _isShowingSignUp = false;
  late AnimationController _animationController;
  late Animation<double> _animationTextRotate;

  void setUpAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: defaultDuration,
    );
    _animationTextRotate =
        Tween<double>(begin: 0, end: 90).animate(_animationController);
  }

  void updateView() {
    setState(() {
      _isShowingSignUp = !_isShowingSignUp;
    });
    _isShowingSignUp
        ? _animationController.forward()
        : _animationController.reverse();
  }

  @override
  void initState() {
    setUpAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    double _spaceBottom = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
  
      body: LiquidSwipe(
        pages: liquidPages,
        fullTransitionValue: 300,
        enableLoop: true,
        waveType: WaveType.liquidReveal,
        positionSlideIcon: 0.5,
        //enableSideReveal: true,
        onPageChangeCallback: (page) {
          setState(() {
            _isShowingSignUp = page == 1;
            print(page);
          });
        },
        currentUpdateTypeCallback: (page) {
          print(page);
        },
        //liquidController: () => _animationController,
      ),
    );
    // return Scaffold(
    //   resizeToAvoidBottomInset: false,
    //   body: AnimatedBuilder(
    //     animation: _animationController,
    //     builder: (context, _) {
    //       return ConstrainedBox(
    //         constraints: BoxConstraints(
    //           minHeight: _size.height,
    //           minWidth: _size.width,
    //         ),
    //         child: IntrinsicHeight(
    //           child: Stack(
    //             children: [
    //               //Login
    //               AnimatedPositioned(
    //                 duration: defaultDuration,
    //                 width: _size.width / 5 * 4.5,
    //                 height: _size.height,
    //                 left: _isShowingSignUp ? -_size.width / 5 * 4.0 : 0,
    //                 child: Container(
    //                   color: loginBg.withOpacity(0.75),
    //                   child: LoginForm(),
    //                 ),
    //               ),
    //               //Signup
    //               AnimatedPositioned(
    //                 duration: defaultDuration,
    //                 height: _size.height,
    //                 width: _size.width / 5 * 4.5,
    //                 left: _isShowingSignUp
    //                     ? _size.width / (5 * 2)
    //                     : _size.width / 5 * 4.5,
    //                 child: Container(
    //                   color: signupBg.withOpacity(0.75),
    //                   child: RegisterForm(),
    //                 ),
    //               ),
    //               //Logo
    //               AnimatedPositioned(
    //                 duration: defaultDuration * 1.25,
    //                 top: _size.height * 0.1,
    //                 left: 0,
    //                 right: _isShowingSignUp
    //                     ? -_size.width * 0.06
    //                     : _size.width * 0.06,
    //                 child: CircleAvatar(
    //                   radius: 35,
    //                   backgroundColor: Colors.white54,
    //                   child: Image.asset(
    //                     "assets/logos_app/complete_logo_column.png",
    //                     color: _isShowingSignUp
    //                         ? signupBg.withOpacity(0.5)
    //                         : loginBg.withOpacity(0.5),
    //                   ),
    //                 ),
    //               ),

    //               AnimatedPositioned(
    //                 duration: defaultDuration,
    //                 top: _size.height * 0.2,
    //                 left: 0,
    //                 right: _isShowingSignUp
    //                     ? -_size.width * 0.06
    //                     : _size.width * 0.06,
    //                 child: AnimatedDefaultTextStyle(
    //                   textAlign: TextAlign.center,
    //                   duration: defaultDuration,
    //                   style: TextStyle(
    //                     fontSize: 20,
    //                     fontWeight: FontWeight.bold,
    //                     color: Colors.white,
    //                   ),
    //                   child: Text("NEAR Learning App"),
    //                 ),
    //               ),

    //               Positioned(
    //                 bottom: _size.height * 0.15,
    //                 left: _isShowingSignUp
    //                     ? _size.width * 0.225
    //                     : _size.width * 0.175,
    //                 child: SnakeButton(
    //                   child: Text("Iniciar Sesión con NEAR Wallet"),
    //                   onTap: () {
    //                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //                         content: Text(
    //                             "Sorry, this feature is not available yet.")));
    //                   },
    //                   snakeColor: Colors.green.withOpacity(0.75),
    //                   borderColor: Colors.white.withOpacity(0.8),
    //                   borderWidth: 10,
    //                   duration: Duration(milliseconds: 1500),
    //                 ),
    //               ),
    //               //Texto Login
    //               AnimatedPositioned(
    //                 duration: defaultDuration * 0.5,
    //                 bottom: _isShowingSignUp
    //                     ? _size.height / 100 + 100
    //                     : _size.height * -0.175,
    //                 left: _isShowingSignUp
    //                     ? 0
    //                     : _size.width <= limitWidth
    //                         ? ((_size.width / 5 * 4.5) / 4)
    //                         : _size.width * 0.35,
    //                 child: AnimatedDefaultTextStyle(
    //                   duration: defaultDuration,
    //                   textAlign: TextAlign.center,
    //                   style: TextStyle(
    //                     fontSize: _isShowingSignUp ? 22 : 32,
    //                     fontWeight: FontWeight.bold,
    //                     color:
    //                         !_isShowingSignUp ? Colors.white : Colors.white70,
    //                   ),
    //                   child: Transform.rotate(
    //                     angle: -_animationTextRotate.value * pi / 180,
    //                     alignment: Alignment.topLeft,
    //                     child: InkWell(
    //                       onTap: () {
    //                         if (_isShowingSignUp) {
    //                           updateView();
    //                         } else {
    //                           //TODO: Login
    //                         }
    //                       },
    //                       child: Container(
    //                         padding: EdgeInsets.symmetric(
    //                             vertical: defaultPadding * 0.60),
    //                         width: !_isShowingSignUp ? 160 : 640,
    //                         //color: Colors.redAccent.withOpacity(0.2),
    //                         child: true
    //                             ? Text("Log in".toUpperCase())
    //                             : Text("Iniciar Sesión".toUpperCase()),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ),

    //               //Texto Sign Up
    //               AnimatedPositioned(
    //                 duration: defaultDuration * 0.5,
    //                 bottom: !_isShowingSignUp
    //                     ? _size.height / 100 + 100
    //                     : _size.height * -0.175, //       _size.height * -0.175,
    //                 right: !_isShowingSignUp
    //                     ? 0
    //                     : _size.width <= limitWidth
    //                         ? ((_size.width / 5 * 4.5) / 4)
    //                         : _size.width * 0.35,
    //                 child: AnimatedDefaultTextStyle(
    //                   duration: defaultDuration,
    //                   textAlign: TextAlign.center,
    //                   style: TextStyle(
    //                     fontSize: !_isShowingSignUp ? 22 : 32,
    //                     fontWeight: FontWeight.bold,
    //                     color: _isShowingSignUp ? Colors.white : Colors.white70,
    //                   ),
    //                   child: Transform.rotate(
    //                     angle: (90 - _animationTextRotate.value) * pi / 180,
    //                     alignment: Alignment.topRight,
    //                     child: InkWell(
    //                       onTap: () {
    //                         if (!_isShowingSignUp) {
    //                           updateView();
    //                         } else {
    //                           //SignUp
    //                         }
    //                       },
    //                       child: Container(
    //                         padding: const EdgeInsets.symmetric(
    //                             vertical: defaultPadding * 0.60),
    //                         width: _isShowingSignUp ? 160 : 640,
    //                         //color: Colors.redAccent.withOpacity(0.2),
    //                         child: true
    //                             ? Text("Sign Up".toUpperCase())
    //                             : Text(
    //                                 "Registrarse "
    //                                     .toUpperCase(), // + _size.toString(),
    //                               ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       );
    //     },
    //   ),
    // );
  }
}
