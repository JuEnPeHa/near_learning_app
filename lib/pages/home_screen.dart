import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:near_learning_app/hive_models/hive_data.dart';
import 'package:near_learning_app/models/user_model.dart';
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
  late UserApp usar;

  @override
  void initState() {
    usar = hiveDataSingleton.getUserAppSync();
    super.initState();
  }

  int selectedIndex = 0;

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
    //var user = ModalRoute.of(context)!.settings.arguments as UserApp;
    final AuthenticationNotifier authenticationNotifier =
        Provider.of<AuthenticationNotifier>(context, listen: false);
    List<Widget> _screens() => [
          HomePage(user: usar),
          SnippetsPage(),
          const ThemesPage(),
          ProfilePage(
            authenticationNotifier: authenticationNotifier,
            user: usar,
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
      appBar: selectedIndex == 1
          ? AppBar(
              title: Text("Snippets"),
              backgroundColor: Color.fromARGB(255, 145, 111, 9),
              centerTitle: true,
            )
          : null,
      drawer: NavigationDrawerWidget(),
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: selectedIndex != 2
          ? Theme.of(context).primaryColor
          : Color(0xFFF9F9F2),
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
