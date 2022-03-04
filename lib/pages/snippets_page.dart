import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlighter/flutter_highlighter.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:near_learning_app/utils/constants.dart';
import 'package:flutter/services.dart';

class SnippetsPage extends StatefulWidget {
  SnippetsPage({Key? key}) : super(key: key);

  @override
  State<SnippetsPage> createState() => _SnippetsPageState();
}

class _SnippetsPageState extends State<SnippetsPage> {
  late ScrollController _scrollController;
  final _snipp = [];
  var _codeToShow = '';

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
    _scrollController = ScrollController();
    _fillList();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).viewPadding.top,
          color: Colors.white,
        ),
        Flexible(
            flex: 3,
            child: Container(
              color: Colors.yellow,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  itemCount: _snipp.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      trailing: IconButton(
                          onPressed: () {
                            Clipboard.setData(
                                ClipboardData(text: _snipp[index].code));
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Copied')));
                          },
                          icon: const Icon(Icons.copy_all)),
                      title: Text(
                        _snipp[index].title,
                        style: const TextStyle(fontSize: 17),
                      ),
                      subtitle: Text(
                        _snipp[index].description,
                        style: const TextStyle(fontSize: 14),
                      ),
                      onTap: () {
                        setState(() {
                          _codeToShow = _snipp[index].code;
                        });
                      },
                    );
                  }),
            )),
        Flexible(
          flex: 2,
          child: Container(
            color: Colors.white,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              child: CustomScrollView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                scrollBehavior: const CupertinoScrollBehavior(),
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverList(
                      delegate: SliverChildListDelegate.fixed([
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SyntaxView(
                        code: _codeToShow,
                        syntax: Syntax.JAVASCRIPT,
                        fontSize: 13,
                        syntaxTheme: SyntaxTheme.vscodeDark(),
                        expanded: false,
                        withZoom: false,
                      ),
                    ),
                  ])),
                ],
              ),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 95,
          color: Colors.white,
        )
      ],
    );
  }
}

Widget dinv() {
  String code =
      """
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
          HighlightView(
            code,
            language: 'javascript',
            padding: EdgeInsets.all(20),
            textStyle: TextStyle(
              fontFamily: 'My awesome monospace font',
              fontSize: 16,
            ),
          ),
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
