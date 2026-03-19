import 'package:flutter/material.dart';
import 'package:todo/core/common/widgets/svg_icon_button.dart';
import 'package:todo/core/theme/app_colors.dart';
import 'package:todo/core/theme/app_text_styles.dart';

class TaskInfoRow extends StatelessWidget {
  const TaskInfoRow({
    super.key,
    required this.iconPath,
    required this.label,
    required this.widget,
  });

  final String iconPath;
  final String label;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgIconButton(imagePath: iconPath, onTap: () {}),
        const SizedBox(width: 10),

        Text(
          "$label :",
          style: AppTextStyles.regular16.copyWith(
            color: AppColors.whiteColor,
          ),
        ),

        const Spacer(),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.mediumGrey,
            borderRadius: BorderRadius.circular(8),
          ),
          child: widget,
        ),
      ],
    );
  }
}