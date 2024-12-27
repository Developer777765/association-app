import 'package:flutter_riverpod/flutter_riverpod.dart';

final appsThemeProvider = StateProvider<ThemeMode>((ref) {
  return ThemeMode();
});

enum SelectedThemeOfApp {
  darkMode,
  lightMode;
}

class ThemeMode {
  SelectedThemeOfApp? newTheme;
  switchToLightMode() {
    newTheme = SelectedThemeOfApp.lightMode;
  }

  switchToDarkMode() {
    newTheme = SelectedThemeOfApp.darkMode;
  }
}
