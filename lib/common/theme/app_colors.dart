import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color.fromRGBO(9, 9, 12, 1);
  static const white = Color.fromRGBO(255, 255, 255, 1);
  static const dark = Color.fromRGBO(255, 255, 255, 0.2);
  static const grey = Color.fromRGBO(186, 186, 186, 1);
  static const purple = Color.fromRGBO(106, 17, 203, 1);
  static const blue = Color.fromRGBO(37, 117, 252, 1);

  static const Gradient purpleBlueGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      purple,
      blue,
    ],
  );
  static const Gradient verticalPurpleBlueGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      purple,
      blue,
    ],
  );
}
