import 'package:flutter/material.dart';
import 'package:near_learning_app/widgets/widgets.dart';

class LoginWidget extends StatelessWidget {
  LoginWidget({
    Key? key,
    required this.context,
  }) : super(key: key);
  final BuildContext context;
  ImageProvider logoColumn =
      const AssetImage('assets/logos_app/complete_logo_column.png');
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF00C897),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 52,
            ),
            CircleAvatar(
              backgroundColor: Colors.white54,
              radius: 100,
              child: Image(image: logoColumn),
            ),
            const LoginForm(),
            const Spacer(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.090,
              width: MediaQuery.of(context).size.width * 0.80,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: SnakeButton(
                  child: const Text("Sign In with NEAR Wallet"),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content:
                          Text("Sorry, this feature is not available yet."),
                    ));
                  },
                  snakeColor: Colors.green.withOpacity(0.75),
                  borderColor: Colors.white.withOpacity(0.8),
                  borderWidth: 10,
                  duration: const Duration(milliseconds: 1500),
                ),
              ),
            ),
            const SizedBox(
              height: 65,
            ),
          ],
        ),
      ),
    );
  }
}
