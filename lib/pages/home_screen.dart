import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:near_learning_app/pages/pages.dart';

import '../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const List screens = [
    HomePage(),
    HomePage(),
    HomePage(),
    HomePage(),
    ProfilePage()
  ];

  static int selectedIndex = 0;

  static final List<Color> _bgColor = [
    Colors.red.shade600,
    Colors.blue.shade900,
    Colors.deepOrange.shade600,
    Colors.cyan.shade600,
    Colors.deepPurple.shade500,
  ];

  static const List<Icon> _icons = [
    Icon(Icons.home),
    Icon(Icons.settings),
    Icon(Icons.dashboard),
    Icon(Icons.notifications),
    Icon(Icons.person),
  ];

  List<NavigationItem> items = [
    for (int i = 0; i < screens.length; i++)
      NavigationItem(
        icon: _icons[i],
        color: _bgColor[i],
      ),
  ];

  Widget _buildItem(NavigationItem item, bool isSelected) {
    return Container(
      height: 50.0,
      width: 50.0,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: isSelected
            ? []
            : [
                const BoxShadow(
                  color: Colors.white,
                  offset: Offset(-5.0, -5.0),
                  blurRadius: 10.0,
                  spreadRadius: 0.0,
                ),
                BoxShadow(
                  color: Colors.grey.shade500,
                  offset: const Offset(5.0, 5.0),
                  blurRadius: 10.0,
                  spreadRadius: 0.0,
                ),
              ],
        gradient: isSelected
            ? LinearGradient(colors: [
                Colors.grey.shade500,
                Colors.grey.shade400,
                Colors.grey.shade300,
                Colors.grey.shade200,
                Colors.grey.shade100,
              ], begin: Alignment.topLeft, end: Alignment.bottomRight)
            : null,
      ),
      child: IconTheme(
        data: IconThemeData(
          size: 25.0,
          color: isSelected ? item.color : Colors.grey[800],
        ),
        child: item.icon,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: Colors.blueGrey[500],
      body: screens[selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20, left: 25, right: 25),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 75.0,
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          decoration: BoxDecoration(
              boxShadow: [
                const BoxShadow(
                  color: Colors.white54,
                  offset: Offset(-2.5, -2.5),
                  blurRadius: 2.0,
                  spreadRadius: 0.5,
                ),
                BoxShadow(
                  color: Colors.grey.shade500,
                  offset: const Offset(2.5, 2.5),
                  blurRadius: 2.0,
                  spreadRadius: 0.5,
                ),
              ],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
              color: Colors.grey[300]),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: items.map((item) {
                var itemIndex = items.indexOf(item);

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = itemIndex;
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Ejemplo" + itemIndex.toString()),
                        behavior: SnackBarBehavior.fixed,
                        duration: Duration(
                            seconds: 1 * (itemIndex == 0 ? 5 : itemIndex)),
                        elevation: 100,
                      ));
                    });
                  },
                  child: _buildItem(item, selectedIndex == itemIndex),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class NavigationItem {
  final Icon icon;
  final Color? color;

  NavigationItem({required this.icon, required this.color});
}
