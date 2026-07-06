import 'package:flutter/material.dart';
import 'package:todo/core/theme/app_colors.dart';
import 'package:todo/core/theme/app_text_styles.dart';

class ProfileLogoutButton extends StatelessWidget {
  const ProfileLogoutButton({
    super.key,
    this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: AppColors.mediumGrey,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.darkGrey),
          ),
          child: Row(
            children: [
              Icon(
                Icons.logout,
                color: AppColors.redColor,
                size: 20,
              ),
              const SizedBox(width: 12),
              Text(
                'Logout',
                style: AppTextStyles.regular14.copyWith(
                  color: AppColors.redColor,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
