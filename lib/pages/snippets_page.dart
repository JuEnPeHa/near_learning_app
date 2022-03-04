import 'package:flutter/material.dart';
import 'package:flutter_highlighter/flutter_highlighter.dart';

class SnippetsPage extends StatelessWidget {
  const SnippetsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: 500,
      color: Colors.red,
      child: Center(
        child: HighlightView(
          '''main() {  print("Hello, World!");}''',
          language: 'javascript',
          padding: EdgeInsets.all(20),
          textStyle: TextStyle(
            fontFamily: 'My awesome monospace font',
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
