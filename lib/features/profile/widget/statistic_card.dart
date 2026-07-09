import 'package:flutter/material.dart';
import 'package:todo/core/theme/app_colors.dart';
import 'package:todo/core/theme/app_text_styles.dart';

class StatisticCard extends StatelessWidget {
  final String label;
  final int count;

  const StatisticCard({
    super.key,
    required this.label,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.mediumGrey,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.darkGrey),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            count.toString(),
            style: AppTextStyles.regular16.copyWith(
              color: AppColors.secondColor,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: AppTextStyles.regular16.copyWith(
              color: AppColors.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}