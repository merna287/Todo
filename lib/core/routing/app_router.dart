import 'package:flutter/material.dart';
import 'package:todo/features/onboarding/presentation/screens/intro_screen.dart';

class AppRoutes {
  static const onboarding = "/";
  static const intro = "/intro";
  static const login = "/login";
  static const register = "/register";
  static const home = "/home";
  static const profile = "/profile";

  static Map<String, WidgetBuilder> routes = {
    intro: (context) => const IntroScreen(),
  };
}
