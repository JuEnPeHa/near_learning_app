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
  final GlobalKey<ScaffoldState> scaffoldKey;
  const ThemesPage({Key? key, required this.scaffoldKey}) : super(key: key);

  @override
  State<ThemesPage> createState() => _ThemesPageState();
}

class _ThemesPageState extends State<ThemesPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isLittle = false;
  List<EachTheme> themes = [];

  @override
  void initState() {
    // TODO: implement initState
    getJson().then((value) => setState(() {
          themes = value;
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
            expandedHeight: 100,
            backgroundColor: _isLittle ? Colors.transparent : Colors.red,
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
          themes.isEmpty
              ? Text('Loading...')
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ...themes.map(
                        (EachTheme theme) {
                          return ExpansionTile(
                            collapsedBackgroundColor: theme.color,
                            backgroundColor: Colors.blue,
                            //backgroundColor: theme.color,
                            title: Text(theme.title),
                            children: [
                              ...theme.subtitles.map((e) {
                                return ListTile(
                                    //tileColor: theme.color,
                                    title: Text(e));
                              })
                            ],
                          );
                        },
                      ),
                      ...themes.map(
                        (EachTheme theme) {
                          return ExpansionTile(
                            collapsedBackgroundColor: theme.color,
                            backgroundColor: Colors.blue,
                            //backgroundColor: theme.color,
                            title: Text(theme.title),
                            children: [
                              ...theme.subtitles.map((e) {
                                return ListTile(
                                    //tileColor: theme.color,
                                    title: Text(e));
                              })
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
        ]))
      ],
    );
  }
}

enum WhyFarther { harder, smarter, selfStarter, tradingCharter }
