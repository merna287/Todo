import 'package:flutter/material.dart';
import 'package:todo/core/common/widgets/text_form_field_widget.dart';
import 'package:todo/core/constants/app_strings.dart';
import 'package:todo/core/theme/app_colors.dart';
import 'package:todo/core/theme/app_text_styles.dart';
import 'package:todo/core/utils/app_validator.dart';

class EditTaskTitle extends StatefulWidget {
  const EditTaskTitle({
    super.key,
    required this.title,
    required this.description,
    this.onTap,
  });
  final void Function()? onTap;
  final String description;
  final String title;

  @override
  State<EditTaskTitle> createState() => _EditTaskTitleState();
}

class _EditTaskTitleState extends State<EditTaskTitle> {
  late TextEditingController taskName;
  late TextEditingController taskDescription;

  @override
  void initState() {
    super.initState();
    taskName = TextEditingController(text: widget.title);
    taskDescription = TextEditingController(text: widget.description);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.mediumGrey,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Text(
                AppStrings.editTaskTitle,
                style: AppTextStyles.bold16.copyWith(
                  color: AppColors.whiteColor,
                ),
              ),
            ),
            Divider(color: AppColors.lightGrey),
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
            const SizedBox(height: 15),
            Row(
              spacing: 15,
              children: [
                Expanded(
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    color: AppColors.mediumGrey,
                    elevation: 0,
                    height: 45,
                    child: Text(
                      AppStrings.cancel,
                      style: AppTextStyles.regular16.copyWith(
                        color: AppColors.secondColor,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.pop(context, {
                        "title": taskName.text,
                        "description": taskDescription.text,
                      });
                    },
                    color: AppColors.secondColor,
                    elevation: 0,
                    height: 45,

                    child: Text(
                      AppStrings.edit,
                      style: AppTextStyles.regular16.copyWith(
                        color: AppColors.whiteColor,
                      ),
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
}
