import 'dart:io';

import 'package:flutter/material.dart';
import 'package:near_learning_app/utils/constants.dart';
import 'package:nil/nil.dart';

class OnboardingPage extends StatelessWidget {
  OnboardingPage({Key? key}) : super(key: key);
  int _index = 0;
  bool isIOS = false;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    if (Platform.isIOS) {
      isIOS = true;
    } else {
      isIOS = false;
    }
    return Scaffold(
      body: PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: lottieAnim(index: _index)[1],
          itemBuilder: (context, index) {
            int size = 30;
            return Stack(children: <Widget>[
              BodyBackGroundAnimation(
                index: index,
                size: _size,
                isIOS: isIOS,
              ),
              Container(
                margin: EdgeInsets.only(top: 0, left: 20, right: 20),
                child: Column(
                  children: [
                    SizedBox(
                        height: 150,
                        width: _size.width - 40,
                        child: DecoratedBox(
                            decoration: BoxDecoration(color: Colors.grey[50]))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("Example")],
                    )
                  ],
                ),
              ),
            ]);
          }),
    );
  }
}

class BodyBackGroundAnimation extends StatelessWidget {
  final Size size;
  final int index;
  final bool isIOS;
  const BodyBackGroundAnimation(
      {required this.size, required this.index, required this.isIOS, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height,
      alignment: const FractionalOffset(0.5, 0.5),
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      transform: Matrix4.identity()..scale(1.0, 1.50),
      child: lottieAnim(index: index, animate: isIOS)[0],
    );
  }
}
