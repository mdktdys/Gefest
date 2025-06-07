import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:gefest/presentation/screens/cabinets/cabinets_screen.dart';
import 'package:gefest/presentation/screens/course/course_screen.dart';
import 'package:gefest/presentation/screens/dashboard/dashboard.dart';
import 'package:gefest/presentation/screens/group/screens/group_form_screen.dart';
import 'package:gefest/presentation/screens/group/screens/group_screen.dart';
import 'package:gefest/presentation/screens/groups/groups.dart';
import 'package:gefest/presentation/screens/load/load_screen.dart';
import 'package:gefest/presentation/screens/login/login.dart';
import 'package:gefest/presentation/screens/panel/panel_scaffold.dart';
import 'package:gefest/presentation/screens/schedule/schedule.dart';
import 'package:gefest/presentation/screens/settings/settings_screen.dart';
import 'package:gefest/presentation/screens/teachers/teacher_form_screen.dart';
import 'package:gefest/presentation/screens/teachers/teacher_screen.dart';
import 'package:gefest/presentation/screens/teachers/teachers.dart';
import 'package:gefest/theme/custom_transitions.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final List<GoRoute> teacherRoutes = [
  GoRoute(
    path: Routes.teachers,
    pageBuilder: (context, state) => transitionPage(state, TeachersScreen()),
  ),
  GoRoute(
    path: Routes.teacher,
    pageBuilder: (context, state) => transitionPage(state, TeacherScreen(context)),
  ),
  GoRoute(
    path: Routes.newTeacher,
    pageBuilder: (context, state) => transitionPage(state, TeacherFormScreen(context)),
  ),
];

final List<GoRoute> groupRoutes = [
  GoRoute(
    path: Routes.groups,
    pageBuilder: (context, state) => transitionPage(state, GroupsScreen()),
  ),
  GoRoute(
    path: Routes.group,
    pageBuilder: (context, state) => transitionPage(state, GroupScreen(context)),
  ),
  GoRoute(
    path: Routes.newGroup,
    pageBuilder: (context, state) => transitionPage(state, GroupFormScreen(context)),
  ),
];

final List<GoRoute> cabinetRoutes = [
  GoRoute(
    path: Routes.cabinets,
    pageBuilder: (context, state) => transitionPage(state, CabinetsScreen()),
  ),
  // GoRoute(
  //   path: Routes.cabinet,
  //   pageBuilder: (context, state) => transitionPage(state, CabinetScreen(context)),
  // ),
];

final router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: Routes.login,
  onException: (context, state, router) {
    context.go(Routes.login);
  },
  redirect: (context, state) {
    if (GetIt.I.get<Supabase>().client.auth.currentUser == null) {
      return Routes.login;
    } else {
      return null;
    }
  },
  routes: [
    GoRoute(
      path: Routes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => PanelScaffold(child: child),
        routes: [
          ...teacherRoutes,
          ...groupRoutes,
          ...cabinetRoutes,
          GoRoute(
            path: Routes.dashboard,
            pageBuilder: (context, state) {
              return transitionPage(state,DashBoardScreen());
          }),
          GoRoute(
            path: Routes.schedule,
            pageBuilder: (context, state) {
              return transitionPage(state,ScheduleScreen());
          }),
          GoRoute(
            path: Routes.settings,
            pageBuilder: (context, state) {
              return transitionPage(state, SettingsScreen(context));
          }),
          GoRoute(
            path: '/load',
            pageBuilder: (context, state) {
              return transitionPage(state, LoadScreen(context));
          }),
          GoRoute(
            path: Routes.course,
            pageBuilder: (context, state) {
              return transitionPage(state, CourseScreen(context));
          },),
        ]
    )
  ]
);

abstract class Routes {
  // Auth
  static const login = '/login';

  // Dashboard
  static const dashboard = '/dashboard';

  // Teachers
  static const teachers = '/teachers';
  static const teacher = '/teacher';
  static const newTeacher = '/new_teacher';

  // Groups
  static const groups = '/groups';
  static const group = '/group';
  static const newGroup = '/new_group';

  // Cabinets
  static const cabinets = '/cabinets';
  static const cabinet = '/cabinet';
  static const newCabinet = '/new_cabinet';

  // Others
  static const course = '/course';
  static const schedule = '/schedule';
  static const settings = '/settings';
  static const load = '/load';
}


