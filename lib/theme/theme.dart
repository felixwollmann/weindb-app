import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

// final ColorScheme colorSchemeLight = ColorScheme(
//   // bis jetzt nur das Material Color Scheme
//   brightness: Brightness.light,
//   primary: Color(0xFF6200EE),
//   primaryVariant: Color(0xFF3700B3),
//   secondary: Color(0xFF03DAC6),
//   secondaryVariant: Color(0xFF018768),
//   background: Color(0xFFFFFFFF),
//   surface: Color(0xFFF5F5F5),
//   error: Color(0xFFB00020),
//   onPrimary: Color(0xFFFFFFFF),
//   onSecondary: Color(0xFF000000),
//   onBackground: Color(0xFF000000),
//   onSurface: Color(0xFF000000),
//   onError: Color(0xFFFFFFFF),
// );
// https://material.io/resources/color/#!/?view.left=1&view.right=0&primary.color=C2185B&secondary.color=0D47A1
final ColorScheme colorSchemeLight = ColorScheme.light(
  primary: Colors.pink[700]!,
  primaryVariant: Color(0xFF8c0032),
  secondary: Colors.blue[900]!,
  secondaryVariant: Color(0xFF002171),
  surface: Colors.white,
  background: Colors.black,
  error: Color(0xFFB00020),
  onPrimary: Colors.white,
  onSecondary: Colors.white,
  onSurface: Colors.black,
  onBackground: Colors.black,
  onError: Colors.white,
  brightness: Brightness.light,
);

final ColorScheme colorSchemeDark = ColorScheme.dark(
  primary: Colors.pink[700]!,
  primaryVariant: Color(0xFF8c0032),
  secondary: Colors.blue[900]!,
  secondaryVariant: Color(0xFF002171),
  // surface: Colors.white,
  // background: Colors.black,
  // error: Color(0xFFB00020),
  onPrimary: Colors.white,
  onSecondary: Colors.white,
  // onSurface: Colors.black,
  // onBackground: Colors.black,
  // onError: Colors.white,
  // brightness: Brightness.light,
);

final ThemeData themeDataLight = theme(colorSchemeLight);
final ThemeData themeDataDark = theme(colorSchemeDark);

TextTheme _textTheme = TextTheme(
  headline1: GoogleFonts.quicksand(
      fontSize: 98, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  headline2: GoogleFonts.quicksand(
      fontSize: 61, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  headline3: GoogleFonts.quicksand(fontSize: 49, fontWeight: FontWeight.w400),
  headline4: GoogleFonts.quicksand(
      fontSize: 35, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headline5: GoogleFonts.quicksand(fontSize: 24, fontWeight: FontWeight.w400),
  headline6: GoogleFonts.quicksand(
      fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  subtitle1: GoogleFonts.quicksand(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  subtitle2: GoogleFonts.quicksand(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyText1: GoogleFonts.openSans(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyText2: GoogleFonts.openSans(
      fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  button: GoogleFonts.openSans(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  caption: GoogleFonts.openSans(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  overline: GoogleFonts.openSans(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);

ThemeData theme(
  ColorScheme colorScheme,
) {
  bool light = colorScheme.brightness == Brightness.light;
  return ThemeData(
      brightness: colorScheme.brightness,
      colorScheme: colorScheme,
      primaryColor: colorScheme.primary,
      primaryColorBrightness:
          ThemeData.estimateBrightnessForColor(colorScheme.primary),
      primaryColorDark: colorScheme.primaryVariant,
      // accentColor: colorScheme.secondary,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        unselectedIconTheme:
            IconThemeData(color: light ? Colors.grey[700] : Colors.grey[500]),
        selectedIconTheme: IconThemeData(size: 30, color: colorScheme.primary),
        selectedItemColor: colorScheme.primary,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        // elevation: 100,
      ),
      appBarTheme: AppBarTheme(
          // backwardsCompatibility: false,
          color: colorScheme.primary,
          titleTextStyle:
              _textTheme.headline6!.copyWith(color: colorScheme.onPrimary),
          centerTitle: true,
          systemOverlayStyle:
              ThemeData.estimateBrightnessForColor(colorScheme.primary) ==
                      Brightness.light
                  ? SystemUiOverlayStyle.dark
                  : SystemUiOverlayStyle.light),
      textTheme: _textTheme,
      inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
      );
}
