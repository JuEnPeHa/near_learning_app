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

Widget a02() {
  String code1 = '''{
  "name": "starter--near-sdk-as",
  "version": "0.0.1",
  "description": "Start with a basic project",
  "scripts": {
    "dev": "watch -d -n 1 'clear && yarn test'",
    "test": "yarn asp -f unit.spec",
    "clean": "rm -rf ./build && rm -rf ./neardev",
    "build": "asb --target debug",
    "build:release": "asb",
    "asp": "asp --verbose --nologo"
  },
  "keywords": [],
  "author": "hello@near.org",
  "license": "ISC",
  "devDependencies": {
    "near-sdk-as": "^3.1.0"
  }
}''';
  String code2 = '''{
  "workspaces": [
    "src/simple",
    "src/singleton"
  ]
}''';
String code3 = '''// return the string 'hello world'
export function helloWorld(): string {}

// read the given key from account (contract) storage
export function read(key: string): string {}

// write the given value at the given key to account (contract) storage
export function write(key: string, value: string): string {}

// private helper method used by read() and write() above
private storageReport(): string {}''';
String code4 = '''@nearBindgen
export class Contract {

  // return the string 'hello world'
  helloWorld(): string {}

  // read the given key from account (contract) storage
  read(key: string): string {}

  // write the given value at the given key to account (contract) storage
  @mutateState()
  write(key: string, value: string): string {}

  // private helper method used by read() and write() above
  private storageReport(): string {}
}''';
  return Column( children: [
    "Let’s have a closer look at the content of our project.".text.make(),

"Overview".text.bold.make(),
"package.json".text.bold.make(),
gist(text: code1),
"What we see here is a configuration file for our project containing the name of project, version etc. What we are interested in are scripts. Those are aliases for shell commands with specific options. For example, clean is a short name for a command that deletes folders build and neardev, and build:release executes AssemblyScript asb (build) command.".text.make(),

"asconfig.json".text.bold.make(),
gist(text: code2),
"This file is a collection of folders with our contracts in them. When we execute build:release command, we compile contracts from each workspace into the output folder. More about them next.".text.make(),

"src".text.bold.make(),
"Inside src are simple and singleton - our workspaces. They have the same structure, including tests and assembly folders. The difference between them is style they’re written in.".text.make(),

"simple".text.bold.make(),
"We say that an AssemblyScript contract is written in the “simple style” when the index.ts file (the contract entry point) includes a series of exported functions.".text.make(),

"In this case, all exported functions become public contract methods.".text.make(),
gist(text: code3),

"singleton".text.bold.make(),
"We say that an AssemblyScript contract is written in the “singleton style” when the index.ts file (the contract entry point) has a single exported class (the name of the class doesn’t matter) that is decorated with @nearBindgen.".text.make(),
"In this case, all methods on the class become public contract methods unless marked private. Also, all instance variables are stored as a serialized instance of the class under a special storage key named STATE. AssemblyScript uses JSON for storage serialization.".text.make(),
gist(text: code4),

'''Warning: be careful when creating a new workspace

Don’t forget to add it’s location to asconfig.json
Your workspace must have assembly folder and index.ts file!'''.text.red700.make(),
]
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
