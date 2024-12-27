// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:temple_app/core/color_pallet/theme.dart';
import 'package:temple_app/data/data_sourse/hive/adapter_of_hive.dart';
import 'package:temple_app/data/data_sourse/hive/profile_adapter.dart';
import 'package:temple_app/mobile/presentaion/signUpUser/bulk_upload.dart';
import 'package:temple_app/mobile/presentaion/successScreen/state_of_screen.dart';

import 'package:temple_app/services/appsThemeMode.dart';
import 'package:temple_app/utils/preference.dart';
import 'package:temple_app/utils/providerLogger.dart';
import 'common_widget/app_localization.dart';
import 'package:easy_localization/easy_localization.dart';

import 'mobile/presentaion/dashboard/tabbar_widget.dart';
import 'mobile/presentaion/login/login_screen.dart';
import 'mobile/presentaion/login/verify_otp.dart';
import 'mobile/presentaion/signUpUser/signUpUser.dart';
import 'mobile/presentaion/splash/splash_screen.dart';

final localeProvider = StateProvider<Locale>((ref) => const Locale('en', 'US'));

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  try {
    await Hive.initFlutter(); // Initialize Hive
    Hive.registerAdapter(UserProfileAdapter());
    await Hive.openBox<UserProfile>('UserProfileBox');
  } catch (ex) {
    debugPrint('exception with using Hive: $ex');
  }

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
      child: const MyApp(),
    ),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  static const Map<AppLang, Locale> _localeMap = {
    AppLang.english: Locale('en', 'US'),
    AppLang.tamil: Locale('ta', 'IN'),
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(appLanguageProvider, (previous, next) {
      context.setLocale(MyApp._localeMap[next]!);
      _rebuildAllChildren(context);
    });
      
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      title: 'TempleApp',
      theme: ThemeData(
        colorScheme: MaterialTheme.lightColor,
        useMaterial3: true,
      ),
      locale: context.locale,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      routes: {
        'SignUp': (context) {
          return SignUp();
        },
        'HomeScreen': (context) {
          return TabbarWidget();
        },
        'LogIn': (context) {
          return LoginScreen();
        },
        'VerifyOtp': (context) {
          return VerifyOTP();
        },
        'BulkUpload': (context) {
          return MultipleRegisteration();
        },
        'StateOfScreen': (context) {
          return StateOfScreen();
        }
      },
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
