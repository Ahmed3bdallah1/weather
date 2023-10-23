import 'package:flutter/material.dart';

class Constants {
  final primaryColor = const Color(0xff6b9dfc);
  final whiteBlueColor = const Color(0xffa1c6fd);
  final blueColor = const Color(0xff205cf1);
  final blackColor = const Color(0xff1a1d26);

  final greyColor = const Color(0xffd9dadb);

  final Shader shader = const LinearGradient(
    colors: <Color>[Color(0xffABCFF2), Color(0xff9AC6F3)],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  final Shader shader2 = const LinearGradient(
    colors: <Color>[Colors.white, Color(0xff9AC6F3)],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  final linearGradientBlue =  const LinearGradient(
      begin: Alignment.bottomRight,
      end: Alignment.topLeft,
      colors: [Color(0xff6b9dfc), Color(0xff205cf1)],
      stops: [0.0,1.0]
  );
  final linearGradientWhiteBlue =  const LinearGradient(
      begin: Alignment.bottomRight,
      end: Alignment.topLeft,
      colors: [Color(0xff6b9dfc), Color(0xffd9dadb)],
      stops: [0.0,1.0]
  );
  final linearGradientWhiteGreen =  const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.white, Colors.lightBlueAccent],
      stops: [0.0,1.0]
  );
  final linearGradientPurple =  const LinearGradient(
      begin: Alignment.bottomRight,
      end: Alignment.topLeft,
      colors: [Color(0xff51087E), Color(0xff6C0BA9)],
      stops: [0.0,1.0]
  );
  final linearGradientPurpleBlue =  const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xff6C0BA9), Color(0xffa1c6fd)],
      stops: [0.0,1.0]
  );


}