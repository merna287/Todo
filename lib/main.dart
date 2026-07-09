import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/core/routing/app_router.dart';
import 'package:todo/core/services/auth_service.dart';
import 'package:todo/core/services/connectivity_service.dart';
import 'package:todo/core/services/sync_service.dart';
import 'package:todo/features/profile/model_view/profile_view_model.dart';
import 'package:todo/features/auth/presentation/view_model/auth_view_model.dart';
import 'package:todo/features/focus/presentation/view_model/focus_view_model.dart';
import 'package:todo/features/home/presentation/api/task_api.dart';
import 'package:todo/features/home/presentation/model/task_model.dart';
import 'package:todo/features/home/presentation/repository/task_repository.dart';
import 'package:todo/features/home/presentation/view_model/task_view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  await Hive.openBox<TaskModel>('tasks');

  final profileViewModel = ProfileViewModel();
  final connectivityService = ConnectivityService();
  final taskRepository = TaskRepository(
    api: TaskApi(),
    box: Hive.box<TaskModel>('tasks'),
    connectivityService: connectivityService,
  );
  final taskViewModel = TaskViewModel(repository: taskRepository);
  final syncService = SyncService(
    repository: taskRepository,
    connectivityService: connectivityService,
  );
  final hasValidToken = await AuthService.instance.hasValidToken();

  if (hasValidToken) {
  await profileViewModel.loadCachedProfile();
  profileViewModel.fetchProfile();
  await taskViewModel.initialize();
  } else {
    await taskViewModel.fetchTasks();
  }

  await syncService.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => taskViewModel),
        ChangeNotifierProvider(create: (_) => profileViewModel),
        ChangeNotifierProvider(create: (_) => FocusViewModel()),
        ChangeNotifierProvider(create: (_) => connectivityService),
        Provider.value(value: syncService),
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
