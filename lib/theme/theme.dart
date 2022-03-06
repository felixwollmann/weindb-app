import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weindb/theme/constants.dart';

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

// final ThemeData themeDataLight = theme(colorSchemeLight);
// final ThemeData themeDataDark = theme(colorSchemeDark);

// TextTheme _textTheme = TextTheme(
//   headline1: GoogleFonts.quicksand(
//       fontSize: 98, fontWeight: FontWeight.w300, letterSpacing: -1.5),
//   headline2: GoogleFonts.quicksand(
//       fontSize: 61, fontWeight: FontWeight.w300, letterSpacing: -0.5),
//   headline3: GoogleFonts.quicksand(fontSize: 49, fontWeight: FontWeight.w400),
//   headline4: GoogleFonts.quicksand(
//       fontSize: 35, fontWeight: FontWeight.w400, letterSpacing: 0.25),
//   headline5: GoogleFonts.quicksand(fontSize: 24, fontWeight: FontWeight.w400),
//   headline6: GoogleFonts.quicksand(
//       fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
//   subtitle1: GoogleFonts.quicksand(
//       fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
//   subtitle2: GoogleFonts.quicksand(
//       fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
//   bodyText1: GoogleFonts.openSans(
//       fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
//   bodyText2: GoogleFonts.openSans(
//       fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
//   button: GoogleFonts.openSans(
//       fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
//   caption: GoogleFonts.openSans(
//       fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
//   overline: GoogleFonts.openSans(
//       fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
// );

// Typography _typography = Typography.material2014();

ThemeData theme(
    // ColorScheme colorScheme,
    Brightness brightness) {
  @Deprecated('Use isDark instead')
  bool light = brightness == Brightness.light;

  bool isDark = brightness == Brightness.dark;

  //

  // const ColorScheme colorSchemeLight = ColorScheme.light(
  //   // primary: Colors.pink[700]!,
  //   primary: Color(0xFFEE2677),
  //   primaryContainer: Color(0xFF8c0032),
  //   // secondary: Color(0xFFF9DC5C),
  //   // secondary: Color(0xFF47A8BD),
  //   // secondary: Color(0xFFFF85A3),
  //   secondary: Color(0xFFFF4D79),
  //   secondaryContainer: Color(0xFF002171),
  //   surface: Colors.white,
  //   background: Color.fromARGB(255, 221, 221, 221),
  //   error: Color(0xFFB00020),
  //   onPrimary: Colors.white,
  //   onSecondary: Colors.white,
  //   onSurface: Colors.black,
  //   onBackground: Colors.black,
  //   onError: Colors.white,
  //   brightness: Brightness.light,
  // );

  ColorScheme colorScheme = ColorScheme(
    brightness: brightness,

    // primary: Colors.pink[700]!,
    primary: isDark ? const Color(0xFF574AE2) : const Color(0xFFEE2677),
    primaryContainer: isDark ? const Color.fromARGB(73, 87, 74, 226) : const Color.fromARGB(255, 255, 199, 222),
    onPrimaryContainer: isDark ? Colors.white : Colors.black,
    // secondary: Color(0xFFF9DC5C),
    // secondary: Color(0xFF47A8BD),
    // secondary: Color(0xFFFF85A3),
    secondary: isDark ? const Color(0xff2C0735) : const Color(0xFFFF4D79),
    secondaryContainer: const Color(0xFF002171),
    surface: isDark ? const Color.fromRGBO(40, 40, 40, 1) : Colors.white,
    surfaceVariant: isDark ? const Color.fromRGBO(60, 60, 60, 1) : Colors.grey[200]!,
    background: isDark ? const Color.fromRGBO(20, 20, 20, 1) : Colors.grey[100]!,
    error: const Color(0xFFB00020),
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: isDark ? Colors.white : Colors.black,
    onBackground: isDark ? Colors.white : Colors.black,
    onError: Colors.white,
    tertiary: isDark ? Colors.lightGreen[900] : Colors.lightGreen[700],
    onTertiary: Colors.white,
  );

  // const ColorScheme colorSchemeDark = ColorScheme.dark(
  //   primary: Color(0xFF574AE2),
  //   primaryContainer: Color(0xFF8c0032),
  //   secondary: Color(0xff2C0735),
  //   // secondaryContainer: Color(0xFF002171),
  //   // surface: Colors.white,
  //   // background: Colors.black,
  //   // error: Color(0xFFB00020),
  //   onPrimary: Colors.white,
  //   onSecondary: Colors.white,
  //   // onSurface: Colors.black,
  //   // onBackground: Colors.black,
  //   // onError: Colors.white,
  //   // brightness: Brightness.light,
  // );

  // final colorScheme = light ? colorSchemeLight : colorSchemeDark;

  final bool primaryIsLight = Brightness.light ==
      ThemeData.estimateBrightnessForColor(colorScheme.primary);
  final bool secondaryIsLight = Brightness.light ==
      ThemeData.estimateBrightnessForColor(colorScheme.secondary);

  TextTheme textTheme =
      (isDark ? Typography.whiteMountainView : Typography.blackMountainView)
          .copyWith(
    headline1: GoogleFonts.poppins(
      fontSize: 93,
      fontWeight: FontWeight.w300,
      letterSpacing: -1.5,
    ),
    headline2: GoogleFonts.poppins(
      fontSize: 58,
      fontWeight: FontWeight.w300,
      letterSpacing: -0.5,
    ),
    headline3: GoogleFonts.poppins(
        fontSize: 46,
        fontWeight: FontWeight.w700,
        color: colorScheme.onBackground),
    headline4: GoogleFonts.poppins(
      fontSize: 33,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
    ),
    headline5: GoogleFonts.poppins(
      fontSize: 23,
      fontWeight: FontWeight.w400,
    ),
    headline6: GoogleFonts.poppins(
      fontSize: 19,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
    ),
    subtitle1: GoogleFonts.poppins(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
    ),
    subtitle2: GoogleFonts.poppins(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
    ),
    bodyText1: GoogleFonts.quicksand(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
    ),
    bodyText2: GoogleFonts.quicksand(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
    ),
    button: GoogleFonts.quicksand(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 1.25,
    ),
    caption: GoogleFonts.quicksand(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
    ),
    overline: GoogleFonts.quicksand(
        fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
  );

  return ThemeData(
    dividerTheme: DividerThemeData(
      color: colorScheme.secondary,
      thickness: 3,
    ),
    cardTheme: CardTheme(
      margin: const EdgeInsets.all(0),
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kBorderRadius),
      )
    ),
    scaffoldBackgroundColor: colorScheme.background,
    cardColor: colorScheme.surface,
    brightness: brightness,
    colorScheme: colorScheme,
    primaryColor: colorScheme.primary,
    // primaryColorBrightness:
    //     ThemeData.estimateBrightnessForColor(colorScheme.primary),
    primaryColorDark: colorScheme.primaryContainer,
    // accentColor: colorScheme.secondary,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      unselectedIconTheme:
          IconThemeData(color: light ? Colors.grey[700] : Colors.grey[500]),
      selectedIconTheme: IconThemeData(size: 30, color: colorScheme.primary),
      selectedItemColor: colorScheme.primary,
    ),
    snackBarTheme: const SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      // elevation: 100,
    ),
    appBarTheme: AppBarTheme(
        // backwardsCompatibility: false,
        color: colorScheme.secondary,
        // titleTextStyle: textTheme.headline6!.copyWith(color: light ? Colors.black : Colors.white),
        titleTextStyle: textTheme.headline6!
            .copyWith(color: secondaryIsLight ? Colors.black : Colors.white),
        iconTheme: IconThemeData(
            color: secondaryIsLight ? Colors.black : Colors.white),
        // titleTextStyle:
        // _typography.headline6!.copyWith(color: colorScheme.onPrimary),
        centerTitle: true,
        systemOverlayStyle:
            ThemeData.estimateBrightnessForColor(colorScheme.primary) ==
                    Brightness.light
                ? SystemUiOverlayStyle.dark
                : SystemUiOverlayStyle.light),
    textTheme: textTheme,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
