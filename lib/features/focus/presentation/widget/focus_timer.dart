import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:todo/core/constants/app_strings.dart';
import 'package:todo/core/theme/app_colors.dart';
import 'package:todo/core/theme/app_text_styles.dart';

class FocusTimer extends StatelessWidget {
  const FocusTimer({
    super.key,
    required this.progress,
    required this.time,
    required this.isRunning,
  });

  final double progress;
  final String time;
  final bool isRunning;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      height: 260,
      child: SleekCircularSlider(
        min: 0,
        max: 100,
        initialValue: (progress * 100).clamp(0, 100).toDouble(),
        appearance: CircularSliderAppearance(
          size: 260,
          startAngle: 270,
          angleRange: 360,
          customWidths: CustomSliderWidths(
            progressBarWidth: 16,
            trackWidth: 16,
            handlerSize: 0,
          ),
          customColors: CustomSliderColors(
            trackColor: AppColors.mediumGrey,
            progressBarColor: AppColors.secondColor,
            hideShadow: true,
          ),
          infoProperties: InfoProperties(
            mainLabelStyle: AppTextStyles.bold32.copyWith(
              color: AppColors.whiteColor,
            ),
            topLabelStyle: AppTextStyles.regular16.copyWith(
              color: AppColors.lightGrey2,
            ),
            topLabelText: isRunning ? AppStrings.inProgress : AppStrings.readyToFocus,
            modifier: (value) => time,
          ),
        ),
        onChange: (_) {},
      ),
    );
  }
}
