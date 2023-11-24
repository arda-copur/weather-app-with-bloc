import 'package:flutter/material.dart';

String API_KEY = "YOUR API KEY";

mixin ColorsUtility {
  final Color redColor = Colors.red;
  final Color blackColor = Colors.black;
  final Color whiteColor = Colors.white;
  final Color greyColor = Colors.white;
  final Color argbColor =  const Color.fromARGB(255, 98, 41, 197);
  final Color specialOrangeColor = const Color(0xFFFFAB40);
}

mixin PaddingUtility {
  final EdgeInsets lowPadding = const EdgeInsets.all(6);
  final EdgeInsets highPadding = const EdgeInsets.all(20);
  final EdgeInsets mediumPadding = const EdgeInsets.all(12);
  final EdgeInsets normalPadding = const EdgeInsets.all(8);
  final EdgeInsets symmetricVerticalPadding = const EdgeInsets.symmetric(vertical: 5);
  final EdgeInsets symmetricHorizontalPadding = const EdgeInsets.symmetric(horizontal: 5);
}

