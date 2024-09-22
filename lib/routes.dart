import 'package:flutter/material.dart';
import 'package:gefest/presentation/screens/dashboard/dashboard.dart';
import 'package:gefest/presentation/screens/login/login.dart';
import 'package:gefest/presentation/screens/panel/panel_scaffold.dart';
import 'package:gefest/presentation/screens/schedule/schedule.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/login',
  redirect: (context, state) {
    if (GetIt.I.get<Supabase>().client.auth.currentUser == null) {
      return '/login';
    } else {
      return null;
    }
  },
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => PanelScaffold(child: child),
        routes: [
          GoRoute(
            path: '/dashboard',
            builder: (context, state) {
              return const DashBoardScreen();
            },
          ),
          GoRoute(
            path: '/schedule',
            builder: (context, state) {
              return const ScheduleScreen();
            },
          ),
        ]),
  ],
);
