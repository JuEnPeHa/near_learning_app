import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:near_learning_app/pages/pages.dart';
import 'package:flutter/services.dart';
import 'package:near_learning_app/providers/authentication_notifier.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static int selectedIndex = 0;

  static final List<Color> _bgColor = [
    Color(0xFF8BDB81),
    Color(0xFF8BDB81),
    Color(0xFF8BDB81),
    Color(0xFF8BDB81),
    Color(0xFF8BDB81),
  ];

  static const List<Icon> _icons = [
    Icon(Icons.home),
    Icon(Icons.text_snippet),
    Icon(Icons.code_outlined),
    Icon(Icons.collections_bookmark_outlined),
    Icon(Icons.person),
  ];

  @override
  Widget build(BuildContext context) {
    final AuthenticationNotifier authenticationNotifier =
        Provider.of<AuthenticationNotifier>(context, listen: false);
    List<Widget> _screens() => [
          HomePage(),
          HomePage(),
          SnippetsPage(),
          ThemesPage(),
          ProfilePage(
            authenticationNotifier: authenticationNotifier,
          )
        ];

    final List<Widget> screens = _screens();
    List<NavigationItem> items = [
      for (int i = 0; i < screens.length; i++)
        NavigationItem(
          icon: _icons[i],
          color: _bgColor[i],
        ),
    ];
    return Scaffold(
      appBar: selectedIndex == 2
          ? AppBar(
              title: Text("Snippets"),
              backgroundColor: Color.fromARGB(255, 145, 111, 9),
              centerTitle: true,
            )
          : null,
      drawer: NavigationDrawerWidget(),
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor:
          selectedIndex != 3 ? Color(0xFF74959A) : Color(0xFFF9F9F2),
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
                    if (Platform.isAndroid) {
                      HapticFeedback.vibrate();
                    }
                    if (Platform.isIOS) {
                      HapticFeedback.lightImpact();
                    }
                    setState(() {
                      selectedIndex = itemIndex;
                    });
                  },
                  child: BuildItem(
                      item: item, isSelected: selectedIndex == itemIndex),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
