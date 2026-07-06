import 'package:flutter/material.dart';
import 'package:todo/core/theme/app_colors.dart';
import 'package:todo/core/theme/app_text_styles.dart';

class ProfilePlaceholderScreen extends StatelessWidget {
  const ProfilePlaceholderScreen({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.whiteColor),
        title: Text(
          title,
          style: AppTextStyles.bold16.copyWith(color: AppColors.whiteColor),
        ),
      ),
      body: Center(
        child: Text(
          title,
          style: AppTextStyles.regular16.copyWith(color: AppColors.whiteColor),
        ),
      ),
    );
  }
}
