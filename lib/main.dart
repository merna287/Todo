import 'package:flutter/material.dart';
import 'package:todo/core/routing/app_router.dart';
import 'package:todo/features/onboarding/presentation/screens/onboarding_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter UpTodo',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.onboarding,
      routes: {
        AppRoutes.onboarding: (context) => const OnboardingScreen(),
        ...AppRoutes.routes,
      },
    );
  }
}
