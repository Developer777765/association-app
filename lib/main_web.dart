// ignore_for_file: prefer_const_constructors
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:temple_app/services/appsThemeMode.dart';
import 'package:temple_app/utils/preference.dart';
import 'package:temple_app/utils/providerLogger.dart';
import 'common_widget/app_localization.dart';
import 'package:easy_localization/easy_localization.dart';
import 'mobile/presentaion/splash/splash_screen.dart';
import 'web/presentation/login_web/login_screen_web.dart';

final localeProvider = StateProvider<Locale>((ref) => const Locale('en', 'US'));

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  // await Hive.initFlutter();
  final sharedPref = await SharedPreferences.getInstance();
  await Preference.init();
  runApp(ProviderScope(
    observers: const [ProviderLogger()],
    overrides: [sharedPreferencesProvider.overrideWithValue(sharedPref)],
    child: EasyLocalization(
      path: "assets/translations",
      supportedLocales: const [
        Locale("en", "US"),
        Locale("fr", "FR"),
        Locale("ta", "IN")
      ],
      child: const MyAppWeb(),
    ),
  ));
}

class MyAppWeb extends ConsumerWidget {
  const MyAppWeb({super.key});

  static const Map<AppLang, Locale> _localeMap = {
    AppLang.english: Locale('en', 'US'),
    AppLang.tamil: Locale('ta', 'IN'),
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(appLanguageProvider, (previous, next) {
      context.setLocale(MyAppWeb._localeMap[next]!);
      _rebuildAllChildren(context);
    });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreenWeb(),
      title: 'TempleApp',
      theme: ThemeData(
        textSelectionTheme:
            TextSelectionThemeData(selectionHandleColor: Colors.transparent),
        useMaterial3: true,
      ),
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown
        },
      ),
      locale: context.locale,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
    );
  }

  void _rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }
}
