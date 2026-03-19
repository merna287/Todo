import 'package:flutter/material.dart';
import 'package:todo/core/theme/app_colors.dart';

class IsCompletedRadioWidget extends StatelessWidget {
  const IsCompletedRadioWidget({super.key, required this.isDone});
  final bool isDone;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isDone ? AppColors.secondColor : AppColors.lightGrey2,
          width: 2,
        ),
      ),
      child: Container(
        margin: EdgeInsets.all(2),
        decoration: BoxDecoration(
          border: BoxBorder.all(color: AppColors.mediumGrey),
          shape: BoxShape.circle,
          color: isDone ? AppColors.secondColor : AppColors.mediumGrey,
        ),
      ),
    );
  }
}
