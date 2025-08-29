import 'dart:math';
import 'package:flutter/material.dart';

class ColorLogic {
  static Color randomColor() {
    final rng = Random();
    return Color.fromARGB(
      255,
      rng.nextInt(256),
      rng.nextInt(256),
      rng.nextInt(256),
    );
  }

  static String getHex(Color color) {
    return '#${color.red.toRadixString(16).padLeft(2, '0').toUpperCase()}'
        '${color.green.toRadixString(16).padLeft(2, '0').toUpperCase()}'
        '${color.blue.toRadixString(16).padLeft(2, '0').toUpperCase()}';
  }

  static String getArgb(Color color) {
    return 'ARGB(${color.alpha}, ${color.red}, ${color.green}, ${color.blue})';
  }

  static bool isDark(Color color) {
    return color.computeLuminance() < 0.5;
  }

  static Color getForegroundColor(Color backgroundColor) {
    return isDark(backgroundColor) ? Colors.white : Colors.black87;
  }
}