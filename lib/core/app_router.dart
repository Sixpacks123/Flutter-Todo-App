import 'package:flutter/material.dart';
import 'package:todo_list_app/features/tasks/presentations/widgets/AddTaskBottomSheet.dart';
import '../features/tasks/presentations/pages/home_page.dart';

class AppRoutes {
  static const String home = '/';
  static const String addTask = '/addTask';
}

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case AppRoutes.addTask:
        return MaterialPageRoute(builder: (_) => const AddTaskBottomSheet());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Page non trouvée')),
          ),
        );
    }
  }
}
