import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

class TextLesson extends StatelessWidget {
  final Widget child;
  final String title;
  const TextLesson({required this.child, required this.title, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              toolbarHeight: 70,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.my_library_books),
                  Icon(Icons.bookmark_add),
                ],
              ),
              bottom: PreferredSize(
                child: Container(
                  alignment: Alignment.center,
                  width: double.maxFinite,
                  padding: EdgeInsets.only(top: 5, bottom: 10),
                  child: Center(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25)),
                      color: Colors.white70),
                ),
                preferredSize: Size.fromHeight(20),
              ),
              pinned: true,
              backgroundColor: Colors.grey[500],
              expandedHeight: 150,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  'assets/backgroundGradient/(3).jpg',
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    color: Colors.white54,
                    child: child,
                    //textFormater(
                    //  "El ejemplo Dapplets × NEAR es un Dapplet (una aplicación de aumento) que puede analizar publicaciones de Twitter y almacenarlas."),
                  ),
                  OutlinedButton(onPressed: () {
                    Navigator.pop(context);
                  }, child: Text("Continuar"))
                ],
              ),
            ),
          ],
        ));
  }

  Widget textFormater(String text) {
    String _rawText = text;
    String convertedText = _rawText.replaceAll(RegExp('\\s{2,}'), '\n');

    return ExpandableText(
      convertedText,
      expandText: 'Mostrar más',
      /*style: TextStyle(backgroundColor: Colors.transparent)*/
      collapseText: 'Mostrar menos',
      maxLines: 25,
      animation: true,
      animationDuration: Duration(seconds: 2),
    );
  }
}
