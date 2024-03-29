import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:near_learning_app/models/models.dart';
//import 'package:supabase_flutter/supabase_flutter.dart';
part 'snippets_constant.dart';

//final supabase = Supabase.instance.client;
const Duration defaultDuration = Duration(milliseconds: 300);
const double defaultPadding = 15.0;

final int limitHeight = 1000;
final int limitWidth = 500;

const Color loginBg = Color(0xFF4FD1D9);
const Color signupBg = Color(0xFFE3935B);

final itemsFirst = [
  DrawerItem(
      title: 'NEAR Forum',
      icon: Icons.person_add,
      url: "https://gov.near.org/"),
  DrawerItem(
      title: 'NFT Gallery',
      icon: Icons.browse_gallery,
      url: "https://juenpeha.github.io/flutter_web_nft_gallery/#/"),
  DrawerItem(
      title: 'AWESOMENEAR',
      icon: Icons.auto_awesome,
      url: "https://awesomenear.com/"),
  DrawerItem(
      title: 'STATS.GALLERY',
      icon: Icons.query_stats,
      url: "https://stats.gallery/"),
];

final itemsSecond = [
  DrawerItem(
      title: 'NEAR Academy',
      icon: Icons.person_add,
      url: "https://near.academy/"),
  DrawerItem(
      title: 'NEAR in minutes',
      icon: Icons.browse_gallery,
      url: "https://near-in-minutes.com/"),
];

extension ShowSnackBar on BuildContext {
  void showSnackBar(
      {required String message, Color backgroundColor = Colors.white}) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: backgroundColor,
    ));
  }

  void showErrorSnackBar({required String message}) {
    showSnackBar(message: message, backgroundColor: Colors.red);
  }
}

List lottieAnim({int? index, bool repeat = false, bool animate = false}) {
  List<Widget> lottieAnimations = <Widget>[
    Lottie.asset("assets/json_anim/swipe.json",
        repeat: repeat, fit: BoxFit.contain, animate: animate),
    Lottie.asset("assets/json_anim/learning-concept.json",
        repeat: repeat, fit: BoxFit.contain, animate: animate),
    Lottie.asset("assets/json_anim/learn.json",
        repeat: repeat, fit: BoxFit.contain, animate: animate),
  ];
  return [lottieAnimations[index ?? 0], lottieAnimations.length];
}
