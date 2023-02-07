import 'package:flutter/material.dart';

MaterialStateProperty<Color> getColor(Color color, Color colorPressed) {
  // ignore: prefer_function_declarations_over_variables
  final getColor = (Set<MaterialState> states) {
    if (states.contains(MaterialState.pressed)) {
      return colorPressed;
    } else {
      return color;
    }
  };
  return MaterialStateProperty.resolveWith(getColor);
}
