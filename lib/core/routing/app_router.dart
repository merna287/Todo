import 'package:flutter/material.dart';
import 'package:todo/core/common/screen/main_layout.dart';
import 'package:todo/features/Profile/views/profile_placeholder_screen.dart';
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
  static const appSettings = "/app-settings";
  static const changeAccountName = "/change-account-name";
  static const changePassword = "/change-password";
  static const changeAccountImage = "/change-account-image";
  static const aboutUs = "/about-us";
  static const faq = "/faq";
  static const helpFeedback = "/help-feedback";
  static const supportUs = "/support-us";

  static Map<String, WidgetBuilder> routes = {
    onboarding: (context) => const OnboardingScreen(),
    intro: (context) => const IntroScreen(),
    login: (context) => const LoginScreen(),
    register: (context) => const RegisterScreen(),
    main: (context) => const MainLayout(),
    appSettings: (context) => const ProfilePlaceholderScreen(title: 'App Settings'),
    changeAccountName: (context) => const ProfilePlaceholderScreen(title: 'Change Account Name'),
    changePassword: (context) => const ProfilePlaceholderScreen(title: 'Change Password'),
    changeAccountImage: (context) => const ProfilePlaceholderScreen(title: 'Change Account Image'),
    aboutUs: (context) => const ProfilePlaceholderScreen(title: 'About Us'),
    faq: (context) => const ProfilePlaceholderScreen(title: 'FAQ'),
    helpFeedback: (context) => const ProfilePlaceholderScreen(title: 'Help & Feedback'),
    supportUs: (context) => const ProfilePlaceholderScreen(title: 'Support Us'),
  };
}

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final builder = AppRoutes.routes[settings.name];
    if (builder != null) {
      return MaterialPageRoute(
        settings: settings,
        builder: builder,
      );
    }

    return MaterialPageRoute(
      settings: settings,
      builder: (context) => const Scaffold(
        body: Center(
          child: Text('Route not found'),
        ),
      ),
    );
  }
}
