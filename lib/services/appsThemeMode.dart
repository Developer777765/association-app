import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:temple_app/core/color_pallet/theme.dart';

final appThemeProvider = Provider<AppTheme>((ref) {
  return AppTheme();
});

class AppTheme {
  static ThemeData lightMode = ThemeData(
    colorScheme: MaterialTheme.lightColor,
    appBarTheme: AppBarTheme(
      backgroundColor: MaterialTheme.lightColor.primary,
      foregroundColor: MaterialTheme.lightColor.onPrimary,
      elevation: 4,
      shadowColor: MaterialTheme.lightColor.shadow,
      titleTextStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      iconTheme: IconThemeData(
        color: MaterialTheme.lightColor.onPrimary,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: MaterialTheme.lightColor.primary,
        foregroundColor: MaterialTheme.lightColor.onPrimary,
        shadowColor: MaterialTheme.lightColor.shadow,
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: MaterialTheme.lightColor.primary,
        side: BorderSide(color: MaterialTheme.lightColor.outline),
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: MaterialTheme.lightColor.primary,
      ),
    ),
    cardTheme: CardTheme(
      color: MaterialTheme.lightColor.surface,
      shadowColor: MaterialTheme.lightColor.shadow,
      margin: const EdgeInsets.all(8.0),
      elevation: 4,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return MaterialTheme.lightColor.primary;
        }
        return MaterialTheme.lightColor.onSurface;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return MaterialTheme.lightColor.primary.withOpacity(0.5);
        }
        return MaterialTheme.lightColor.onSurface.withOpacity(0.5);
      }),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return MaterialTheme.lightColor.primary;
        }
        return MaterialTheme.lightColor.onSurfaceVariant;
      }),
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      menuStyle: MenuStyle(
        backgroundColor:
            WidgetStateProperty.all(MaterialTheme.lightColor.surface),
      ),
      // textStyle: WidgetStateProperty.all(
      //   TextStyle(color: MaterialTheme.darkColor.onSurface),
      // ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return MaterialTheme.lightColor.primary;
        }
        return MaterialTheme.lightColor.onSurfaceVariant;
      }),
      checkColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return MaterialTheme.lightColor.onPrimary;
        }
        return null;
      }),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: MaterialTheme.lightColor.primary,
      foregroundColor: MaterialTheme.lightColor.onPrimary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: MaterialTheme.lightColor.surface,
      filled: true,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: MaterialTheme.lightColor.primary),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: MaterialTheme.lightColor.outline),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: MaterialTheme.lightColor.error),
      ),
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: MaterialTheme.lightColor.primary,
      inactiveTrackColor:
          MaterialTheme.lightColor.onSurfaceVariant.withOpacity(0.5),
      thumbColor: MaterialTheme.lightColor.primary,
    ),
  );
  static ThemeData darkMode = ThemeData(
    colorScheme: MaterialTheme.darkColor,
    appBarTheme: AppBarTheme(
      backgroundColor: MaterialTheme.darkColor.primary,
      foregroundColor: MaterialTheme.darkColor.onPrimary,
      elevation: 4,
      shadowColor: MaterialTheme.darkColor.shadow,
      titleTextStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      iconTheme: IconThemeData(
        color: MaterialTheme.darkColor.onPrimary,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: MaterialTheme.darkColor.primary,
        foregroundColor: MaterialTheme.darkColor.onPrimary,
        shadowColor: MaterialTheme.darkColor.shadow,
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: MaterialTheme.darkColor.primary,
        side: BorderSide(color: MaterialTheme.darkColor.outline),
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: MaterialTheme.darkColor.primary,
      ),
    ),
    cardTheme: CardTheme(
      color: MaterialTheme.darkColor.surface,
      shadowColor: MaterialTheme.darkColor.shadow,
      margin: const EdgeInsets.all(8.0),
      elevation: 4,
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return MaterialTheme.darkColor.primary;
        }
        return MaterialTheme.darkColor.onSurface;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return MaterialTheme.darkColor.primary.withOpacity(0.5);
        }
        return MaterialTheme.darkColor.onSurface.withOpacity(0.5);
      }),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return MaterialTheme.darkColor.primary;
        }
        return MaterialTheme.darkColor.onSurfaceVariant;
      }),
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      menuStyle: MenuStyle(
        backgroundColor:
            WidgetStateProperty.all(MaterialTheme.darkColor.surface),
      ),
      // textStyle: WidgetStateProperty.all(
      //   TextStyle(color: MaterialTheme.darkColor.onSurface),
      // ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return MaterialTheme.darkColor.primary;
        }
        return MaterialTheme.darkColor.onSurfaceVariant;
      }),
      checkColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return MaterialTheme.darkColor.onPrimary;
        }
        return null;
      }),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: MaterialTheme.darkColor.primary,
      foregroundColor: MaterialTheme.darkColor.onPrimary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: MaterialTheme.darkColor.surface,
      filled: true,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: MaterialTheme.darkColor.primary),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: MaterialTheme.darkColor.outline),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: MaterialTheme.darkColor.error),
      ),
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: MaterialTheme.darkColor.primary,
      inactiveTrackColor:
          MaterialTheme.darkColor.onSurfaceVariant.withOpacity(0.5),
      thumbColor: MaterialTheme.darkColor.primary,
    ),
  );

  ThemeData getAppTheme(BuildContext context, bool isDarkModeEnabled) {
    return isDarkModeEnabled ? darkMode : lightMode;
  }
}

final appThemeStateProvider =
    StateNotifierProvider<AppThemeNotifier, bool>((ref) {
  final isItDarkMode = ref.read(sharedUtilityProvider).isDarkModeEnabled();
  return AppThemeNotifier(isItDarkMode);
});

class AppThemeNotifier extends StateNotifier<bool> {
  bool defaultDarkModeValue;
  AppThemeNotifier(this.defaultDarkModeValue) : super(defaultDarkModeValue);

  toggleAppTheme(WidgetRef ref) {
    final isDarkModeEnabled =
        ref.read(sharedUtilityProvider).isDarkModeEnabled();
    final toggleValue = !isDarkModeEnabled;
    ref.read(sharedUtilityProvider).setAppsTheme(toggleValue).whenComplete(() {
      state = toggleValue;
    });
  }
}

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  return throw UnimplementedError();
});

final sharedUtilityProvider = Provider<SharedUtility>((ref) {
  final sharedPrefs = ref.watch(sharedPreferencesProvider);
  return SharedUtility(sharedPrefs);
});

class SharedUtility {
  final SharedPreferences sharedPreferences;
  SharedUtility(this.sharedPreferences);

  bool isDarkModeEnabled() {
    return sharedPreferences.getBool('isDarkModeEnabled') ?? false;
  }

  Future<bool> setAppsTheme(bool value) async {
    return await sharedPreferences.setBool('isDarkModeEnabled', value);
  }
}


/*
onTap: () {
                  ref.read(appThemeStateProvider.notifier).toggleAppTheme(ref);
                },

                */