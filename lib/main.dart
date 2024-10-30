// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'config/theme/app_theme.dart';
import 'core/app_router.dart';
import 'features/tasks/presentations/pages/home_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ma ToDo List',
      theme: AppTheme().getAppTheme(),
      initialRoute: AppRoutes.home,
      onGenerateRoute: AppRouter.generateRoute,
      home: const HomePage(),
    );

  }
}
