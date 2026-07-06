import 'package:flutter/material.dart';
import 'package:todo/core/routing/app_router.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/services/auth_service.dart';
import 'package:todo/features/Profile/model_view/profile_view_model.dart';
import 'package:todo/features/home/presentation/api/task_api.dart';
import 'package:todo/features/focus/presentation/view_model/focus_view_model.dart';
import 'package:todo/features/home/presentation/view_model/task_view_model.dart';
import 'package:todo/features/auth/presentation/view_model/auth_view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final profileViewModel = ProfileViewModel();
  final taskViewModel = TaskViewModel(api: TaskApi());
  final hasValidToken = await AuthService.instance.hasValidToken();

  if (hasValidToken) {
    await profileViewModel.fetchProfile();
    await taskViewModel.fetchTasks();
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => taskViewModel),
        ChangeNotifierProvider(create: (_) => profileViewModel),
        ChangeNotifierProvider(create: (_) => FocusViewModel()),
      ],
      child: MyApp(
        initialRoute: hasValidToken ? AppRoutes.main : AppRoutes.login,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.initialRoute});

  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter UpTodo',
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      routes: AppRoutes.routes,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
