import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/theme/app_colors.dart';
import 'package:todo/core/theme/app_text_styles.dart';
import 'package:todo/features/profile/model_view/profile_view_model.dart';

class InitialAvatar extends StatelessWidget {
  const InitialAvatar({super.key, this.radius = 50, this.backgroundColor});

  final double radius;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final profileVm = context.watch<ProfileViewModel>();
    final rawName = profileVm.user?.name.trim();
    final initial = (rawName != null && rawName.isNotEmpty)
        ? rawName.substring(0, 1).toUpperCase()
        : 'U';

    final textStyle = radius > 24
        ? AppTextStyles.bold32.copyWith(color: AppColors.whiteColor)
        : AppTextStyles.bold16.copyWith(color: AppColors.whiteColor);

    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor?? AppColors.secondColor,
      child: Text(initial, style: textStyle),
    );
  }
}
