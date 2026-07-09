import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:todo/core/constants/app_strings.dart';
import 'package:todo/core/theme/app_colors.dart';
import 'package:todo/core/theme/app_text_styles.dart';
import 'package:todo/features/focus/presentation/view_model/focus_view_model.dart';

class OverviewChart extends StatelessWidget {
  const OverviewChart({super.key, required this.stats});

  final List<FocusStat> stats;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkGrey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.overview,
                style: AppTextStyles.bold16.copyWith(color: AppColors.whiteColor),
              ),
              DropdownButton2<String>(
                value: AppStrings.thisWeek,
                buttonStyleData: const ButtonStyleData(
                  height: 36,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                ),
                dropdownStyleData: DropdownStyleData(
                  maxHeight: 120,
                  decoration: BoxDecoration(
                    color: AppColors.mediumGrey,
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                items: const [
                  DropdownMenuItem(value: AppStrings.thisWeek, child: Text(AppStrings.thisWeek)),
                ],
                onChanged: (_) {},
                underline: const SizedBox(),
                iconStyleData: const IconStyleData(
                  icon: Icon(Icons.keyboard_arrow_down, color: AppColors.whiteColor),
                ),
                style: AppTextStyles.regular14.copyWith(color: AppColors.whiteColor),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 220,
            child: BarChart(
              BarChartData(
                maxY: 6,
                minY: 0,
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 1,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: AppColors.mediumGrey,
                    strokeWidth: 1,
                  ),
                ),
                borderData: FlBorderData(show: false),
                barGroups: stats.asMap().entries.map((entry) {
                  final index = entry.key;
                  final stat = entry.value;
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: stat.hours,
                        width: 22,
                        color: stat.isHighlighted ? AppColors.secondColor : AppColors.mediumGrey,
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                      ),
                    ],
                  );
                }).toList(),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      interval: 1,
                      getTitlesWidget: (value, _) {
                        if (value % 1 != 0) return const SizedBox();
                        return Text(
                          '${value.toInt()}h',
                          style: AppTextStyles.regular12.copyWith(color: AppColors.lightGrey2),
                        );
                      },
                    ),
                  ),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 32,
                      getTitlesWidget: (value, _) {
                        final index = value.toInt();
                        if (index < 0 || index >= stats.length) return const SizedBox();
                        return Text(
                          stats[index].day,
                          style: AppTextStyles.regular12.copyWith(color: AppColors.whiteColor),
                        );
                      },
                    ),
                  ),
                ),
                barTouchData: BarTouchData(enabled: false),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
