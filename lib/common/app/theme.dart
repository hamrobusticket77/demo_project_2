import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTheme {
  // static const Color primaryColor = Color(0xFF245D87);
  // static const Color primaryColor = Color(0xFF00B251);
  static const Color primaryColor = Color(0xFF00A36C);

  static const Color secondaryColor = Color(0xFF00B251);
  static const Color black = Color(0xff000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color lightGray = Color(0xFFF2f2F2);
  static const Color lighterGrey = Color(0xffF9F9F9);
  static const Color shadowColor = Color(0x1A000000);
  static const Color grey = Color(0xFF9E9E9E);
  static const Color midGrayColor = Color(0xFFC6C6C6);
  static const Color red = Color(0xffDC143C);
  static const Color pinkColor = Color(0xffFF8C94);
  static const Color blueShadowColor = Color(0xffA8E6CE);
  static const Color greenShadowColor = Color(0xffDCEDC2);
  static const Color lightYello = Color(0xffFFD3B5);
  static const Color lightRedColor = Color(0xffFFAAA6);
  static const Color lightPurpleColor = Color.fromARGB(255, 209, 187, 255);
  static const Color primaryShdowColor = Color.fromARGB(255, 141, 189, 255);
  static const Color blueLight = Color(0xffE9EFF8);
  static const Color skyBlue = Color(0xffE6F8FB);
  static const Color darkRed = Color(0xffC62D38);
  static const Color yellow = Color(0xffFFC727);
  static const Color textGreenColor = Color(0xFF40826D);
  // static const Color greenColor = Colors.green;

  static const Color darkGrey = Color(0xff4D4D4D);

  static const double symmetricHozPadding = 12.0;

  static const MaterialColor primarymaterialcolor =
      MaterialColor(_primarymaterialcolorPrimaryValue, <int, Color>{
    50: Color(0xFFE0F4ED),
    100: Color(0xFFB3E3D3),
    200: Color(0xFF80D1B6),
    300: Color(0xFF4DBF98),
    400: Color(0xFF26B182),
    500: Color(_primarymaterialcolorPrimaryValue),
    600: Color(0xFF009B64),
    700: Color(0xFF009159),
    800: Color(0xFF00884F),
    900: Color(0xFF00773D),
  });
  static const int _primarymaterialcolorPrimaryValue = 0xFF00A36C;

  static const MaterialColor primarymaterialcolorAccent =
      MaterialColor(_primarymaterialcolorAccentValue, <int, Color>{
    100: Color(0xFFA5FFCC),
    200: Color(_primarymaterialcolorAccentValue),
    400: Color(0xFF3FFF92),
    700: Color(0xFF25FF84),
  });
  static const int _primarymaterialcolorAccentValue = 0xFF72FFAF;

  static ThemeData lightTheme = ThemeData(
      primarySwatch: primarymaterialcolor,
      primaryColor: primaryColor,
      primaryColorDark: primaryColor,
      // datePickerTheme: DatePickerThemeData().copyWith(
      //   backgroundColor: Theme.of(context).primaryColor,
      // ),

      // colorScheme: ColorScheme.fromSwatch(
      //   primarySwatch: CustomTheme.primarymaterialcolor,
      //   accentColor: Theme.of(context).primaryColor,
      //   // backgroundColor: CustomTheme.white,
      // ),

      colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: primaryColor,
          onPrimary: primaryColor,
          secondary: primarymaterialcolor.shade700,
          onSecondary: primarymaterialcolor,
          error: red,
          onError: red,
          background: white,
          onBackground: white,
          surface: white,
          onSurface: white,
          tertiary: secondaryColor),
      shadowColor: Colors.black,
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: primaryColor),
        // systemOverlayStyle: SystemUiOverlayStyle.dark,

        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: primarymaterialcolorAccent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      scaffoldBackgroundColor: white,
      iconTheme: const IconThemeData(color: black),
      // fontFamily: GoogleFonts.openSans().fontFamily,
      // fontFamily: Font.quicksand,

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
        ),
      ),
      dialogTheme: DialogTheme(
        surfaceTintColor: CustomTheme.white,
        backgroundColor: CustomTheme.white,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(10.0), // Set your desired radius here
        ),
      ),
      checkboxTheme: CheckboxThemeData(fillColor:
          MaterialStateColor.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return primaryColor;
        }
        return lightGray;
      })),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: black,
          fontWeight: FontWeight.bold,
          fontSize: 24,
          height: 1.35,
          letterSpacing: 0.5,
        ),
        displayMedium: TextStyle(
          color: black,
          fontWeight: FontWeight.bold,
          fontSize: 22,
          letterSpacing: 0.5,
          height: 1.35,
        ),
        displaySmall: TextStyle(
          color: black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
          letterSpacing: 0.5,
          height: 1.35,
        ),
        headlineMedium: TextStyle(
          fontSize: 18,
          color: black,
          letterSpacing: 0.5,
          height: 1.35,
        ),
        headlineSmall: TextStyle(
          color: black,
          fontSize: 16,
          letterSpacing: 0.5,
          height: 1.35,
        ),
        titleLarge: TextStyle(
          color: black,
          fontSize: 14,
          fontWeight: FontWeight.w300,
          letterSpacing: 0.5,
          height: 1.35,
        ),
        bodySmall: TextStyle(
          color: black,
          fontSize: 8,
          letterSpacing: 0.5,
          height: 1.35,
        ),
        titleSmall: TextStyle(
          color: black,
          fontSize: 12,
          letterSpacing: 0.5,
          height: 1.35,
        ),
        titleMedium: TextStyle(
          color: black,
          fontSize: 10,
          letterSpacing: 0.5,
          height: 1.35,
        ),
        labelLarge: TextStyle(
          color: black,
          fontSize: 12,
          letterSpacing: 0.5,
          height: 1.35,
        ),
        bodyLarge: TextStyle(
          fontSize: 12,
          color: black,
          letterSpacing: 0.5,
          height: 1.35,
        ),
        bodyMedium: TextStyle(
          fontSize: 10,
          color: black,
          letterSpacing: 0.5,
          height: 1.35,
        ),
      ),
      bottomAppBarTheme: BottomAppBarTheme(color: white),
      progressIndicatorTheme: ProgressIndicatorThemeData()
          .copyWith(color: primaryColor, circularTrackColor: primaryColor));

  // benighat theme

  static const Color primaryColorBenighat = Color(0xFF38128f);

  static const MaterialColor primarymaterialcolorbenighat =
      MaterialColor(_primarymaterialcolorbenighatPrimaryValue, <int, Color>{
    50: Color(0xFFE7E3F2),
    100: Color(0xFFC3B8DD),
    200: Color(0xFF9C89C7),
    300: Color(0xFF7459B1),
    400: Color(0xFF5636A0),
    500: Color(_primarymaterialcolorbenighatPrimaryValue),
    600: Color(0xFF321087),
    700: Color(0xFF2B0D7C),
    800: Color(0xFF240A72),
    900: Color(0xFF170560),
  });
  static const int _primarymaterialcolorbenighatPrimaryValue = 0xFF38128F;

  static const MaterialColor primarymaterialcolorbenighatAccent =
      MaterialColor(_primarymaterialcolorbenighatAccentValue, <int, Color>{
    100: Color(0xFFA091FF),
    200: Color(_primarymaterialcolorbenighatAccentValue),
    400: Color(0xFF492BFF),
    700: Color(0xFF3312FF),
  });
  static const int _primarymaterialcolorbenighatAccentValue = 0xFF745EFF;

  static ThemeData lightThemeBenighat = ThemeData(
      primarySwatch: primarymaterialcolorbenighat,
      primaryColor: primaryColorBenighat,

      // datePickerTheme: DatePickerThemeData().copyWith(
      //   backgroundColor: Theme.of(context).primaryColor,
      // ),

      // colorScheme: ColorScheme.fromSwatch(
      //   primarySwatch: CustomTheme.primarymaterialcolor,
      //   accentColor: Theme.of(context).primaryColor,
      //   // backgroundColor: CustomTheme.white,
      // ),

      primaryColorDark: primaryColorBenighat,
      colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: primaryColorBenighat,
          onPrimary: white,
          secondary: primarymaterialcolorbenighat.shade700,
          onSecondary: white,
          error: red,
          onError: red,
          background: white,
          onBackground: white,
          surface: white,
          onSurface: white,
          tertiary: primarymaterialcolorbenighat.shade300),
      shadowColor: Colors.black,
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: primaryColorBenighat),
        // systemOverlayStyle: SystemUiOverlayStyle.dark,

        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: primarymaterialcolorbenighatAccent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      scaffoldBackgroundColor: white,
      iconTheme: const IconThemeData(color: black),
      // fontFamily: GoogleFonts.openSans().fontFamily,
      // fontFamily: Font.quicksand,

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColorBenighat,
        ),
      ),
      dialogTheme: DialogTheme(
        surfaceTintColor: CustomTheme.white,
        backgroundColor: CustomTheme.white,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(10.0), // Set your desired radius here
        ),
      ),
      checkboxTheme: CheckboxThemeData(fillColor:
          MaterialStateColor.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return primaryColorBenighat;
        }
        return lightGray;
      })),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: black,
          fontWeight: FontWeight.bold,
          fontSize: 24,
          height: 1.35,
          letterSpacing: 0.5,
        ),
        displayMedium: TextStyle(
          color: black,
          fontWeight: FontWeight.bold,
          fontSize: 22,
          letterSpacing: 0.5,
          height: 1.35,
        ),
        displaySmall: TextStyle(
          color: black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
          letterSpacing: 0.5,
          height: 1.35,
        ),
        headlineMedium: TextStyle(
          fontSize: 18,
          color: black,
          letterSpacing: 0.5,
          height: 1.35,
        ),
        headlineSmall: TextStyle(
          color: black,
          fontSize: 16,
          letterSpacing: 0.5,
          height: 1.35,
        ),
        titleLarge: TextStyle(
          color: black,
          fontSize: 14,
          fontWeight: FontWeight.w300,
          letterSpacing: 0.5,
          height: 1.35,
        ),
        bodySmall: TextStyle(
          color: black,
          fontSize: 8,
          letterSpacing: 0.5,
          height: 1.35,
        ),
        titleSmall: TextStyle(
          color: black,
          fontSize: 12,
          letterSpacing: 0.5,
          height: 1.35,
        ),
        titleMedium: TextStyle(
          color: black,
          fontSize: 10,
          letterSpacing: 0.5,
          height: 1.35,
        ),
        labelLarge: TextStyle(
          color: black,
          fontSize: 12,
          letterSpacing: 0.5,
          height: 1.35,
        ),
        bodyLarge: TextStyle(
          fontSize: 12,
          color: black,
          letterSpacing: 0.5,
          height: 1.35,
        ),
        bodyMedium: TextStyle(
          fontSize: 10,
          color: black,
          letterSpacing: 0.5,
          height: 1.35,
        ),
      ),
      bottomAppBarTheme: const BottomAppBarTheme(color: white),
      progressIndicatorTheme: ProgressIndicatorThemeData().copyWith(
          color: primaryColorBenighat,
          circularTrackColor: primaryColorBenighat));
}
