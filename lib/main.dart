import 'package:flutter/material.dart';
import 'package:todo/core/routing/app_router.dart';
import 'package:provider/provider.dart';
import 'package:todo/features/home/presentation/api/task_api.dart';
import 'package:todo/features/home/presentation/view_model/task_view_model.dart';
import 'features/auth/presentation/view_model/auth_view_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => TaskViewModel(api: TaskApi()),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter UpTodo',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.onboarding,
      routes: AppRoutes.routes,
    );
  }
}
