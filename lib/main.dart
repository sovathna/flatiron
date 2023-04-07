import 'dart:io';

import 'package:flatiron/home_widget.dart';
import 'package:flatiron/login/login_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'color_schemes.g.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

void main() async {
  if (!kIsWeb && Platform.isAndroid) {
    WidgetsFlutterBinding.ensureInitialized();
    await FlutterDisplayMode.setHighRefreshRate();
  }
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
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
      themeMode: ThemeMode.light,
      home: const LoginWidget(),
    );
  }
}
