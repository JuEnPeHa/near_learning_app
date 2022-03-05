import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

class ThemesGetter {
  ThemesGetter();

  static const String _themesPath = 'themes/';
}

class A01 extends StatelessWidget {
  final Widget child;
  A01({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class A02 extends StatelessWidget {
  const A02({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class A03 extends StatelessWidget {
  const A03({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

final syntax = Syntax.JAVASCRIPT;

Widget a01() {
  String code1 = '''
      "npm Node.JS package manager".text.make(),
      "git version control".text.make(),
      "yarn (npm install -g yarn@1.22.15)".text.make(),
      "near-cli".text.make(),
      ''';
  String code2 = "git clone https://github.com/Learn-NEAR/starter--near-sdk-as";
  String code3 = '''PS C:\Github\starter--near-sdk-as> yarn 
yarn install v1.22.15
[1/4] Resolving packages...
[2/4] Fetching packages...
[3/4] Linking dependencies...
[4/4] Building fresh packages...
Done in 2.16s.''';
  return Column(
    children: [
      "Build and deploy a smart contract to NEAR protocol blockchain"
          .text
          .bold
          .make(),
      "This note will walk you through a starter project that you may use in NCD I and will give you basic knowledge of its structure, internal work and problems you may encounter."
          .text
          .make(),
      "Goals".text.bold.make(),
      "Get familiar with project structure".text.make(),
      "Build the contract".text.make(),
      "Try different ways of deploying it".text.make(),
      "Estimates for Time to Complete".text.bold.make(),
      "Fastest time: 5 minutes (if you already know how to do this)"
          .text
          .make(),
      "Most likely time: 12 minutes".text.make(),
      "Time to quit: 20 minutes (we can help you with some hints in this case)"
          .text
          .make(),
      "Requirements".text.bold.make(),
      "In order to have little to no troubles and awaitings during this course, you should have installed:"
          .text
          .make(),
      gist(text: code1),
      "Also, you have to use your testnet account. If you don’t have one - create."
          .text
          .make(),
      CupertinoButton(
          child: Text("create"),
          onPressed: () {
            _launchURL(
                "https://docs.near.org/docs/develop/basics/create-account#creating-a-testnet-account");
          }),
      "First things first".text.bold.make(),
      "To start with, let’s clone repository we’ll be working with. You can do it through GitHub client or using"
          .text
          .make(),
      gist(text: code2),
      "command. Open project folder in terminal and run yarn. yarn is a package manager that allows to download and solve project’s dependencies - pieces of code that are required for project to work. You will see such output:"
          .text
          .make(),
      gist(text: code3),
    ],
  );
}

Widget gist({required String text}) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: SyntaxView(
      code: text,
      syntax: syntax,
      expanded: false,
      withZoom: false,
      syntaxTheme: SyntaxTheme.vscodeDark(),
    ),
  );
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
