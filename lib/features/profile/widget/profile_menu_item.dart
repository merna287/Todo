import 'package:flutter/material.dart';
import 'package:todo/core/theme/app_colors.dart';
import 'package:todo/core/theme/app_text_styles.dart';
import 'package:todo/features/profile/model/profile_menu_item_data.dart';

class ProfileMenuItem extends StatelessWidget {
  const ProfileMenuItem({
    super.key,
    required this.item,
  });

  final ProfileMenuItemData item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: item.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(
              item.icon,
              color: item.iconColor ?? AppColors.lightGrey2,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                item.title,
                style: AppTextStyles.regular14.copyWith(
                  color: item.textColor ?? AppColors.whiteColor,
                  fontSize: 18,
                ),
              ),
            ),
            if (item.showArrow)
              Icon(
                Icons.arrow_forward_ios,
                color: AppColors.lightGrey2,
                size: 16,
              ),
          ],
        ),
      ),
    );
  }
}
