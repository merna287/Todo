import 'package:flutter/material.dart'; 
import 'package:provider/provider.dart';
import 'package:todo/core/common/widgets/svg_icon_button.dart';
import 'package:todo/core/common/widgets/text_form_field_widget.dart';
import 'package:todo/core/constants/app_assets.dart';
import 'package:todo/core/constants/app_strings.dart';
import 'package:todo/core/theme/app_colors.dart';
import 'package:todo/core/theme/app_text_styles.dart';
import 'package:todo/core/utils/app_validator.dart';
import 'package:todo/features/home/presentation/model/task_model.dart';
import 'package:todo/features/home/presentation/view_model/task_view_model.dart';
import 'package:todo/features/home/presentation/widgets/dialog_task_priority.dart';

class BottomSheetAddTask extends StatefulWidget {
  const BottomSheetAddTask({super.key});

  @override
  State<BottomSheetAddTask> createState() => _BottomSheetAddTaskState();
}

class _BottomSheetAddTaskState extends State<BottomSheetAddTask> {
  late TextEditingController taskName;
  late TextEditingController taskDescription;
  late DateTime selectedDate = DateTime.now();
  late String priority = AppStrings.low;

  @override
  void initState() {
    super.initState();
    taskName = TextEditingController();
    taskDescription = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text(
            AppStrings.addTask,
            style: AppTextStyles.regular20.copyWith(
              color: AppColors.whiteColor,
            ),
          ),
          TextFormFieldWidget(
            hint: AppStrings.title,
            color: AppColors.whiteColor,
            controller: taskName,
            myValidator: ValidatorApp.validateName,
          ),
          TextFormFieldWidget(
            hint: AppStrings.description,
            controller: taskDescription,
            color: AppColors.whiteColor,
            myValidator: ValidatorApp.validateName,
            maxLines: 4,
          ),
          SizedBox(height: 20),
          Row(
            children: [
              SvgIconButton(
                imagePath: Assets.assetsIconsTimer,
                onTap: () async {
                  selectedDate =
                      await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 30)),
                        initialDate: DateTime.now(),
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
                      ) ??
                      DateTime.now();
                      setState(() {});
                },
              ),
              SizedBox(width: 7),
              SvgIconButton(
                imagePath: Assets.assetsIconsFlag,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => DialogCustomWidget(
                      getPriority: (selectedPriority) {
                        setState(() {
                          priority = selectedPriority;
                        });
                      },
                    ),
                  );
                },
              ),
              Spacer(),
              SvgIconButton(imagePath: Assets.assetsIconsSend, onTap: _addTask),
            ],
          ),
        ],
      ),
    );
  }

  void _addTask() async{
    final task = TaskModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(), 
      title: taskName.text,
      description: taskDescription.text,
      priority: priority,
      deadline: selectedDate,
    );

    await context.read<TaskViewModel>().addTask(task);

    Navigator.of(context).pop();
  }
}

