import 'package:flutter/material.dart';
import 'package:todo/core/theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.style,
    this.backgroundColor,
    this.decoration,
    this.padding,
    this.margin,
    this.onPressed,
    this.isDisabled = false, this.borderColor,
  });

  final String text;
  final TextStyle? style;
  final Color? backgroundColor;
  final Color? borderColor;
  final Decoration? decoration;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onPressed;
  final bool isDisabled;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: decoration,
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primaryColor,
          padding:
              padding ??
              const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: borderColor != null ? BorderSide(color: borderColor!) : BorderSide.none,
          ),
          elevation: 0,
        ),
        child: Text(text, style: style),
      ),
    );
  }
}
