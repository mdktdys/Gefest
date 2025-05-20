import 'package:flutter/material.dart';

import 'package:flutter_riverpod/legacy.dart';
import 'package:google_fonts/google_fonts.dart';

class Ca {
  static const Color primary = Color(0xff2196f3);
  static const Color primaryHovered = Color.fromARGB(255, 25, 116, 190);
  static const Color primaryDisabled = Color.fromARGB(255, 16, 70, 114);
}

class Fa {
  static TextStyle small = GoogleFonts.roboto(fontSize: 14);
  static TextStyle smedium = GoogleFonts.roboto(fontSize: 16);
  static TextStyle medium = GoogleFonts.roboto(fontSize: 20);

  static TextStyle big = GoogleFonts.roboto(fontSize: 34);

  static TextStyle smallMono = GoogleFonts.robotoMono(fontSize: 14);
}

final darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: const Color(0xFF1D2126),
    canvasColor: const Color(0xFF1D2126),
    colorScheme: ColorScheme.fromSeed(
        primary: const Color(0xff2196f3),
        seedColor: const Color(0xff2196f3),
        surface: const Color(0xFF1D2126),
        onSurface: const Color(0xFF282c31)));


final lightTheme = ThemeData.light().copyWith(

    scaffoldBackgroundColor: const Color(0xFFFFFFFF),
    canvasColor: const Color(0xFFFFFFFF),
    colorScheme: ColorScheme.fromSeed(
        primary: const Color(0xff2196f3),
        seedColor: const Color(0xff2196f3),
        surface: const Color(0xFFFFFFFF),
        onSurface: const Color(0xFF282c31)));


extension ColorsExt on Color {
  MaterialColor toMaterialColor() {
    final int red = this.red;
    final int green = this.green;
    final int blue = this.blue;

    final Map<int, Color> shades = {
      50: Color.fromRGBO(red, green, blue, .1),
      100: Color.fromRGBO(red, green, blue, .2),
      200: Color.fromRGBO(red, green, blue, .3),
      300: Color.fromRGBO(red, green, blue, .4),
      400: Color.fromRGBO(red, green, blue, .5),
      500: Color.fromRGBO(red, green, blue, .6),
      600: Color.fromRGBO(red, green, blue, .7),
      700: Color.fromRGBO(red, green, blue, .8),
      800: Color.fromRGBO(red, green, blue, .9),
      900: Color.fromRGBO(red, green, blue, 1),
    };

    return MaterialColor(value, shades);
  }
}

final themeProvider = ChangeNotifierProvider<ThemeNotifier>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends ChangeNotifier {
  ThemeData theme = darkTheme;

  isDark(){
    return theme == darkTheme? true : false;
  }

  toggle(){
    theme = isDark()? lightTheme : darkTheme;
    notifyListeners();
  }

  dark(){
    theme = darkTheme;
    notifyListeners();
  }

  light(){
    theme = lightTheme;
    notifyListeners();
  }
}