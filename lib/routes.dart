import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:gefest/presentation/screens/course/course_screen.dart';
import 'package:gefest/presentation/screens/dashboard/dashboard.dart';
import 'package:gefest/presentation/screens/groups/groups.dart';
import 'package:gefest/presentation/screens/load/load_screen.dart';
import 'package:gefest/presentation/screens/login/login.dart';
import 'package:gefest/presentation/screens/panel/panel_scaffold.dart';
import 'package:gefest/presentation/screens/schedule/schedule.dart';
import 'package:gefest/presentation/screens/settings/settings_screen.dart';
import 'package:gefest/presentation/screens/teachers/teachers.dart';
import 'package:gefest/presentation/screens/teachers/techer_screen.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/login',
  // onException: (context, state, router) {
  //   context.go('/login');
  // },
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
            pageBuilder: (context, state) {
              return transitionPage(state,DashBoardScreen());
            },
          ),
          GoRoute(
            path: '/schedule',
            pageBuilder: (context, state) {
              return transitionPage(state,ScheduleScreen());
            },
          ),
          GoRoute(
            path: '/teachers',
            pageBuilder: (context, state) {
              return transitionPage(state, TeachersScreen());
            },
          ),
          GoRoute(
            path: '/teacher',
            pageBuilder: (context, state) {
              return transitionPage(state, TeacherScreen(context));
            },
          ),
          GoRoute(
            path: '/groups',
            pageBuilder: (context, state) {
              return transitionPage(state, GroupsScreen());
          },),
          GoRoute(
            path: '/course',
            pageBuilder: (context, state) {
              return transitionPage(state, CourseScreen(context));
          },),
          GoRoute(
            path: '/load',
            pageBuilder: (context, state) {
              return transitionPage(state, LoadScreen(context));
            },
          ),
          GoRoute(
            path: '/settings',
            pageBuilder: (context, state) {
              return transitionPage(state, SettingsScreen(context));
            },
          ),
        ]),
  ],
);


CustomTransitionPage transitionPage(state,page) {
  return CustomTransitionPage(
      key: state.pageKey,
      child: page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity:
              CurveTween(curve: Curves.easeInOutCirc).animate(animation),
          child: child,
        );
      },
    );
}