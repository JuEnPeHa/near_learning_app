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
  return Column(children: [
    "Let’s have a closer look at the content of our project.".text.make(),
    "Overview".text.bold.make(),
    "package.json".text.bold.make(),
    gist(text: code1),
    "What we see here is a configuration file for our project containing the name of project, version etc. What we are interested in are scripts. Those are aliases for shell commands with specific options. For example, clean is a short name for a command that deletes folders build and neardev, and build:release executes AssemblyScript asb (build) command."
        .text
        .make(),
    "asconfig.json".text.bold.make(),
    gist(text: code2),
    "This file is a collection of folders with our contracts in them. When we execute build:release command, we compile contracts from each workspace into the output folder. More about them next."
        .text
        .make(),
    "src".text.bold.make(),
    "Inside src are simple and singleton - our workspaces. They have the same structure, including tests and assembly folders. The difference between them is style they’re written in."
        .text
        .make(),
    "simple".text.bold.make(),
    "We say that an AssemblyScript contract is written in the “simple style” when the index.ts file (the contract entry point) includes a series of exported functions."
        .text
        .make(),
    "In this case, all exported functions become public contract methods."
        .text
        .make(),
    gist(text: code3),
    "singleton".text.bold.make(),
    "We say that an AssemblyScript contract is written in the “singleton style” when the index.ts file (the contract entry point) has a single exported class (the name of the class doesn’t matter) that is decorated with @nearBindgen."
        .text
        .make(),
    "In this case, all methods on the class become public contract methods unless marked private. Also, all instance variables are stored as a serialized instance of the class under a special storage key named STATE. AssemblyScript uses JSON for storage serialization."
        .text
        .make(),
    gist(text: code4),
    '''Warning: be careful when creating a new workspace

Don’t forget to add it’s location to asconfig.json
Your workspace must have assembly folder and index.ts file!'''
        .text
        .red700
        .make(),
  ]);
}

Widget a03() {
  String code1 = '''\$ yarn build:release
yarn run v1.22.15
\$ asb
Done in 14.25s.''';
  String code2 = '''\$ near dev-deploy ../build/release/simple.wasm
Starting deployment. Account id: dev-1634461056712-80360389036896, node: https://rpc.testnet.near.org, helper: https://helper.testnet.near.org, file: ../build/release/simple.wasm
Transaction Id AJUDp6HrJhzwRsvnaSDFuuaWKW8kLzCBK4xy26BnzfQv
To see the transaction in the transaction explorer, please open this url in your browser
https://explorer.testnet.near.org/transactions/AJUDp6HrJhzwRsvnaSDFuuaWKW8kLzCBK4xy26BnzfQv
Done deploying to dev-1634461056712-80360389036896''';
  String code3 = '''\$ near login

Please authorize NEAR CLI on at least one of your accounts.

If your browser doesn't automatically open, please visit this URL
https://wallet.testnet.near.org/login/?title=NEAR+CLI&public_key=<public_key>
Please authorize at least one account at the URL above.''';
  String code4 = '''Which account did you authorize for use with NEAR CLI?
Enter it here:
d3mage-dev.testnet
Logged in as [ d3mage-dev.testnet ] with public key [ ed25519:6aA1xx... ] successfully''';
  String code5 =
      '''\$ near deploy --accountId d3mage-dev.testnet --wasmFile ./build/release/singleton.wasm
Starting deployment. Account id: d3mage-dev.testnet, node: https://rpc.testnet.near.org, helper: https://helper.testnet.near.org, file: ./build/release/singleton.wasm
Transaction Id 6hv4bsfL4SSp9SGcwiTBCUuZxHucYmzLcAuVWsDdrk3d
To see the transaction in the transaction explorer, please open this url in your browser
https://explorer.testnet.near.org/transactions/6hv4bsfL4SSp9SGcwiTBCUuZxHucYmzLcAuVWsDdrk3d
Done deploying to d3mage-dev.testnet''';
  String code6 = '''Difference between dev-deploy and deploy
Characteristics	dev-deploy	deploy
General	Creates an account and deploys to it	Deploys to a provided account
Arguments	WASM file	WASM file, accountId
Access key	No access key	Full access key
Network	Only testnet	No restrictions''';
  return Column(
    children: [
      "scripts".text.bold.make(),
      "Those are command line scenarios that recreate some certain behaviour using the contracts in this project. We’re using them in the next section."
          .text
          .make(),
      "Note: Use OS of your preference, however, Windows users should take in consideration that you should launch your scripts not via PowerShell or cmd, use Git Bash instead."
          .text
          .make()
          .box
          .blue500
          .make(),
      "Warning: Mac with M1 chip has compatibility issues with WASM."
          .text
          .make()
          .box
          .yellow500
          .make(),
      "Building".text.bold.make(),
      "Let’s say it once again, to build contracts in your workspaces execute yarn build:release. You should see:"
          .text
          .make(),
      gist(text: code1),
      "Great! You may notice creation of a new folder in our project called build that contains subfolder release. release has 2 files: simple.wasm and singleton.wasm. Those Wasm (WebAssembly) files are ready to be deployed to the NEAR network. Let’s do it."
          .text
          .make(),
      "Deploying".text.bold.make(),
      "To deploy our contract we will use NEAR CLI. Take a look at commands here. After we’re going to deploy our contracts to testnet using two different ways."
          .text
          .make(),
      gist(text: "dev-deploy"),
      "The very first and quickest way to deploy a smart contract is to run near dev-deploy <WASM_file_path>. We’re going to work with singleton.wasm which path is ./build/release/singleton.wasm/. Our command will look like near dev-deploy ./build/release/simple.wasm."
          .text
          .make(),
      gist(text: code2),
      "Warning: the command above will only run from project root folder (starter--near-sdk-as)."
          .text
          .make()
          .box
          .yellow500
          .make(),
      '''Error: ENOENT: no such file or directory
This error means that your path to WASM file is incorrect.'''
          .text
          .make()
          .box
          .red500
          .make(),
      "At this point one thing has happened that may have been unnoticed by you just yet. Now you will have a neardev subfolder in the project. dev-account file has a name of account to which we deployed a few moments ago."
          .text
          .make(),
      "Note: run cat ./neardev/dev-account to make sure that you have seen this account ID in console when deploying."
          .text
          .make()
          .box
          .blue500
          .make(),
      "deploy".text.bold.make(),
      "Now we will deploy the contract to a specific account - to your testnet. Firstly, we have to log into our account. Run near login."
          .text
          .make(),
      gist(text: code3),
      "Check your browser. There should be a new page opened. Following steps are common to do, so you will get used to them extremely quickly. Following example logging into d3mage-dev.testnet account."
          .text
          .make(),
      Image.network("https://i.imgur.com/VF73yaa.png"),
      Image.network("https://i.imgur.com/6wf8Dmr.png"),
      "Note: always check what site is asking for access and what type of access it is. dApps usually use function access key."
          .text
          .make()
          .box
          .yellow500
          .make(),
      "When you see a blank page in browser - you’re good to return to a terminal. Enter your account name into command line."
          .text
          .make(),
      gist(text: code4),
      "After you\'ve logged in you\'re able run the following command:"
          .text
          .make(),
      gist(
          text:
              "near deploy --accountId <account_name> --wasmFile <WASM_file_path>"),
      "For example,".text.make(),
      gist(
          text:
              "near deploy --accountId d3mage-dev.testnet --wasmFile ./build/release/singleton.wasm"),
      gist(text: code5),
      CupertinoButton(
          child: "link".text.make(),
          onPressed: () => _launchURL(
              "https://explorer.testnet.near.org/transactions/6hv4bsfL4SSp9SGcwiTBCUuZxHucYmzLcAuVWsDdrk3d")),
      "Check the link above to see transaction details.".text.make(),
      gist(text: code6),
      "Difference between dev-deploy and deploy".text.bold.make(),
      VxInlineBlock(
        children: [
          "Characteristics".text.make(),
          Spacer(),
          "dev-deploy".text.make(),
          Spacer(),
          "deploy".text.make(),
        ],
      ),
      VxInlineBlock(
        children: [
          "General".text.make(),
          Spacer(),
          "Creates an account ".text.make(),
          Spacer(),
          "Deploys to a ".text.make(),
        ],
      ),
      VxInlineBlock(
        children: [
          Text("          "),
          Spacer(),
          "and deploys to it".text.make(),
          Spacer(),
          "provided account".text.make(),
        ],
      ),
      VxInlineBlock(
        children: [
          "Arguments".text.make(),
          Spacer(),
          "WASM file".text.make(),
          Spacer(),
          "WASM file, accountId".text.make(),
        ],
      ),
      VxInlineBlock(
        children: [
          "Access key".text.make(),
          Spacer(),
          "No access key".text.make(),
          Spacer(),
          "Full access key".text.make(),
        ],
      ),
      VxInlineBlock(
        children: [
          "Network".text.make(),
          Spacer(),
          "Only testnet".text.make(),
          Spacer(),
          "No restrictions".text.make(),
        ],
      ),
    ],
  );
}

Widget b01() {
  return Column(
    children: [
      "Account".text.bold.make(),
      "NEAR uses human readable account IDs instead of a public key hash. For a 20-minute video explanation, see this Lunch and Learn on YouTube."
          .text
          .make(),
      "Account ID Rules".text.bold.make(),
      '''minimum length is 2
maximum length is 64
Account ID consists of Account ID parts separated by .
Account ID part consists of lowercase alphanumeric symbols separated by either _ or -.
Account names are similar to a domain names. Anyone can create a top-level account (TLA) without separators, e.g. near. Only near can create alice.near. And only alice.near can create app.alice.near and so on. Note, near can NOT create app.alice.near directly.

Regex for a full account ID, without checking for length: ^(([a-z\d]+[\-_])*[a-z\d]+\.)*([a-z\d]+[\-_])*[a-z\d]+\$'''
          .text
          .make(),
      "Top-level Accounts".text.bold.make(),
      '''Top-level account names (TLAs) are very valuable as they provide root of trust and discoverability for companies, applications and users. To allow for fair access to them, the top-level account names that are shorter than MIN_ALLOWED_TOP_LEVEL_ACCOUNT_LENGTH characters (32 at time of writing) will be auctioned off.

Specifically, only REGISTRAR_ACCOUNT_ID account can create new top-level accounts that are shorter than MIN_ALLOWED_TOP_LEVEL_ACCOUNT_LENGTH characters. REGISTRAR_ACCOUNT_ID implements a standard Account Naming interface which allow it to create new accounts.

We are not going to deploy the registrar auction at launch. Instead we will allow it to be deployed by the NEAR Foundation at some point in the future.

Currently all mainnet accounts use a near top-level account name (ex example.near) and all testnet accounts use a testnet top-level account (ex. example.testnet).'''
          .text
          .make(),
      "Subaccounts".text.bold.make(),
      '''As stated before, account names on NEAR follow a similar naming pattern to that of website domains with similar rules. Accounts can create as many subaccounts as they wish, and only the parent account can create a subaccount. For example, example.near can create subaccount1.example.near and subaccount2.example.near but CAN NOT create sub.subaccount.example.near. Only subaccount.example.near can create sub.subaccount.example.near in the same way test.near can NOT create subaccount.example.near. Only the direct parent account has permission to create a subaccount.

Try it out using our near-cli command, near create-account, in your terminal.'''
          .text
          .make(),
      "Implicit-Accounts".text.bold.make(),
      '''Implicit accounts work similarly to Bitcoin/Ethereum accounts. They allow you to reserve an account ID before it's created by generating a ED25519 key-pair locally. This key-pair has a public key that maps to 64 character hex representation which becomes the account ID.

Example:

Public key in base58: BGCCDDHfysuuVnaNVtEhhqeT4k9Muyem3Kpgq2U1m9HX
Implicit Account: 98793cd91a3f870fb126f66285808c7e094afcfc4eda8a970f6648cdf0dbd6de'''
          .text
          .make(),
          SizedBox(height: 8),
      SizedBox(
        width: double.infinity,
        child: VxInlineBlock(
          children: [
            Expanded(
              flex: 4,
              child: CupertinoButton(
                  child: "Click here".text.make(),
                  onPressed: () => _launchURL(
                      "https://docs.near.org/docs/roles/integrator/implicit-accounts")),
            ),
            "for more information as well as a guide on implicit account creation."
                .text
                .make().expand(flex: 8),
          ],
        ),
      ),
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
