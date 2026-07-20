import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/common/widgets/text_form_field_widget.dart';
import 'package:todo/core/constants/app_strings.dart';
import 'package:todo/core/theme/app_colors.dart';
import 'package:todo/core/utils/app_validator.dart';
import 'package:todo/features/profile/model_view/profile_view_model.dart';

class ShowChangeName extends StatefulWidget {
  const ShowChangeName({super.key});
  @override
  State<ShowChangeName> createState() => _ShowChangeNameState();
}

class _ShowChangeNameState extends State<ShowChangeName> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(
    //  text: context.read<ProfileViewModel>().user?.name ?? '',
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ProfileViewModel>();
    return Dialog(
      backgroundColor: AppColors.mediumGrey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              AppStrings.changeAccountName,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(height: 12),
            const Divider(color: Colors.white24),

            const SizedBox(height: 12),

            TextFormFieldWidget(
              hint: AppStrings.enterNewName,
              color: AppColors.lightGrey2,
              controller: controller,
              myValidator: ValidatorApp.validateName,
            ),

            const SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(AppStrings.cancel),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: () {
                    viewModel.updateProfile(controller.text, '', '');
                    Navigator.pop(context);
                  },
                  child: const Text(AppStrings.edit),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
