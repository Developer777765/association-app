import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:temple_app/web/presentation/login_web/login_screen_web.dart';
import '../presentation/dashboard_web/dashboard_web.dart';
import '../presentation/dashboard_web/dashoard_web_menu.dart';
import '../presentation/signup_web/signup_web.dart';
import 'route_enums_web.dart';
part 'router_web.g.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter router(RouterRef ref) {
  return GoRouter(
      navigatorKey: _rootNavigatorKey,
      debugLogDiagnostics: true,
      initialLocation: '/loginWeb',
      routes: [
        GoRoute(
            path: '/loginWeb',
            name: Routes.loginWeb.name,
            builder: (context, state) => const LoginScreenWeb()),
   
        GoRoute(
            path: '/signupWeb',
            name: Routes.signupWeb.name,
            builder: (context, state) => const SignupWeb()),
        GoRoute(
            path: '/dashoardWebMenu',
            name: Routes.dashoardWebMenu.name,
            builder: (context, state) => DashoardWebMenu()),
        GoRoute(
            path: '/dashboardWeb',
            name: Routes.dashboardWeb.name,
            builder: (context, state) => const DashboardWeb()),
      ]);
}
