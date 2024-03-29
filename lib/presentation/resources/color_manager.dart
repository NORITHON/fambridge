import 'package:flutter/material.dart';

class ColorManager {
  static Color black = HexColor.fromHex("#000000");
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color shadowColor = HexColor.fromHex("#000000").withOpacity(0.1);
  static Color darkGrey = HexColor.fromHex("#636363");
  static Color lightGrey = HexColor.fromHex("#A1A1A1");
  static Color ButtonlightGrey = HexColor.fromHex("#DFDFDF");
  static Color primary = HexColor.fromHex("#FFF3E3");
  static Color point = HexColor.fromHex("#EA6F29");
  static Color lightpoint = HexColor.fromHex("#FDEAE0");
  static Color questionbackgroundColor = HexColor.fromHex("#F6F6F6");
  static Color chipbackgroundColor = HexColor.fromHex("#F8F7F7");
  static Color downloadbackgroundColor = HexColor.fromHex("#F2F2F2");
  static Color storebarUnselectColor = HexColor.fromHex("#DFDFDF");

  static Color backgroundColor = HexColor.fromHex("#E5E5E5");
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
