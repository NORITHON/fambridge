import 'package:flutter/material.dart';

class ColorManager {
  static Color black = HexColor.fromHex("#000000");
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color shadowColor = HexColor.fromHex("#000000");
  static Color darkGrey = HexColor.fromHex("#636363");
  static Color lightGrey = HexColor.fromHex("#A1A1A1");
  static Color primary = HexColor.fromHex("#FFF3E3");
  static Color point = HexColor.fromHex("#EA6F29");

  static Color backgroundColor = HexColor.fromHex("#FFFFFF");
  static Color textFieldbackgroundColor = HexColor.fromHex("#FFFFFF");

  static Color error = HexColor.fromHex("#EA6F29");

  static Color buttonDisable = HexColor.fromHex("#F4B794");
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');
    if (hexColorString.length == 6) {
      hexColorString = "FF$hexColorString"; // 8 char with opacity 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
