import 'package:flutter/material.dart';
import 'package:todo/core/common/screen/main_layout.dart';
import 'package:todo/features/auth/presentation/view/login_screen.dart';
import 'package:todo/features/auth/presentation/view/register_screen.dart'; 
import 'package:todo/features/onboarding/presentation/screens/intro_screen.dart';
import 'package:todo/features/onboarding/presentation/screens/onboarding_screen.dart';

class AppRoutes {
  static const onboarding = "/";
  static const intro = "/intro";
  static const login = "/login";
  static const register = "/register";
  static const main = "/main";
  static const home = "/home";
  static const details = "/details";
  static const profile = "/profile";

  static Map<String, WidgetBuilder> routes = {
    onboarding: (context) => const OnboardingScreen(),
    intro: (context) => const IntroScreen(),
    login: (context) => const LoginScreen(),
    register: (context) => const RegisterScreen(), 
    main: (context) => const MainLayout(),
  };
}
