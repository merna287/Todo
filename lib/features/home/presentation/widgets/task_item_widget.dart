import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/common/widgets/svg_icon_button.dart';
import 'package:todo/core/constants/app_assets.dart';
import 'package:todo/core/dialogs/app_dialogs.dart';
import 'package:todo/core/theme/app_colors.dart';
import 'package:todo/core/theme/app_text_styles.dart';
import 'package:todo/features/home/presentation/model/task_model.dart';
import 'package:todo/features/home/presentation/view/detailed_task_screen.dart';
import 'package:todo/features/home/presentation/view_model/task_view_model.dart';
import 'package:todo/features/home/presentation/widgets/is_completed_radio_widget.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({super.key, required this.task});

  final TaskModel task;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DetailedTaskScreen(task: task)),
        );
      },
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: AppColors.mediumGrey,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                context.read<TaskViewModel>().toggleCompleted(task);
              },
              child: IsCompletedRadioWidget(isDone: task.completed),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    task.title,
                    style: AppTextStyles.regular20.copyWith(
                      color: task.completed
                          ? AppColors.lightGrey
                          : AppColors.whiteColor,
                      decoration: task.completed
                          ? TextDecoration.lineThrough
                          : null,
                      decorationColor: AppColors.redColor,
                      decorationThickness: 2, 
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    task.description,
                    style: AppTextStyles.regular16.copyWith(
                      color: task.completed
                          ? AppColors.lightGrey
                          : AppColors.whiteColor,
                      decorationColor: AppColors.redColor,
                      decoration: task.completed
                          ? TextDecoration.lineThrough
                          : null,
                      decorationThickness: 2, 
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    task.formattedDate,
                    style: AppTextStyles.regular16.copyWith(
                      color: AppColors.lightGrey2,
                    ),
                  ),
                ],
              ),
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SvgIconButton(
                  imagePath: Assets.assetsIconsTrash,
                  onTap: () async {
                final confirm = await AppDialogs.showDeleteDialog(
                  context,
                  title: task.title,
                );

                if (confirm == true) {
                  context.read<TaskViewModel>().deleteTask(task.id); 
                }
              },
                  color: AppColors.secondColor,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: getPriorityColor(task.priority).withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: getPriorityColor(task.priority)),
                  ),
                  child: Text(
                    task.priority,
                    style: AppTextStyles.bold16.copyWith(
                      color: getPriorityColor(task.priority),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return AppColors.redColor;
      case 'medium':
        return AppColors.orangeColor;
      case 'low':
        return AppColors.greenColor;
      default:
        return AppColors.secondColor;
    }
  }
}
