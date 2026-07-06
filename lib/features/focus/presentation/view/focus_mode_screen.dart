import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/constants/app_strings.dart';
import 'package:todo/core/theme/app_colors.dart';
import 'package:todo/core/theme/app_text_styles.dart';
import 'package:todo/features/focus/presentation/view_model/focus_view_model.dart';
import 'package:todo/features/focus/presentation/widget/focus_button.dart';
import 'package:todo/features/focus/presentation/widget/focus_timer.dart';
//import 'package:todo/features/focus/presentation/widget/overview_chart.dart';

class FocusModeScreen extends StatelessWidget {
  const FocusModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<FocusViewModel>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 8),
          Text(
            AppStrings.focusMode,
            style: AppTextStyles.bold32.copyWith(color: AppColors.whiteColor),
          ),
          const SizedBox(height: 24),
          FocusTimer(
            progress: viewModel.progress,
            time: viewModel.formattedTime,
            isRunning: viewModel.isRunning,
          ),
          const SizedBox(height: 24),
          Text(
            AppStrings.focusModeDescription,
            style: AppTextStyles.regular16.copyWith(color: AppColors.lightGrey2),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          FocusButton(
            isRunning: viewModel.isRunning,
            onPressed: viewModel.toggleTimer,
          ),
          const SizedBox(height: 32),
          // Align(
          //   alignment: Alignment.centerLeft,
          //   child: Text(
          //     AppStrings.overview,
          //     style: AppTextStyles.bold16.copyWith(color: AppColors.whiteColor),
          //   ),
          // ),
          //const SizedBox(height: 16),
          //OverviewChart(stats: viewModel.weeklyStats),
        ],
      ),
    );
  }
}
