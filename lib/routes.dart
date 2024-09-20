import 'package:gefest/presentation/screens/dashboard/dashboard.dart';
import 'package:gefest/presentation/screens/login/login.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final router = GoRouter(
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
    GoRoute(
      path: '/dashboard',
      builder: (context, state) {
        return const DashBoardScreen();
      },
    ),
  ],
);
