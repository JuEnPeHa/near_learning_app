import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:near_learning_app/models/supabase_keys.dart';
import 'package:near_learning_app/utils/constants.dart';
import 'package:flutter/services.dart';

class SnippetsPage extends StatefulWidget {
  const SnippetsPage({Key? key}) : super(key: key);

  @override
  State<SnippetsPage> createState() => _SnippetsPageState();
}

class _SnippetsPageState extends State<SnippetsPage> {
  late ScrollController _scrollControllerHorizontal;
  late ScrollController _scrollControllerVertical;
  final _snipp = [];
  // var _codeToShow = '';

  void _fillList() {
    for (var element in snippetsConstEs) {
      _snipp.add(Snippet(
          title: element["title"] as String,
          description: element["description"] as String,
          code: element["code"] as String));
    }
  }

  @override
  void initState() {
    _scrollControllerHorizontal = ScrollController();
    _scrollControllerVertical = ScrollController();
    _fillList();
    super.initState();
  }

  @override
  void dispose() {
    _scrollControllerHorizontal.dispose();
    _scrollControllerVertical.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).viewPadding.top,
            color: Colors.transparent,
          ),
          Flexible(
            flex: 1,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  itemCount: _snipp.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        decoration: BoxDecoration(
                          // color: Theme.of(context)
                          //     .primaryColor
                          //     .withBlue(250)
                          //     .withAlpha(100)
                          //     .withOpacity(0.25),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 1.0,
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Theme.of(context)
                                  .primaryColor
                                  .withBlue(250)
                                  .withAlpha(100)
                                  .withOpacity(0.25),
                              //The next is something between the previous and the next (the next next is Theme.of(context).primaryColor.withOpacity(0.25))
                              Theme.of(context)
                                  .primaryColor
                                  .withBlue(200)
                                  .withAlpha(75)
                                  .withOpacity(0.33),
                              Theme.of(context).primaryColor.withOpacity(0.25),
                            ],
                          ),
                        ),
                        child: ListTile(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(_snipp[index].title),
                                    content: SyntaxView(
                                      code: _snipp[index].code,
                                      syntax: Syntax.DART,
                                      syntaxTheme: SyntaxTheme.dracula(),
                                      withZoom: true,
                                      withLinesCount: true,
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Close'),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          // setState(() {
                                          //   _codeToShow = _snipp[index].code;
                                          // });
                                          Clipboard.setData(ClipboardData(
                                              text: _snipp[index].code));
                                          ConstsFunctions.showSnackBar(
                                            message: 'Code copied to clipboard',
                                            context: context,
                                          );
                                        },
                                        icon: const Icon(Icons.copy_all),
                                      ),
                                    ],
                                  );
                                });
                          },
                          // expandedTextColor: Colors.black,
                          // colorCurve: Curves.bounceIn,
                          // elevationCurve: Curves.easeInCubic,
                          // onExpansionChanged: (_) {
                          //   print(_snipp[index].code.length);
                          // },
                          title: Text(
                            _snipp[index].title,
                            style: const TextStyle(fontSize: 17),
                          ),
                          // baseColor: Colors.white54,
                          // expandedColor: Colors.white70,
                          subtitle: Text(
                            _snipp[index].description,
                            style: const TextStyle(fontSize: 14),
                          ),
                          // trailing: IconButton(
                          //   onPressed: () {
                          //     // setState(() {
                          //     //   _codeToShow = _snipp[index].code;
                          //     // });
                          //     Clipboard.setData(
                          //         ClipboardData(text: _snipp[index].code));
                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //         const SnackBar(content: Text('Copied')));
                          //   },
                          //   icon: const Icon(Icons.copy_all),
                          // ),
                          // children: <Widget>[
                          //   const Divider(
                          //     thickness: 1.0,
                          //     height: 1.0,
                          //   ),
                          // ],
                        ),
                      ),
                    );
                  }),
            ),
          ),
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   height: 95,
          //   color: Colors.transparent,
          // )
        ],
      ),
    );
  }
}

Widget dinv() {
  String code = """
// Importing core libraries
import 'dart:math';
int fibonacci(int n) {
  if (n == 0 || n == 1) return n;
  return fibonacci(n - 1) + fibonacci(n - 2);
}          
var result = fibonacci(20);
/* and there 
    you have it! */
""";
  return Container(
    height: 500,
    width: 500,
    color: Colors.red,
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SyntaxView(
            code: code, // Code text
            syntax: Syntax.JAVASCRIPT, // Language
            syntaxTheme: SyntaxTheme.vscodeDark(), // Theme
            fontSize: 13.0, // Font size
            withZoom: true, // Enable/Disable zoom icon controls
            withLinesCount: true, // Enable/Disable line number
            expanded: false, // Enable/Disable container expansion
          )
        ],
      ),
    ),
  );
}

// SizedBox(
//                           height: 250,
//                           child: Column(
//                             children: [
//                               Expanded(
//                                 child: SingleChildScrollView(
//                                   controller: _scrollControllerHorizontal,
//                                   scrollDirection: Axis.horizontal,
//                                   physics: const BouncingScrollPhysics(),
//                                   child: SyntaxView(
//                                     code: _snipp[index].code,
//                                     syntax: Syntax.JAVASCRIPT,
//                                     fontSize: 13,
//                                     syntaxTheme: SyntaxTheme.vscodeDark(),
//                                     expanded: false,
//                                     withZoom: false,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),