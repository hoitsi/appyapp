import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme/app_theme.dart';
import 'router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      child: LighthouseApp(),
    ),
  );
}

class LighthouseApp extends StatelessWidget {
  const LighthouseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "'appy app",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: appRouter,
    );
  }
}
