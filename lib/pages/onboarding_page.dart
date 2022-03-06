import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:near_learning_app/models/models.dart';
import 'package:near_learning_app/providers/authentication_notifier.dart';
import 'package:near_learning_app/utils/constants.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:nil/nil.dart';
import 'package:provider/provider.dart';

Future<List<Onboarding>> getOnboardingData() async {
  String jsonString =
      await rootBundle.loadString('assets/json/onboarding.json');
  List<dynamic> jsonList = json.decode(jsonString);
  List<Onboarding> onboardingList = [];
  for (var i = 0; i < jsonList.length; i++) {
    Onboarding onboarding = Onboarding.fromJson(jsonList[i]);
    onboardingList.add(onboarding);
  }
  return onboardingList;
}

class OnboardingPage extends StatefulWidget {
  OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int _index = 0;
  bool isIOS = false;
  List<Onboarding> onboardingList = [];
  late PageController _pageController;
  late final AuthenticationNotifier authenticationNotifier;

  @override
  void initState() {
    getOnboardingData().then((value) => setState(() => onboardingList = value));
    _pageController = PageController();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      authenticationNotifier =
          Provider.of<AuthenticationNotifier>(context, listen: false);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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
          controller: _pageController,
          scrollDirection: Axis.vertical,
          itemCount: lottieAnim(index: _index)[1],
          itemBuilder: (context, index) {
            Color color = Colors.black;
            double size = 25;
            return Stack(children: <Widget>[
              BodyBackGroundAnimation(
                index: index,
                size: _size,
                isIOS: isIOS,
              ),
              Container(
                margin: const EdgeInsets.only(top: 0, left: 20, right: 20),
                child: Column(
                  children: [
                    SizedBox(
                        height: 150,
                        width: _size.width - 40,
                        child: DecoratedBox(
                            decoration: BoxDecoration(color: Colors.grey[50]))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        onboardingList.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    onboardingList[index].title,
                                    style: TextStyle(
                                        //backgroundColor: Vx.white,
                                        color: color,
                                        fontSize: size * 0.90,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    onboardingList[index].subTitle,
                                    style: TextStyle(
                                        color: color,
                                        fontSize: size * 0.80,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    width: 250,
                                    //color: redNEAR,
                                    child: Text(
                                      onboardingList[index].description,
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                          fontSize: size * 0.60,
                                          color: Color(0xFF878593)),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (index < 2) {
                                        _pageController
                                            .animateToPage(
                                              _pageController.page!.toInt() + 1,
                                              duration: const Duration(
                                                  milliseconds: 750),
                                              curve: Curves.easeInOut,
                                            )
                                            .then((value) => {});
                                      } else {
                                        authenticationNotifier.recoverSession(
                                            context: context);
                                      }
                                    },
                                    child: Container(
                                      //width: 200,
                                      child: Row(
                                        children: [
                                          ResponsiveButton(
                                            isResponsive: true,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : Container(),
                        Column(
                            children: List.generate(
                          3,
                          (indexDots) => Container(
                            margin:
                                const EdgeInsets.only(bottom: 4.0, top: 0.0),
                            width: 8.0,
                            height: index == indexDots ? 25.0 : 8,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: index == indexDots
                                  ? const Color.fromARGB(255, 66, 146, 70)
                                  : const Color.fromARGB(255, 56, 73, 60),
                            ),
                          ),
                        )),
                      ],
                    )
                  ],
                ),
              ),
            ]);
          }),
    );
  }
}

class ResponsiveButton extends StatelessWidget {
  final bool isResponsive;
  final double width;
  const ResponsiveButton(
      {this.isResponsive = false, this.width = 120, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isResponsive == true ? width * 2 : width,
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.blue),
      child: SizedBox(
        width: isResponsive == true ? width * 2 : width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: isResponsive == true ? 20 : 10,
            ),
            isResponsive == true
                ? Expanded(
                    flex: 1,
                    child: SizedBox(
                      width: width,
                      child: const Text(
                        "Next Page",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                : Container(),
            Expanded(
              child: Row(
                children: const [
                  Icon(Icons.arrow_right_alt_outlined,
                      color: Colors.white, size: 35),
                  Icon(Icons.arrow_right_alt_outlined,
                      color: Colors.white, size: 35),
                  Icon(Icons.arrow_right_alt_outlined,
                      color: Colors.white, size: 35)
                ],
              ),
            ),
          ],
        ),
      ),
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
