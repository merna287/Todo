import 'package:flutter/material.dart'; 
import 'package:provider/provider.dart';
import 'package:todo/features/home/presentation/view_model/task_view_model.dart';
import 'package:todo/features/home/presentation/widgets/search_widget.dart';
import 'package:todo/features/home/presentation/widgets/show_tasks.dart';
import 'package:todo/features/home/presentation/widgets/task_item_widget.dart';
import 'package:todo/features/home/presentation/widgets/empty_home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskViewModel>(
      builder: (context, vm, _) {
        final filteredTasks = vm.filteredTasks;
        final allTasks = vm.tasks;

        if (allTasks.isEmpty) {
          return const EmptyHome();
        }

        return Column(
          children: [
            SearchWidget(
              controller: searchController,
              onChanged: (value) => vm.search(value),
            ),

            Expanded(
              child: Builder(
                builder: (context) {
                  if (searchController.text.isNotEmpty) {
                    if (filteredTasks.isEmpty) {
                      return const EmptyHome(); 
                    } else {
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: filteredTasks.length,
                        itemBuilder: (context, index) =>
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: TaskItemWidget(task: filteredTasks[index]),
                            ),
                      );
                    }
                  } else {
                    return const ShowTasks(); 
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }
}