import 'dart:io';

import 'package:flatiron/const.dart';
import 'package:flatiron/data/data_module.dart';
import 'package:flatiron/ui/splash/splash_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'color_schemes.g.dart';

final logger = Logger(
  printer: PrettyPrinter(),
);

final isDarkModeProvider = StateProvider<bool>((ref) {
  final pref = ref.watch(appPreferencesProvider);
  return pref.isDarkmode();
});

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationSupportDirectory();
  await Hive.initFlutter(dir.path);
  await Hive.openBox(appBox);
  if (!kIsWeb && Platform.isAndroid) {
    await FlutterDisplayMode.setHighRefreshRate();
  }
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        fontFamily: "Product Sans",
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
        fontFamily: "Product Sans",
      ),
      themeMode:
          ref.watch(isDarkModeProvider) ? ThemeMode.dark : ThemeMode.light,
      home: const SplashWidget(),
    );
  }
}
