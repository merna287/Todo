import 'package:flutter/material.dart';
import 'package:todo/core/theme/app_colors.dart';
import 'package:todo/core/theme/app_text_styles.dart';
import 'package:todo/features/Profile/model/profile_menu_item_data.dart';
import 'package:todo/features/Profile/widget/profile_menu_item.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({
    super.key,
    required this.sectionTitle,
    required this.items,
  });

  final String sectionTitle;
  final List<ProfileMenuItemData> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            sectionTitle,
            style: AppTextStyles.regular14.copyWith(
              color: AppColors.lightGrey,
              fontSize: 20,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: AppColors.mediumGrey,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.darkGrey),
          ),
          child: Column(
            children: List.generate(items.length, (index) {
              final item = items[index];
              return Column(
                children: [
                  ProfileMenuItem(item: item),
                  if (index < items.length - 1)
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: AppColors.darkGrey,
                      indent: 16,
                      endIndent: 16,
                    ),
                ],
              );
            }),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
