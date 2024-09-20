import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gefest/routes.dart';
import 'package:gefest/secrets.dart';
import 'package:gefest/theme.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';

final globalAppKey = GlobalKey<ScaffoldMessengerState>();

void main() async {
  final supabase =
      await Supabase.initialize(url: SUPABASE_URL, anonKey: SUPABASE_ANON_KEY);
  GetIt.I.registerSingleton<Supabase>(supabase);

  final talker = TalkerFlutter.init();
  GetIt.I.registerSingleton<Talker>(talker);

  runApp(ProviderScope(
    child: MaterialApp.router(
        key: globalAppKey,
        routerConfig: router,
        color: Colors.blue,
        debugShowCheckedModeBanner: false,
        theme: darkTheme),
  ));
}
