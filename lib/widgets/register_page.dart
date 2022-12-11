import 'package:flutter/material.dart';
import 'package:near_learning_app/widgets/widgets.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({
    Key? key,
    // required this.context,
  }) : super(key: key);
  // final BuildContext context;
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Center(
            child: Container(
              // color: const Color(0xFFFFD365),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.yellowAccent.shade700,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.yellowAccent.shade700,
                    blurRadius: 15,
                    spreadRadius: 10,
                    //offset: const Offset(5, 5),
                  ),
                ],
                gradient: LinearGradient(
                  colors: [
                    Colors.yellowAccent.shade700,
                    Colors.yellowAccent.shade400,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              //padding: EdgeInsets.all(_size.width * 0.005),
              margin: EdgeInsets.all(_size.width * 0.025),
              width: _size.width,
              height: _size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: _size.width <= 600
                        ? _size.width * 0.05
                        : _size.width * 0.10,
                  ),
                  CircleAvatarNEARLearningAppLogoWidget(
                    size: _size,
                    // radius: 50,
                  ),
                  Expanded(child: RegisterForm()),
                  // Spacer(),
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height * 0.090,
                  //   width: MediaQuery.of(context).size.width * 0.80,
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  //     child: SnakeButton(
                  //       child: const Text("Sign In with NEAR Wallet"),
                  //       onTap: () {
                  //         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  //           content:
                  //               Text("Sorry, this feature is not available yet."),
                  //         ));
                  //       },
                  //       snakeColor: Colors.green.withOpacity(0.75),
                  //       borderColor: Colors.white.withOpacity(0.8),
                  //       borderWidth: 10,
                  //       duration: const Duration(milliseconds: 1500),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
