import 'package:flutter/material.dart';

class MyThemes {
  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.black54,
      dividerColor: Colors.transparent,
      primaryColor: Colors.grey.shade900,
      focusColor: Colors.white,
      inputDecorationTheme: const InputDecorationTheme(
          iconColor: Colors.white,
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          fillColor: Colors.white,
          focusColor: Colors.white,
          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white))),
      primaryColorDark: Colors.white,
      primaryColorLight: Colors.blueGrey.shade900.withOpacity(0.3),
      elevatedButtonTheme:
          ElevatedButtonThemeData(style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue))),
      canvasColor: Colors.white,
      appBarTheme:
          AppBarTheme(backgroundColor: Colors.grey.shade900, titleTextStyle: const TextStyle(color: Colors.white)),
      cardColor: Colors.grey.shade900,
      expansionTileTheme: const ExpansionTileThemeData(
        textColor: Colors.blue,
        collapsedIconColor: Colors.white,
        iconColor: Colors.blue,
      ),
      colorScheme: const ColorScheme.dark().copyWith(secondary: Colors.black),
      textSelectionTheme: const TextSelectionThemeData(
          selectionHandleColor: Colors.blue, selectionColor: Colors.blue, cursorColor: Colors.blue));

  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      radioTheme: RadioThemeData(fillColor: MaterialStateProperty.all(Colors.blue)),
      dividerColor: Colors.transparent,
      primaryColor: Colors.white,
      primaryColorDark: Colors.black,
      primaryColorLight: Colors.grey.withOpacity(0.4),
      focusColor: Colors.black,
      inputDecorationTheme: const InputDecorationTheme(
          suffixIconColor: Colors.grey,
          iconColor: Colors.black,
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          fillColor: Colors.black,
          focusColor: Colors.black,
          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black))),
      elevatedButtonTheme:
          ElevatedButtonThemeData(style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue))),
      canvasColor: Colors.grey.shade600,
      appBarTheme: const AppBarTheme(backgroundColor: Colors.white, titleTextStyle: TextStyle(color: Colors.black)),
      cardColor: Colors.white,
      expansionTileTheme: const ExpansionTileThemeData(
        textColor: Colors.blue,
        collapsedIconColor: Colors.black,
        iconColor: Colors.blue,
      ),
      colorScheme: const ColorScheme.light().copyWith(secondary: Colors.white),
      textSelectionTheme: const TextSelectionThemeData(
          selectionHandleColor: Colors.blue, selectionColor: Colors.blue, cursorColor: Colors.blue));
}
