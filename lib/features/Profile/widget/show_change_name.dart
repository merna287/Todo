import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/common/widgets/text_form_field_widget.dart';
import 'package:todo/core/constants/app_strings.dart';
import 'package:todo/core/theme/app_colors.dart';
import 'package:todo/core/utils/app_validator.dart';
import 'package:todo/features/Profile/model_view/profile_view_model.dart';

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
    return AlertDialog(
      backgroundColor: AppColors.mediumGrey,
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text(AppStrings.changeAccountName, style: TextStyle(color: Colors.white)),
          SizedBox(height: 12),
          Divider(color: Colors.white24, thickness: 1, height: 1),
        ],
      ),
      content: TextFormFieldWidget(
            hint: AppStrings.enterNewName,
            color: AppColors.lightGrey2,
            controller: controller,
            myValidator: ValidatorApp.validateName,
          ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(AppStrings.cancel),
        ),
        FilledButton(
          onPressed: () {
            viewModel.updateName(controller.text);
            Navigator.pop(context);
          },
          child: const Text(AppStrings.edit),
        ),
      ],
    );
  }
}
