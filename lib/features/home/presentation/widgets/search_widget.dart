import 'package:flutter/material.dart'; 
import 'package:todo/core/common/widgets/svg_icon_button.dart';
import 'package:todo/core/common/widgets/text_form_field_widget.dart';
import 'package:todo/core/constants/app_assets.dart';
import 'package:todo/core/constants/app_strings.dart';
import 'package:todo/core/theme/app_colors.dart';
import 'package:todo/core/utils/app_validator.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextFormFieldWidget(
        prefixIcon: Padding(
          padding: const EdgeInsets.all(10),
          child: SvgIconButton(
            imagePath: Assets.assetsIconsSearch,
            onTap: () {},
          ),
        ),
        fillColor: AppColors.mediumGrey,
        controller: controller,
        myValidator: ValidatorApp.validateName,
        color: AppColors.whiteColor,
        hint: AppStrings.searchForYourTask,
        onChanged: onChanged,
      ),
    );
  }
}
