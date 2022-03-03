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
  final pages = [
    Container(
      color: Color(0xFF7F7689),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Image.asset(
              "assets/images/mercury.png",
              width: 400.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Planet",
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Color(0xFFA1B6CC),
                  ),
                ),
                Text(
                  "Mercury",
                  style: TextStyle(
                      fontSize: 50.0,
                      color: Color(0xFF3A342D),
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.0),
                Divider(color: Colors.black38),
                Text(
                  "The smallest and fastest planet,\nMercury is the "
                  "closest planet to the Sun \nand whips around it "
                  "every \n88 Earth days",
                  style: TextStyle(
                      color: Color(0xFFA1B6CC),
                      fontWeight: FontWeight.w300,
                      fontSize: 16.0),
                )
              ],
            ),
          )
        ],
      ),
    ),
    Container(
      color: Color(0xFF34210B),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Image.asset(
              "assets/images/venus.png",
              width: 220.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Planet",
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Color(0xFFA1B6CC),
                  ),
                ),
                Text(
                  "Venus",
                  style: TextStyle(
                      fontSize: 50.0,
                      color: Color(0xFFE8BB57),
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.0),
                Divider(color: Color(0xFFE8BB57)),
                Text(
                  "Spinning in the opposite direction \n"
                  "to most planets, Venus is the  \n"
                  "hottest planet, and one of the"
                  "and one of the \n"
                  "brightest objects in the sky",
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w300,
                      fontSize: 16.0),
                )
              ],
            ),
          )
        ],
      ),
    ),
    Container(
      color: Color(0xFF21323D),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Image.asset("assets/images/earth.png", width: 250.0),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Planet",
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Color(0xFFA1B6CC),
                  ),
                ),
                Text(
                  "Earth",
                  style: TextStyle(
                      fontSize: 50.0,
                      color: Color(0xFF888C76),
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.0),
                Divider(color: Colors.blueGrey),
                Text(
                  "The place we call home, \nEarth is the third rock\n"
                  "from the sun and the only planet\n"
                  "with known life on it",
                  style: TextStyle(
                      color: Color(0xFFD4D4D2),
                      fontWeight: FontWeight.w300,
                      fontSize: 16.0),
                )
              ],
            ),
          )
        ],
      ),
    ),
    Container(
      color: Color(0xFF2F1B0A),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Image.asset(
              "assets/images/mars.png",
              width: 220.0,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Planet",
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Color(0xFFA1B6CC),
                  ),
                ),
                Text(
                  "Mars",
                  style: TextStyle(
                      fontSize: 50.0,
                      color: Color(0xFFCC8E57),
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.0),
                Divider(color: Color(0xFFCC8E57)),
                Text(
                  "The red planet is dusty,\n"
                  "cold world with a thin\n"
                  "atmosphere and is home to four NASA robots",
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w300,
                      fontSize: 16.0),
                )
              ],
            ),
          )
        ],
      ),
    ),
    Container(
      color: Color(0xFF5A504B),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Image.asset(
              "assets/images/jupiter.png",
              width: 220,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Planet",
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Color(0xFFC1C1C2),
                  ),
                ),
                Text(
                  "Jupiter",
                  style: TextStyle(
                      fontSize: 50.0,
                      color: Color(0xFFCC8E57),
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.0),
                Divider(color: Colors.blueGrey),
                Text(
                  "Jupiter is a massive planet, twice the size of\n"
                  "all other planets combined and has a\n"
                  "centuries-old storm that is bigger than Earth",
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w300,
                      fontSize: 16.0),
                )
              ],
            ),
          )
        ],
      ),
    ),
    Container(
      color: Color(0xFF717574),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Image.asset(
              "assets/images/saturn.png",
              width: 320,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Planet",
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Color(0xFFA1B6CC),
                  ),
                ),
                Text(
                  "Saturn",
                  style: TextStyle(
                      fontSize: 50.0,
                      color: Color(0xFFBCB2A3),
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.0),
                Divider(color: Colors.black38),
                Text(
                  "The most recognizable\n"
                  "planet with a system of icy rings, \n"
                  "Saturn is a very unique \nand interesting ",
                  style: TextStyle(
                      color: Color(0xFFA1B6CC),
                      fontWeight: FontWeight.w300,
                      fontSize: 16.0),
                )
              ],
            ),
          )
        ],
      ),
    ),
    Container(
      color: Color(0xFF5C787C),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Image.asset(
              "assets/images/uranus.png",
              width: 240,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Planet",
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Color(0xFFA1B6CC),
                  ),
                ),
                Text(
                  "Uranus",
                  style: TextStyle(
                      fontSize: 50.0,
                      color: Color(0xFFD2F3F4),
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.0),
                Divider(color: Color(0xFFD2F3F4)),
                Text(
                  "Uranus has a very unique rotation–it\n spins on its"
                  "side at an almost \n90-degree angle, unlike\n"
                  "other planets.",
                  style: TextStyle(
                      color: Color(0xFFA1B6CC),
                      fontWeight: FontWeight.w300,
                      fontSize: 16.0),
                )
              ],
            ),
          )
        ],
      ),
    ),
    Container(
      color: Color(0xFF1A224D),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Image.asset(
              "assets/images/neptune.png",
              width: 210,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Planet",
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Color(0xFFA1B6CC),
                  ),
                ),
                Text(
                  "Neptune",
                  style: TextStyle(
                      fontSize: 50.0,
                      color: Color(0xFF5183F7),
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.0),
                Divider(color: Color(0xFF5183F7)),
                Text(
                  "Neptune is now the most\n "
                  "distant planet and is a cold and\n dark world "
                  "nearly 3 billion miles\n "
                  "from the Sun.",
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w300,
                      fontSize: 16.0),
                )
              ],
            ),
          )
        ],
      ),
    ),
    Container(
      color: Color(0xFF8A7F7C),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Image.asset(
              "assets/images/pluto.png",
              width: 220,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Planet",
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Color(0xFFA1B6CC),
                  ),
                ),
                Text(
                  "Pluto",
                  style: TextStyle(
                      fontSize: 50.0,
                      color: Color(0xFFBCB2A3),
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.0),
                Divider(color: Colors.black38),
                Text(
                  "Pluto will consistently be the ninth  \nplanet to us!"
                  "Smaller than Earth’s moon, \nPluto was a planet"
                  "up until 2006 and has \nfive of its own moons!",
                  style: TextStyle(
                      color: Color(0xFFBCB2A3),
                      fontWeight: FontWeight.w300,
                      fontSize: 16.0),
                )
              ],
            ),
          )
        ],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var text = "Register";
    return Scaffold(
      body: LiquidSwipe(
        pages: pages,
        enableLoop: true,
        fullTransitionValue: 600,
        slideIconWidget: TextButton.icon(label: Text(text),onPressed: (){
        }, icon: Icon(Icons.arrow_back_ios, color: Colors.white,)),
        waveType: WaveType.liquidReveal,
        positionSlideIcon: 0.5,
        enableSideReveal: true,
        liquidController: LiquidController(),
      ),
    );
  }
}