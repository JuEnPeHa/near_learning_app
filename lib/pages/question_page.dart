import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:near_learning_app/utils/questions.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class QuestionProviderPage extends StatelessWidget {
  final List<Question> questions;
  const QuestionProviderPage({required this.questions, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NotificiationQuestion(),
      child: QuestionPage(test: questions),
    );
  }
}

class QuestionPage extends StatelessWidget {
  const QuestionPage({required this.test, Key? key}) : super(key: key);
  final List<Question> test;
  @override
  Widget build(BuildContext context) {
    final _NotificiationQuestion _notificiationQuestion =
        Provider.of<_NotificiationQuestion>(context);
    _notificiationQuestion.questionLength = test.length;
    _notificiationQuestion.pageController = PageController();
    _notificiationQuestion.animation = Tween(begin: 0.0, end: 1.0)
        .animate(_notificiationQuestion.animationController);
    return Stack(
      children: [
        SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomProgressBar(),
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text.rich(
                TextSpan(
                  text: "Question ${_notificiationQuestion.currentIndex}",
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      ?.copyWith(color: CupertinoColors.secondaryLabel),
                  children: [
                    TextSpan(
                      text: "/${_notificiationQuestion.questionLength}",
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          ?.copyWith(color: CupertinoColors.secondaryLabel),
                    ),
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 2,
              color: Colors.black,
            ),
            SizedBox(height: 16),
            Expanded(
                child: PageView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    controller: _notificiationQuestion.pageController,
                    onPageChanged: _notificiationQuestion.updateQuestionNumber,
                    itemCount: _notificiationQuestion.questionLength,
                    itemBuilder: (context, index) => QuestionCard(
                          question: test[index],
                        )))
          ],
        ))
      ],
    );
  }
}

class QuestionCard extends StatelessWidget {
  const QuestionCard({required this.question, Key? key}) : super(key: key);
  final Question question;

  @override
  Widget build(BuildContext context) {
    final _NotificiationQuestion _notificiationQuestion =
        Provider.of<_NotificiationQuestion>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            question.question,
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: Colors.black),
          ),
          SizedBox(height: 16 / 2),
          ...List.generate(
            question.options.length,
            (index) => Option(
                question: question,
                index: index,
                text: question.options[index],
                press: () => _notificiationQuestion.checkAnswer(
                      choosenAnswer: index,
                      question: question,
                    )),
          ),
        ],
      ),
    );
  }
}

class Option extends StatelessWidget {
  const Option({
    required this.index,
    required this.text,
    required this.press,
    required this.question,
    Key? key,
  }) : super(key: key);

  final int index;
  final String text;
  final VoidCallback press;
  final Question question;

  @override
  Widget build(BuildContext context) {
    final _NotificiationQuestion _notificiationQuestion =
        Provider.of<_NotificiationQuestion>(context);
    Color getRightColor() {
      if (_notificiationQuestion.isAnswered) {
        if (index == _notificiationQuestion.selectedAns &&
            _notificiationQuestion.selectedAns !=
                _notificiationQuestion.correctAns) {
          return Colors.green;
        } else if (index == _notificiationQuestion.selectedAns &&
            _notificiationQuestion.selectedAns !=
                _notificiationQuestion.correctAns) {
          return Colors.red;
        } else {
          return Vx.gray300;
        }
      }
      return Vx.gray700;
    }

    Icon? getRightIcon() {
      if (getRightColor() == Vx.gray300 || getRightColor() == Vx.gray700) {
        return null;
      } else {
        return Icon(
          getRightColor() == Colors.green ? Icons.check : Icons.close,
          color: Vx.white,
          size: 20,
        );
      }
    }

    return InkWell(
        onTap: press,
        child: Container(
          margin: EdgeInsets.only(top: 16),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: getRightColor() == Vx.gray700
                ? Colors.transparent
                : getRightColor(),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: getRightColor()),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${index + 1} + $text",
                style: TextStyle(color: getRightColor(), fontSize: 16),
              ),
              Container(
                  height: 26,
                  width: 26,
                  decoration: BoxDecoration(
                      color: getRightColor() == Vx.gray700
                          ? Colors.transparent
                          : getRightColor(),
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: getRightColor())),
                  child: getRightIcon()),
            ],
          ),
        ));
  }
}

class CustomProgressBar extends StatefulWidget with SingleTickerProviderStateMixin<StatefulWidget> {
   CustomProgressBar({Key? key}) : super(key: key);

  @override
  State<CustomProgressBar> createState() => _CustomProgressBarState();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  @override
  // TODO: implement context
  BuildContext get context => throw UnimplementedError();

  @override
  void deactivate() {
    // TODO: implement deactivate
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
  }

  @override
  void didUpdateWidget(covariant StatefulWidget oldWidget) {
    // TODO: implement didUpdateWidget
  }

  @override
  void initState() {
    // TODO: implement initState
  }

  @override
  // TODO: implement mounted
  bool get mounted => throw UnimplementedError();

  @override
  void reassemble() {
    // TODO: implement reassemble
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
  }

  @override
  // TODO: implement widget
  StatefulWidget get widget => throw UnimplementedError();
}

class _CustomProgressBarState extends State<CustomProgressBar> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final _notificationQuestion = Provider.of<_NotificiationQuestion>(context);
    return Container(
      width: double.infinity,
      height: 35,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF3F4768), width: 3),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Stack(
        children: [
          LayoutBuilder(builder: (context, constraints) {
            return Container(
              width:
                  constraints.maxWidth * _notificationQuestion.animation.value,
              height: constraints.maxHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                gradient: const LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.green, Colors.lightGreen],
                ),
              ),
            );
          }),
          Positioned.fill(
              child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Text(
                  "${0}% ${(_notificationQuestion.animation.value * 60).round()} sec",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                Icon(CupertinoIcons.clock),
              ],
            ),
          )),
        ],
      ),
    );
  }
} //controller.animation.value * 60

class _NotificiationQuestion extends ChangeNotifier {
  late AnimationController _animationController;
  AnimationController get animationController => _animationController;
  set animationController(AnimationController controller) {
    _animationController = controller;
    notifyListeners();
  }

  late PageController _pageController;
  PageController get pageController => _pageController;
  set pageController(PageController controller) {
    _pageController = controller;
    notifyListeners();
  }

  late Animation _animation;
  Animation get animation => _animation;
  set animation(Animation animation) {
    _animation = animation;
    notifyListeners();
  }

  bool _isAnswered = false;
  bool get isAnswered => _isAnswered;
  int _currentIndex = 1;
  int get currentIndex => _currentIndex;
  int _correctAns = 0;
  int get correctAns => _correctAns;
  int _conteoDeRespuestasCorrectas = 0;
  int get conteoDeRespuestasCorrectas => _conteoDeRespuestasCorrectas;
  int _questionLength = 0;
  int get questionLength => _questionLength;
  int? _selectedAns;
  int? get selectedAns => _selectedAns;
  set conteoDeRespuestasCorrectas(int value) {
    _conteoDeRespuestasCorrectas = value;
    notifyListeners();
  }

  set isAnswered(bool value) {
    _isAnswered = value;
    notifyListeners();
  }

  set currentIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }

  set correctAns(int value) {
    _correctAns = value;
    notifyListeners();
  }

  set questionLength(int value) {
    _questionLength = value;
    notifyListeners();
  }

  set selectedAns(int? ans) {
    _selectedAns = ans;
    notifyListeners();
  }

  void nextQuestion() {
    _currentIndex++;
    if (_currentIndex < questionLength) {
      _isAnswered = false;
      _pageController.nextPage(
          duration: Duration(milliseconds: 500), curve: Curves.easeIn);
      _animationController.reset();
      _animationController.forward().whenComplete(() => nextQuestion());
      notifyListeners();
    } else if (_currentIndex >= questionLength) {
      //TODO: Navigation to Score Page
      notifyListeners();
    }
  }

  void checkAnswer({
    required int choosenAnswer,
    required Question question,
  }) {
    _isAnswered = true;
    _correctAns = question.answer;
    _selectedAns = choosenAnswer;
    if (choosenAnswer == question.answer) {
      _conteoDeRespuestasCorrectas++;
    }
    _animationController.stop();
    notifyListeners();
    print("correctAnsCount: $_conteoDeRespuestasCorrectas");
    Future.delayed(Duration(seconds: 1), () {
      nextQuestion();
    });
  }

  void updateQuestionNumber(int index) {
    _currentIndex = index + 1;
  }
}
