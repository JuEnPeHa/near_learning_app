import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:near_learning_app/models/each_theme.dart';
import 'package:near_learning_app/pages/pages.dart';
import 'package:near_learning_app/utils/themes.dart';

Future<List<EachTheme>> getJson() async {
  String response = await rootBundle.loadString('assets/json/themes.json');
  var res = ListThemes.fromJson(json.decode(response));
  return res.themes;
}

class ThemesPage extends StatefulWidget {
  const ThemesPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ThemesPage> createState() => _ThemesPageState();
}

class _ThemesPageState extends State<ThemesPage> {
  final ScrollController _scrollController = ScrollController();
  //bool _isLoading = false;
  bool _isLittle = false;
  List<EachTheme> themes = [];

  @override
  @override
  void initState() {
    getJson().then((value) => setState(() => themes = value));
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= 50) {
        setState(() {
          _isLittle = true;
        });
        // Future.delayed(const Duration(seconds: 2), () {
        //   setState(() {
        //     _isLoading = false;
        //   });
        // });
      } else if (_scrollController.position.pixels <= 50) {
        setState(() {
          _isLittle = false;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
            pinned: true,
            expandedHeight: 100,
            backgroundColor: _isLittle
                ? Colors.transparent
                : Color.fromARGB(255, 145, 111, 9),
            flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                centerTitle: true,
                title: Text('Themes',
                    style: TextStyle(
                        color: _isLittle ? Colors.black : Colors.white))),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.add_circle),
                tooltip: 'Add new entry',
                onPressed: () {/* ... */},
              ),
            ]),
        SliverList(
            delegate: SliverChildListDelegate([
          // PopupMenuButton<WhyFarther>(
          //   child: CircularProgressIndicator(),
          //   onSelected: (WhyFarther result) {
          //     setState(() {
          //       // result.toString();
          //     });
          //   },
          //   itemBuilder: (BuildContext context) => <PopupMenuEntry<WhyFarther>>[
          //     const PopupMenuItem<WhyFarther>(
          //       value: WhyFarther.harder,
          //       child: Text('Working a lot harder'),
          //     ),
          //     const PopupMenuItem<WhyFarther>(
          //       value: WhyFarther.smarter,
          //       child: Text('Being a lot smarter'),
          //     ),
          //     const PopupMenuItem<WhyFarther>(
          //       value: WhyFarther.selfStarter,
          //       child: Text('Being a self-starter'),
          //     ),
          //     const PopupMenuItem<WhyFarther>(
          //       value: WhyFarther.tradingCharter,
          //       child: Text('Placed in charge of trading charter'),
          //     ),
          //   ],
          // ),
          themes.isEmpty
              ? const Text('Loading...')
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ...themes.map(
                        (EachTheme theme) {
                          return ExpansionTile(
                            //collapsedBackgroundColor: theme.color,
                            //backgroundColor: Colors.transparent,
                            //backgroundColor: theme.color,
                            title: Text(theme.title),
                            children: [
                              ...theme.subtitles.map((e) {
                                var id = theme.subtitles.indexOf(e);
                                return ListTile(
                                    onTap: () {
                                      print("object");
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => TextLesson(
                                                    child: _getTheme(theme.keys[id]),
                                                    title: e,
                                                  )));
                                    },
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
                            //collapsedBackgroundColor: theme.color,
                            //backgroundColor: Colors.blue,
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

  Widget _getTheme(final String key) {
    switch (key) {
      case 'a01':
        return a01();
        break;
       case 'a02':
         return a02();
         break;
      // case 'a03':
      //   return a03();
      //   break;
      // case 'b01':
      //   return b01();
      //   break;
      // case 'b02':
      //   return b02();
      //   break;
      // case 'b03':
      //   return b03();
      //   break;
      // case 'c01':
      //   return c01();
      //   break;
      // case 'c02':
      //   return c02();
      //   break;
      // case 'c03':
      //   return c03();
      //   break;
      // case 'd01':
      //   return d01();
      //   break;
      // case 'd02':
      //   return d02();
      //   break;
      // case 'd03':
      //   return d03();
      //   break;
      // case 'e01':
      //   return e01();
      //   break;
      // case 'e02':
      //   return e02();
      //   break;
      // case 'e03':
      //   return e03();
      //   break;
      // case 'f01':
      //   return f01();
      //   break;
      // case 'f02':
      //   return f02();
      //   break;
      // case 'f03':
      //   return f03();
      //   break;
      default:
        return Container();
    }
  }
}

enum WhyFarther { harder, smarter, selfStarter, tradingCharter }
