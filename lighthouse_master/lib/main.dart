import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme/app_theme.dart';
import 'router.dart';
import 'presentation/providers/theme_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      child: AppyApp(),
    ),
  );
}

class AppyApp extends ConsumerWidget {
  const AppyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    
    return MaterialApp.router(
      title: "'appy app",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.glassTheme, // Light Mode
      darkTheme: AppTheme.glassThemeDark, // Dark Mode
      themeMode: themeMode, // Controlled by Provider
      routerConfig: appRouter,
    );
  }
}
