import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4287646528),
      surfaceTint: Color(4287646528),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4294957780),
      onPrimaryContainer: Color(4281993477),
      secondary: Color(4285750284),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4294959243),
      onSecondaryContainer: Color(4280556032),
      tertiary: Color(4286011915),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4294959004),
      onTertiaryContainer: Color(4280621568),
      error: Color(4290386458),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4282449922),
      surface: Color(4294965494),
      onSurface: Color(4280490264),
      onSurfaceVariant: Color(4283646785),
      outline: Color(4286935920),
      outlineVariant: Color(4292395710),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281937452),
      inversePrimary: Color(4294948008),
      primaryFixed: Color(4294957780),
      onPrimaryFixed: Color(4281993477),
      primaryFixedDim: Color(4294948008),
      onPrimaryFixedVariant: Color(4285740074),
      secondaryFixed: Color(4294959243),
      onSecondaryFixed: Color(4280556032),
      secondaryFixedDim: Color(4293117037),
      onSecondaryFixedVariant: Color(4283974656),
      tertiaryFixed: Color(4294959004),
      onTertiaryFixed: Color(4280621568),
      tertiaryFixedDim: Color(4293444204),
      onTertiaryFixedVariant: Color(4284171008),
      surfaceDim: Color(4293449427),
      surfaceBright: Color(4294965494),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294963438),
      surfaceContainer: Color(4294765287),
      surfaceContainerHigh: Color(4294436065),
      surfaceContainerHighest: Color(4294041564),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4285411367),
      surfaceTint: Color(4287646528),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4289355860),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4283646208),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4287328803),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4283842304),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4287590435),
      onTertiaryContainer: Color(4294967295),
      error: Color(4287365129),
      onError: Color(4294967295),
      errorContainer: Color(4292490286),
      onErrorContainer: Color(4294967295),
      surface: Color(4294965494),
      onSurface: Color(4280490264),
      onSurfaceVariant: Color(4283383613),
      outline: Color(4285291352),
      outlineVariant: Color(4287199092),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281937452),
      inversePrimary: Color(4294948008),
      primaryFixed: Color(4289355860),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4287449150),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4287328803),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4285552905),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4287590435),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4285814792),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4293449427),
      surfaceBright: Color(4294965494),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294963438),
      surfaceContainer: Color(4294765287),
      surfaceContainerHigh: Color(4294436065),
      surfaceContainerHighest: Color(4294041564),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4282650634),
      surfaceTint: Color(4287646528),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4285411367),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4281082112),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4283646208),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4281212928),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4283842304),
      onTertiaryContainer: Color(4294967295),
      error: Color(4283301890),
      onError: Color(4294967295),
      errorContainer: Color(4287365129),
      onErrorContainer: Color(4294967295),
      surface: Color(4294965494),
      onSurface: Color(4278190080),
      onSurfaceVariant: Color(4281213215),
      outline: Color(4283383613),
      outlineVariant: Color(4283383613),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281937452),
      inversePrimary: Color(4294961123),
      primaryFixed: Color(4285411367),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4283570963),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4283646208),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4281871104),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4283842304),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4282067456),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4293449427),
      surfaceBright: Color(4294965494),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294963438),
      surfaceContainer: Color(4294765287),
      surfaceContainerHigh: Color(4294436065),
      surfaceContainerHighest: Color(4294041564),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4294948008),
      surfaceTint: Color(4294948008),
      onPrimary: Color(4283833878),
      primaryContainer: Color(4285740074),
      onPrimaryContainer: Color(4294957780),
      secondary: Color(4293117037),
      onSecondary: Color(4282199808),
      secondaryContainer: Color(4283974656),
      onSecondaryContainer: Color(4294959243),
      tertiary: Color(4293444204),
      onTertiary: Color(4282330624),
      tertiaryContainer: Color(4284171008),
      onTertiaryContainer: Color(4294959004),
      error: Color(4294948011),
      onError: Color(4285071365),
      errorContainer: Color(4287823882),
      onErrorContainer: Color(4294957782),
      surface: Color(4279898384),
      onSurface: Color(4294041564),
      onSurfaceVariant: Color(4292395710),
      outline: Color(4288711817),
      outlineVariant: Color(4283646785),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4294041564),
      inversePrimary: Color(4287646528),
      primaryFixed: Color(4294957780),
      onPrimaryFixed: Color(4281993477),
      primaryFixedDim: Color(4294948008),
      onPrimaryFixedVariant: Color(4285740074),
      secondaryFixed: Color(4294959243),
      onSecondaryFixed: Color(4280556032),
      secondaryFixedDim: Color(4293117037),
      onSecondaryFixedVariant: Color(4283974656),
      tertiaryFixed: Color(4294959004),
      onTertiaryFixed: Color(4280621568),
      tertiaryFixedDim: Color(4293444204),
      onTertiaryFixedVariant: Color(4284171008),
      surfaceDim: Color(4279898384),
      surfaceBright: Color(4282529589),
      surfaceContainerLowest: Color(4279503883),
      surfaceContainerLow: Color(4280490264),
      surfaceContainer: Color(4280753436),
      surfaceContainerHigh: Color(4281477158),
      surfaceContainerHighest: Color(4282200624),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4294949551),
      surfaceTint: Color(4294948008),
      onPrimary: Color(4281533698),
      primaryContainer: Color(4291591023),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4293380208),
      onSecondary: Color(4280096000),
      secondaryContainer: Color(4289302077),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4293772912),
      onTertiary: Color(4280227072),
      tertiaryContainer: Color(4289629245),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294949553),
      onError: Color(4281794561),
      errorContainer: Color(4294923337),
      onErrorContainer: Color(4278190080),
      surface: Color(4279898384),
      onSurface: Color(4294965752),
      onSurfaceVariant: Color(4292658882),
      outline: Color(4289961627),
      outlineVariant: Color(4287790972),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4294041564),
      inversePrimary: Color(4285805868),
      primaryFixed: Color(4294957780),
      onPrimaryFixed: Color(4281073921),
      primaryFixedDim: Color(4294948008),
      onPrimaryFixedVariant: Color(4284359708),
      secondaryFixed: Color(4294959243),
      onSecondaryFixed: Color(4279701504),
      secondaryFixedDim: Color(4293117037),
      onSecondaryFixedVariant: Color(4282659840),
      tertiaryFixed: Color(4294959004),
      onTertiaryFixed: Color(4279767040),
      tertiaryFixedDim: Color(4293444204),
      onTertiaryFixedVariant: Color(4282790656),
      surfaceDim: Color(4279898384),
      surfaceBright: Color(4282529589),
      surfaceContainerLowest: Color(4279503883),
      surfaceContainerLow: Color(4280490264),
      surfaceContainer: Color(4280753436),
      surfaceContainerHigh: Color(4281477158),
      surfaceContainerHighest: Color(4282200624),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4294965752),
      surfaceTint: Color(4294948008),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4294949551),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294966006),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4293380208),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4294966007),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4293772912),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965753),
      onError: Color(4278190080),
      errorContainer: Color(4294949553),
      onErrorContainer: Color(4278190080),
      surface: Color(4279898384),
      onSurface: Color(4294967295),
      onSurfaceVariant: Color(4294965752),
      outline: Color(4292658882),
      outlineVariant: Color(4292658882),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4294041564),
      inversePrimary: Color(4283308049),
      primaryFixed: Color(4294959323),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4294949551),
      onPrimaryFixedVariant: Color(4281533698),
      secondaryFixed: Color(4294960544),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4293380208),
      onSecondaryFixedVariant: Color(4280096000),
      tertiaryFixed: Color(4294960302),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4293772912),
      onTertiaryFixedVariant: Color(4280227072),
      surfaceDim: Color(4279898384),
      surfaceBright: Color(4282529589),
      surfaceContainerLowest: Color(4279503883),
      surfaceContainerLow: Color(4280490264),
      surfaceContainer: Color(4280753436),
      surfaceContainerHigh: Color(4281477158),
      surfaceContainerHighest: Color(4282200624),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
