import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gefest/routes.dart';
import 'package:gefest/secrets.dart';
import 'package:gefest/theme.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:package_info_plus/package_info_plus.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  usePathUrlStrategy();

  final supabase =
      await Supabase.initialize(url: SUPABASE_URL, anonKey: SUPABASE_ANON_KEY);
  GetIt.I.registerSingleton<Supabase>(supabase);

  final talker = TalkerFlutter.init();
  GetIt.I.registerSingleton<Talker>(talker);

  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  GetIt.I.registerSingleton<PackageInfo>(packageInfo);

  runApp(ProviderScope(
    child: Portal(
      child: MaterialApp.router(
          title: "Dev Замены уксивтика",
          routerConfig: router,
          color: Colors.blue,
          debugShowCheckedModeBanner: false,
          theme: darkTheme),
    ),
  ));
}
