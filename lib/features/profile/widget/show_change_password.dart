import 'package:flutter/material.dart'; 
import 'package:provider/provider.dart';
import 'package:todo/core/common/widgets/text_form_field_widget.dart';
import 'package:todo/core/constants/app_strings.dart';
import 'package:todo/core/theme/app_colors.dart';
import 'package:todo/core/utils/app_validator.dart';
import 'package:todo/features/profile/model_view/profile_view_model.dart';

class ShowChangePassword extends StatelessWidget {
  const ShowChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ProfileViewModel>();
    final newPasswordController = TextEditingController();
    final oldPasswordController = TextEditingController();
    return AlertDialog(
      backgroundColor: AppColors.mediumGrey,
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text(AppStrings.changePassword, style: TextStyle(color: Colors.white)),
          SizedBox(height: 12),
          Divider(color: Colors.white24, thickness: 1, height: 1),
        ],
      ),
      content:Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormFieldWidget(
            hint: AppStrings.enterOldPassword,
            color: AppColors.lightGrey2,
            controller: oldPasswordController,
            myValidator: ValidatorApp.validatePassword,
          ),
          SizedBox(height: 12),
          TextFormFieldWidget(
            hint: AppStrings.enterNewPassword,
            color: AppColors.lightGrey2,
            controller: newPasswordController,
            myValidator: ValidatorApp.validatePassword,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(AppStrings.cancel),
        ),
        FilledButton(
          onPressed: () {
            viewModel.updateProfile('',newPasswordController.text,'');
            Navigator.pop(context);
          },
          child: const Text(AppStrings.edit),
        ),
      ],
    );
  }
}