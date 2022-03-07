import 'package:flutter/material.dart';
import 'package:near_learning_app/pages/pages.dart';
import 'package:near_learning_app/utils/questions.dart';

class TestsPage extends StatelessWidget {
  TestsPage({Key? key}) : super(key: key);
  List<List<Question>> tests = [];

  @override
  Widget build(BuildContext context) {
    tests.add(testUno);
    tests.add(testDos);
    tests.add(testTres);

    return Scaffold(
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          ...tests.map(
            (test) {
              int testIndex = tests.indexOf(test);
              return GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      color: Colors.accents[testIndex][100],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("${testIndex + 1}",
                              style: const TextStyle(fontSize: 20)),
                          Text("${test.length}",
                              style: const TextStyle(fontSize: 20)),
                          Text(
                            test.first.question,
                            style: const TextStyle(fontSize: 20),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuestionProviderPage(questions: test),
                  ),
                ),
              );
            },
          ),
          Container(
            color: Colors.red,
          ),
          Container(
            color: Colors.green,
          ),
          Container(
            color: Colors.blue,
          ),
          Container(
            color: Colors.yellow,
          ),
          Container(
            color: Colors.orange,
          ),
          Container(
            color: Colors.purple,
          ),
          Container(
            color: Colors.pink,
          ),
          Container(
            color: Colors.brown,
          ),
          Container(
            color: Colors.grey,
          ),
          Container(
            color: Colors.cyan,
          ),
          Container(
            color: Colors.indigo,
          ),
          Container(
            color: Colors.lime,
          ),
          Container(
            color: Colors.teal,
          ),
          Container(
            color: Colors.amber,
          ),
          Container(
            color: Colors.deepOrange,
          ),
          Container(
            color: Colors.deepPurple,
          ),
          Container(
            color: Colors.indigo,
          ),
          Container(
            color: Colors.lightBlue,
          ),
          Container(
            color: Colors.lightGreen,
          ),
          Container(
            color: Colors.lime,
          ),
          Container(
            color: Colors.orange,
          ),
          Container(
            color: Colors.pink,
          ),
          Container(
            color: Colors.purple,
          ),
          Container(
            color: Colors.red,
          ),
          Container(
            color: Colors.teal,
          ),
          Container(
            color: Colors.yellow,
          ),
          Container(
            color: Colors.blue,
          ),
          Container(
            color: Colors.green,
          ),
          Container(
            color: Colors.brown,
          ),
          Container(
            color: Colors.cyan,
          ),
          Container(
            color: Colors.indigo,
          ),
          Container(
            color: Colors.lime,
          ),
        ],
      ),
    );
  }
}
