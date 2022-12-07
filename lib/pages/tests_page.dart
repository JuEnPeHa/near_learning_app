import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:near_learning_app/pages/pages.dart';
import 'package:near_learning_app/utils/questions.dart';

class TestsPage extends StatelessWidget {
  const TestsPage({Key? key}) : super(key: key);
  static List<List<Question>> tests = [testUno, testDos, testTres];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.9 - 125,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.125),
                )
              ],
              border:
                  Border.all(color: Colors.white.withOpacity(0.5), width: 1.0),
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.6),
                  Colors.white.withOpacity(0.3)
                ],
                stops: [0.0, 1.0],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(20)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: GridView.count(
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
                                      style: const TextStyle(fontSize: 17)),
                                  Text("${test.length}",
                                      style: const TextStyle(fontSize: 17)),
                                  Text(
                                    test.first.question,
                                    style: const TextStyle(fontSize: 18),
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
                            builder: (context) =>
                                QuestionProviderPage(questions: test),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
