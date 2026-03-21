import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/common/widgets/buttons.dart';
import 'package:todo/core/common/widgets/svg_icon_button.dart';
import 'package:todo/core/constants/app_assets.dart';
import 'package:todo/core/constants/app_strings.dart';
import 'package:todo/core/dialogs/app_dialogs.dart';
import 'package:todo/core/theme/app_colors.dart';
import 'package:todo/core/theme/app_text_styles.dart';
import 'package:todo/features/home/presentation/model/task_model.dart';
import 'package:todo/features/home/presentation/view_model/task_view_model.dart';
import 'package:todo/features/home/presentation/widgets/dialog_task_priority.dart';
import 'package:todo/features/home/presentation/widgets/edit_task_title.dart';
import 'package:todo/features/home/presentation/widgets/is_completed_radio_widget.dart';
import 'package:todo/features/home/presentation/widgets/task_info_row.dart';

class DetailedTaskScreen extends StatefulWidget {
  const DetailedTaskScreen({super.key, required this.task});
  final TaskModel task;

  @override
  State<DetailedTaskScreen> createState() => _DetailedTaskScreenState();
}

class _DetailedTaskScreenState extends State<DetailedTaskScreen> {
  late bool isDone;
  late String title;
  late String description;
  late String priority;
  late DateTime selectedDate;
  late TaskModel originalTask;

  @override
  void initState() {
    super.initState();
    originalTask = widget.task;

    title = widget.task.title;
    description = widget.task.description;
    priority = widget.task.priority;
    selectedDate = widget.task.deadline;
    isDone = widget.task.completed;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(12),
          child: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.mediumGrey,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(Icons.close, color: AppColors.lightGrey2),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: InkWell(
              onTap: () {
                setState(() {
                  title = originalTask.title;
                  description = originalTask.description;
                  priority = originalTask.priority;
                  selectedDate = originalTask.deadline;
                  isDone = originalTask.completed;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.mediumGrey,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: SvgPicture.asset(
                    Assets.assetsIconsRepeat,
                    width: 27,
                    height: 27,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => context.read<TaskViewModel>().toggleCompleted(
                    widget.task,
                  ),
                  child: IsCompletedRadioWidget(isDone: isDone),
                ),
                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTextStyles.regular20.copyWith(
                          color: AppColors.whiteColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        description,
                        style: AppTextStyles.regular16.copyWith(
                          color: AppColors.lightGrey2,
                        ),
                      ),
                    ],
                  ),
                ),

                SvgIconButton(
                  imagePath: Assets.assetsIconsEdit,
                  onTap: () async {
                    final result = await showDialog(
                      context: context,
                      barrierColor: Colors.transparent,
                      builder: (context) =>
                          EditTaskTitle(title: title, description: description),
                    );

                    if (result != null) {
                      setState(() {
                        title = result["title"];
                        description = result["description"];
                      });
                    }
                  },
                ),
              ],
            ),

            const SizedBox(height: 35),

            TaskInfoRow(
              iconPath: Assets.assetsIconsTimer,
              label: AppStrings.taskTime,
              widget: GestureDetector(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 30)),
                    initialDate: selectedDate,
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.dark(
                            primary: AppColors.secondColor,
                            onPrimary: AppColors.whiteColor,
                            surface: AppColors.darkGrey,
                            onSurface: AppColors.whiteColor,
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (picked != null) {
                    setState(() {
                      selectedDate = picked;
                    });
                  }
                },
                child: Text(
                  "${selectedDate.toLocal()}".split(' ')[0],
                  style: AppTextStyles.regular16.copyWith(
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            TaskInfoRow(
              iconPath: Assets.assetsIconsFlag,
              label: AppStrings.taskPriority,
              widget: GestureDetector(
                onTap: () async {
                  String? selected;

                  await showDialog(
                    context: context,
                    builder: (context) => DialogCustomWidget(
                      getPriority: (p1) {
                        selected = p1;
                      },
                    ),
                  );

                  if (selected != null) {
                    setState(() {
                      priority = selected!;
                    });
                  }
                },
                child: Text(
                  priority,
                  style: AppTextStyles.regular16.copyWith(
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            InkWell(
              onTap: () async {
                final confirm = await AppDialogs.showDeleteDialog(
                  context,
                  title: widget.task.title,
                );

                if (confirm == true) {
                  context.read<TaskViewModel>().deleteTask(widget.task.id);
                  Navigator.pop(context);
                }
              },
              child: Row(
                children: [
                  SvgIconButton(
                    imagePath: Assets.assetsIconsTrash,
                    onTap: () {
                      context.read<TaskViewModel>().deleteTask(widget.task.id);
                      Navigator.pop(context);
                    },
                    color: AppColors.redColor,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    AppStrings.deleteTask,
                    style: AppTextStyles.regular20.copyWith(
                      color: AppColors.redColor,
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                text: AppStrings.editTask,
                style: AppTextStyles.regular20.copyWith(
                  color: AppColors.whiteColor,
                ),
                backgroundColor: AppColors.secondColor,
                borderColor: AppColors.secondColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 15,
                ),
                onPressed: () {
                  final updatedTask = TaskModel(
                    id: widget.task.id,
                    title: title,
                    description: description,
                    priority: priority,
                    deadline: selectedDate,
                    completed: isDone,
                  );

                  context.read<TaskViewModel>().updateTask(updatedTask);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
