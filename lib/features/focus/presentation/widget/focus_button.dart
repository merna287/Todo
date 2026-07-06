import 'package:flutter/material.dart';
import 'package:todo/core/constants/app_strings.dart';
import 'package:todo/core/theme/app_colors.dart';
import 'package:todo/core/theme/app_text_styles.dart';

class FocusButton extends StatelessWidget {
  const FocusButton({
    super.key,
    required this.isRunning,
    required this.onPressed,
  });

  final bool isRunning;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondColor,
          foregroundColor: AppColors.whiteColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          isRunning ? AppStrings.stopFocusing : AppStrings.startFocusing,
          style: AppTextStyles.regular16.copyWith(color: AppColors.whiteColor),
        ),
      ),
    );
  }
}
