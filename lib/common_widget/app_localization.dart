import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'isfirstrun_provider.dart';


part 'app_localization.g.dart';

@Riverpod(keepAlive: true)
class AppLanguage extends _$AppLanguage {
  @override
  AppLang build() {
    final preferedLang =
        ref.watch(sharedPreferencesProvider).getString("appLang");
    if (preferedLang == null || preferedLang == AppLang.english.name) {
      ref
          .read(sharedPreferencesProvider)
          .setString("appLang", AppLang.english.name);
      return AppLang.english;
    } else if (preferedLang == AppLang.tamil.name) {
      return AppLang.tamil;
    } else {
      return AppLang.french;
    }
  }

  void changeLanguage(AppLang appLang) {
    ref.read(sharedPreferencesProvider).setString("appLang", appLang.name);
    state = appLang;
  }
}

enum AppLang {
  english,
  tamil,
  french,
}
