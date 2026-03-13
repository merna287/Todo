import 'package:flutter/material.dart';
import 'package:todo/core/routing/app_router.dart';
import 'package:provider/provider.dart';
import 'features/auth/presentation/view_model/auth_view_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthViewModel(),
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
