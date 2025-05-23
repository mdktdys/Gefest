import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:chopper/chopper.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:gefest/core/api/data/schedule/repository/test.dart';
import 'package:gefest/core/api/models/DTO/containers.dart';
import 'package:gefest/core/api/models/department_model.dart';
import 'package:gefest/presentation/shared/providers/theme_provider.dart';
import 'package:gefest/routes.dart';
import 'package:gefest/secrets.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final chopper = ChopperClient(
    converter: JsonSerializableConverter({
      DockerInfo: DockerInfo.fromJson,
      Department: Department.fromJson
    }),
    interceptors: [MyRequestInterceptor(),HttpLoggingInterceptor(),],
      baseUrl: Uri.parse(API_URL),
      services: [
        FastApiService.create()
      ],
    );

  GetIt.I.registerSingleton<ChopperClient>(chopper);
  
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
      ? HydratedStorage.webStorageDirectory
      : await getApplicationDocumentsDirectory(),
  );

  usePathUrlStrategy();

  final supabase = await Supabase.initialize(url: SUPABASE_URL, anonKey: SUPABASE_ANON_KEY);
  GetIt.I.registerSingleton<Supabase>(supabase);

  final talker = TalkerFlutter.init();
  GetIt.I.registerSingleton<Talker>(talker);

  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  GetIt.I.registerSingleton<PackageInfo>(packageInfo);

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  GetIt.I.registerSingleton<SharedPreferences>(prefs);

  runApp(const ProviderScope(
    child: Portal(
      child: ThemeApp()
  )));
}

class ThemeApp extends ConsumerWidget {
  const ThemeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeSettings themeProvider = ref.watch(lightThemeProvider);
    final Brightness brightness = themeProvider.brightness;
    final ThemeData? theme = themeProvider.theme;

    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        systemNavigationBarIconBrightness: brightness,
        statusBarIconBrightness: brightness,
        statusBarColor: theme?.canvasColor,
      ),
      child: MaterialApp.router(
        title: "Dev Замены уксивтика",
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        theme: themeProvider.theme,
        themeMode: themeProvider.themeMode,
      ),
    );
  }
}
