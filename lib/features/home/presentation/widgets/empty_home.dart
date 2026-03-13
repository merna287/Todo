import 'package:flutter/material.dart';
import 'package:todo/core/constants/app_assets.dart';
import 'package:todo/core/constants/app_strings.dart';
import 'package:todo/core/theme/app_colors.dart';
import 'package:todo/core/theme/app_text_styles.dart';

class EmptyHome extends StatelessWidget {
  const EmptyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.12),
          Image.asset(Assets.assetsImagesChecklist),
          SizedBox(height: 7),
          Text(
            AppStrings.whatDoYouWantToDoToday,
            style: AppTextStyles.regular20.copyWith(
              color: AppColors.whiteColor
            )
          ),
          Text(
            AppStrings.tapToAddYourTasks,
            style: AppTextStyles.regular16.copyWith(
              color: AppColors.whiteColor
            )
          ),
        ],
      ),
    );
  }
}