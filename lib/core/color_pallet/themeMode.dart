import 'package:flutter/material.dart';

class AppsThemeMode {
  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF415f91), //done
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFd6e3ff), //done
    onPrimaryContainer: Color(0xFF001b3e), //done  
    secondary: Color(0xFF565f71), //done
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFdae2f9), //  dae2f9
    onSecondaryContainer: Color(0xFF2C1512),
    tertiary: Color(0xFF6f5575),//done
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFFBDFA6),
    onTertiaryContainer: Color(0xFF251A00),
    error: Color(0xFFba1a1a), //done
    errorContainer: Color(0xFFFFDAD6),
    onError: Color(0xFFFFFFFF),
    onErrorContainer: Color(0xFF410002),
    surface: Color(0xFFFFFBFF),
    onSurface: Color(0xFF201A19),
    surfaceContainerHighest: Color(0xFFF5DDDA),
    onSurfaceVariant: Color(0xFF534341),
    outline: Color(0xFF857370),
    onInverseSurface: Color(0xFFFBEEEC),
    inverseSurface: Color(0xFF362F2E),
    inversePrimary: Color(0xFFFFB4A8),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFFC00001),
    outlineVariant: Color(0xFFD8C2BE),
    scrim: Color(0xFF000000),
  );

  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFFFB4A8),
    onPrimary: Color(0xFF690000),
    primaryContainer: Color(0xFF930000),
    onPrimaryContainer: Color(0xFFFFDAD4),
    secondary: Color(0xFFE7BDB6),
    onSecondary: Color(0xFF442925),
    secondaryContainer: Color(0xFF5D3F3B),
    onSecondaryContainer: Color(0xFFFFDAD4),
    tertiary: Color(0xFFDEC48C),
    onTertiary: Color(0xFF3E2E04),
    tertiaryContainer: Color(0xFF564419),
    onTertiaryContainer: Color(0xFFFBDFA6),
    error: Color(0xFFFFB4AB),
    errorContainer: Color(0xFF93000A),
    onError: Color(0xFF690005),
    onErrorContainer: Color(0xFFFFDAD6),
    surface: Color(0xFF201A19),
    onSurface: Color(0xFFEDE0DD),
    surfaceContainerHighest: Color(0xFF534341),
    onSurfaceVariant: Color(0xFFD8C2BE),
    outline: Color(0xFFA08C89),
    onInverseSurface: Color(0xFF201A19),
    inverseSurface: Color(0xFFEDE0DD),
    inversePrimary: Color(0xFFC00001),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFFFFB4A8),
    outlineVariant: Color(0xFF534341),
    scrim: Color(0xFF000000),
  );

  // static var lightMode = ThemeData.dark();
   static var lightMode = ThemeData(colorScheme: lightColorScheme);
  static var darkMode = ThemeData(colorScheme: darkColorScheme);
}
