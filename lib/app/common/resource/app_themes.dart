import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/_shared_preference_key.dart';
import 'color.dart';

///   created               : Aditya Pratama
///   originalFilename      : app_themes
///   date                  : 11 Jun 2021
///   —————————————————————————————————————————————————————————————————————————————
///   feature support :
///   - light mode
///   - dark mode
///
///   udah ga perlu di utak atik, kalo mau ubah warna app ke [color.dart]
///   udah disetup standard guideline nya https://material.io
///

class AppThemes {
  final String _sThemeModeKey = 'S_THEME_MODE_KEY';
  final String _sThemeModeLight = '_sThemeModeLight';
  final String _sThemeModeDark = '_sThemeModeDark';
  static const String _fontFamily = 'NunitoSans';

  // LIGHT THEME TEXT
  // ignore: unused_field
  static const TextTheme _lightTextTheme = TextTheme(
    overline: TextStyle(color: colorWhite, fontFamily: _fontFamily),
    headline1: TextStyle(fontSize: 20.0, fontFamily: _fontFamily),
    bodyText1: TextStyle(fontSize: 16.0, fontFamily: _fontFamily),
    bodyText2: TextStyle(fontSize: 14.0, fontFamily: _fontFamily),
    button: TextStyle(fontSize: 15.0, fontFamily: _fontFamily),
    headline6: TextStyle(fontSize: 16.0, fontFamily: _fontFamily),
    subtitle1: TextStyle(fontSize: 16.0, fontFamily: _fontFamily),
    caption: TextStyle(fontSize: 12.0, fontFamily: _fontFamily),
  );

  // DARK THEME TEXT
  static const TextTheme _darkTextTheme = TextTheme(
    overline: TextStyle(color: colorBlack, fontFamily: _fontFamily),
    headline1: TextStyle(fontSize: 20.0, fontFamily: _fontFamily),
    bodyText1: TextStyle(fontSize: 16.0, fontFamily: _fontFamily),
    bodyText2: TextStyle(fontSize: 14.0, fontFamily: _fontFamily),
    button: TextStyle(fontSize: 15.0, fontFamily: _fontFamily),
    headline6: TextStyle(fontSize: 16.0, fontFamily: _fontFamily),
    subtitle1: TextStyle(fontSize: 16.0, fontFamily: _fontFamily),
    caption: TextStyle(fontSize: 12.0, fontFamily: _fontFamily),
  );

  // —————————————————————————————————————————————————————————————————————————————
  // LIGHT THEME
  // —————————————————————————————————————————————————————————————————————————————

  static final ThemeData _lightTheme = ThemeData(
    fontFamily: _fontFamily,
    primaryColor: colorPrimary,
    primaryColorDark: colorPrimaryDark,
    errorColor: Colors.red[500],
    scaffoldBackgroundColor: colorWhite,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: colorPrimary,
    ),
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: colorBlack),
      color: colorWhite,
      elevation: 0,
    ),
    colorScheme: const ColorScheme.light(
      primary: colorPrimary,
      primaryVariant: colorPrimaryDark,
    ),
    snackBarTheme: const SnackBarThemeData(backgroundColor: colorPrimaryLight),
    iconTheme: const IconThemeData(
      color: colorPrimary,
    ),
    popupMenuTheme: const PopupMenuThemeData(color: paleGrey),
    textTheme: GoogleFonts.aBeeZeeTextTheme(Get.textTheme),
  );

  // —————————————————————————————————————————————————————————————————————————————
  // DARK THEME
  // —————————————————————————————————————————————————————————————————————————————
  static final ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    fontFamily: _fontFamily,
    primaryColor: primaryDarkColor,
    scaffoldBackgroundColor: darkBackgroundColor,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryDarkColor,
    ),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      color: primaryDarkColor,
      iconTheme: IconThemeData(color: iconColorDark),
    ),
    colorScheme: const ColorScheme.dark(
      primary: primaryDarkColor,
      primaryVariant: colorPrimaryDark,
    ),
    snackBarTheme: const SnackBarThemeData(backgroundColor: darkBackgroundColor),
    iconTheme: const IconThemeData(
      color: iconColorDark,
    ),
    popupMenuTheme: const PopupMenuThemeData(color: darkBackgroundColor),
    textTheme: _darkTextTheme,
  );

  /// LIGHT THEME
  static ThemeData theme() {
    return _lightTheme;
  }

  /// DARK THEME
  static ThemeData darktheme() {
    return _darkTheme;
  }

  ThemeMode init() {
    final String? tm = pref.read(_sThemeModeKey);
    if (tm == null) {
      pref.write(_sThemeModeKey, _sThemeModeLight);
      return ThemeMode.light;
    } else if (tm == _sThemeModeLight) {
      return ThemeMode.light;
    } else {
      return ThemeMode.dark;
    }
  }

  void changeThemeMode(ThemeMode themeMode) {
    if (themeMode == ThemeMode.dark) {
      pref.write(_sThemeModeKey, _sThemeModeDark);
    } else {
      pref.write(_sThemeModeKey, _sThemeModeLight);
    }
    Get.changeThemeMode(themeMode);
    Get.rootController.themeMode.reactive;
  }

  ///
  /// [ThemeData] general.
  ///
  /// [Example] :
  ///
  /// Text("Hello, world",
  ///   style: AppThemes().general().textTheme.bodyText1,
  /// )
  ///
  /// This [Function] is useful for styling widgets.
  ///
  /// [Function] AppThemes().general().*
  /// has several derivative functions.
  ThemeData general() {
    final String? tm = pref.read(_sThemeModeKey);
    if (tm == _sThemeModeLight) {
      return _lightTheme;
    }
    return _darkTheme;
  }
}
