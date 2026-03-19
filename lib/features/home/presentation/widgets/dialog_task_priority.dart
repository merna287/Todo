import 'package:flutter/material.dart';
import 'package:todo/core/constants/app_strings.dart';
import 'package:todo/core/theme/app_colors.dart';
import 'package:todo/core/theme/app_text_styles.dart';

class DialogCustomWidget extends StatefulWidget {
  const DialogCustomWidget({super.key, required this.getPriority});
  final void Function(String) getPriority;

  @override
  State<DialogCustomWidget> createState() => _DialogCustomWidgetState();
}

class _DialogCustomWidgetState extends State<DialogCustomWidget> {
  int selectedIndex = 1;
  String selectedPriority = AppStrings.low;  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.darkGrey,
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppStrings.taskPriority,
            style: AppTextStyles.regular16.copyWith(
              color: AppColors.whiteColor,
            ),
          ),
          const SizedBox(height: 10),
          Divider(color: Colors.grey.shade700),

          SizedBox(height: 10),
          Row(
            children: [
              _PriorityItemWidget(
                priority: AppStrings.high,
                isSelected: selectedPriority == AppStrings.high,
                onTap: () {
                  setState(() {
                    selectedPriority = AppStrings.high;
                  });
                },
              ),
              _PriorityItemWidget(
                priority: AppStrings.medium,
                isSelected: selectedPriority == AppStrings.medium,
                onTap: () {
                  setState(() {
                    selectedPriority = AppStrings.medium;
                  });
                },
              ),
              _PriorityItemWidget(
                priority: AppStrings.low,
                isSelected: selectedPriority == AppStrings.low,
                onTap: () {
                  setState(() {
                    selectedPriority = AppStrings.low;
                  });
                },
              ),
            ],
          ),

          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  color: AppColors.darkGrey,
                  elevation: 0,
                  height: 45,
                  child: Text(
                    AppStrings.cancel,
                    style: AppTextStyles.regular16.copyWith(
                      color: AppColors.secondColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    widget.getPriority(selectedPriority);
                    Navigator.of(context).pop();
                  },
                  color: AppColors.secondColor,
                  elevation: 0,
                  height: 45,
                  child: Text(
                    AppStrings.save,
                    style: AppTextStyles.regular16.copyWith(
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PriorityItemWidget extends StatelessWidget {
  const _PriorityItemWidget({
    required this.priority,
    required this.isSelected,
    this.onTap,
  });

  final void Function()? onTap;
  final String priority;
  final bool isSelected;

  Color _getColor() {
    switch (priority) {
      case 'Low':
        return AppColors.greenColor;
      case 'Medium':
        return AppColors.orangeColor;
      case 'High':
        return AppColors.redColor;
      default:
        return AppColors.lightGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColor();

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(vertical: 12),
          margin: EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            color: isSelected ? color.withOpacity(0.2) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? color : AppColors.lightGrey,
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              priority,
              style: AppTextStyles.bold16.copyWith(
                color: isSelected ? color : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
