import 'package:flutter/material.dart';
import 'package:todo/core/constants/app_assets.dart';
import 'package:todo/core/constants/app_strings.dart';
import 'package:todo/core/theme/app_colors.dart';
import 'package:todo/core/theme/app_text_styles.dart';

class EmptyHome extends StatelessWidget {
  final int pageIndex;
  const EmptyHome({super.key, required this.pageIndex});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          spacing: 5,
          children: [
            pageIndex == 0
                ? SizedBox(height: MediaQuery.of(context).size.height * 0.12)
                : SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Image.asset(Assets.assetsImagesChecklist,
            width: 227,
            height: 227,
            scale: 3,
            ),
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
      ),
    );
  }
}