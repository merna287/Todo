import 'package:flutter/material.dart';

class ProfileMenuItemData {
  const ProfileMenuItemData({
    required this.icon,
    required this.title,
    this.onTap,
    this.iconColor,
    this.textColor,
    this.showArrow = true,
  });

  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final Color? iconColor;
  final Color? textColor;
  final bool showArrow;
}
