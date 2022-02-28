import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:near_learning_app/models/each_theme.dart';

Future<List<EachTheme>> getJson() async {
  String response = await rootBundle.loadString('assets/json/themes.json');
  var res = ListThemes.fromJson(json.decode(response));
  return res.themes;
}

class ThemesPage extends StatefulWidget {
  const ThemesPage({Key? key}) : super(key: key);

  @override
  State<ThemesPage> createState() => _ThemesPageState();
}

class _ThemesPageState extends State<ThemesPage> {
  String jsonString = "";
  List<EachTheme> themes = [];


@override
void initState() {
    // TODO: implement initState
    getJson().then((value) => themes = value);
    super.initState();
  }

  var listExplample = [
    {
      "title": "Red",
      "color": Colors.red,
    },
    {
      "title": "Green",
      "color": Colors.green,
    },
    {
      "title": "Blue",
      "color": Colors.blue,
    },
    {
      "title": "Yellow",
      "color": Colors.yellow,
    },
    {
      "title": "Orange",
      "color": Colors.orange,
    },
    {
      "title": "Purple",
      "color": Colors.purple,
    },
    {
      "title": "Black",
      "color": Colors.black,
    },
    {
      "title": "White",
      "color": Colors.white,
    },
    {
      "title": "Grey",
      "color": Colors.grey,
    },
    {
      "title": "Pink",
      "color": Colors.pink,
    },
    {
      "title": "Cyan",
      "color": Colors.cyan,
    },
    {
      "title": "Brown",
      "color": Colors.brown,
    },
    {
      "title": "Indigo",
      "color": Colors.indigo,
    },
    {
      "title": "Light Blue",
      "color": Colors.lightBlue,
    },
    {
      "title": "Light Green",
      "color": Colors.lightGreen,
    },
    {
      "title": "Deep Orange",
      "color": Colors.deepOrange,
    },
    {
      "title": "Deep Purple",
      "color": Colors.deepPurple,
    },
    {
      "title": "Teal",
      "color": Colors.teal,
    },
    {
      "title": "Lime",
      "color": Colors.lime,
    },
    {
      "title": "Indigo",
      "color": Colors.indigo,
    },
    {"title": "Light Blue", "color": Colors.blue}
  ];

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
            expandedHeight: 100,
            backgroundColor: Colors.red,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text('Available seats',
                  style: TextStyle(color: Colors.white)),
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.add_circle),
                tooltip: 'Add new entry',
                onPressed: () {/* ... */},
              ),
            ]),
        SliverList(
            delegate: SliverChildListDelegate([
          PopupMenuButton<WhyFarther>(
            onSelected: (WhyFarther result) {
              setState(() {
                // result.toString();
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<WhyFarther>>[
              const PopupMenuItem<WhyFarther>(
                value: WhyFarther.harder,
                child: Text('Working a lot harder'),
              ),
              const PopupMenuItem<WhyFarther>(
                value: WhyFarther.smarter,
                child: Text('Being a lot smarter'),
              ),
              const PopupMenuItem<WhyFarther>(
                value: WhyFarther.selfStarter,
                child: Text('Being a self-starter'),
              ),
              const PopupMenuItem<WhyFarther>(
                value: WhyFarther.tradingCharter,
                child: Text('Placed in charge of trading charter'),
              ),
            ],
          ),
          ExpansionPanelList(),
          ExpansionTile(title: Text('Expansion tile'), children: [
            Text('This is the body'),
          ]),
          jsonString.isEmpty
              ? Text('Loading...')
              : Text(themes[1].title),
        ]))
      ],
    );
  }
}

enum WhyFarther { harder, smarter, selfStarter, tradingCharter }


