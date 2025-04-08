import 'package:flutter/material.dart';

import 'hex_color.dart';

class AppColors {
  static Color primary = const Color.fromARGB(255, 5, 118, 162);
  static Color secondPrimary = HexColor('#F4E07D');
  static Color greyTextColor = const Color(0xff8E8E8E);
  static Color greyFieldColor = const Color(0xffF2F2F2);
  static Color greyLite = HexColor('#D6D6D6');
  static Color blackLight = HexColor('#525252');
  static Color borderColor = HexColor('#A39C95');
  static Color border2Color = HexColor('#DEDEDE');
  static Color blackTextColor = HexColor('#222222');
  static Color black2Lite = HexColor('#3D3D3D');
  static Color red = HexColor('#FF0000');
  static Color black = Colors.black;
  static Color blackLite = Colors.black12;
  static Color success = Colors.green;
  static Color white = Colors.white;
  static Color error = Colors.red;
  static Color transparent = Colors.transparent;

  static Color gray = Colors.grey;

  Color darken(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }

  Color lightens(String color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(HexColor(color));
    final hslLight =
        hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

    return hslLight.toColor();
  }
}
