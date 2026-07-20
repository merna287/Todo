import 'package:flutter/material.dart';
import 'package:todo/features/profile/widget/dice_bear_avatar.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/constants/app_strings.dart';
import 'package:todo/core/theme/app_colors.dart';
import 'package:todo/features/profile/model_view/profile_view_model.dart';
import 'package:todo/features/profile/widget/initial_avatar.dart';

class ChangeAvatarScreen extends StatefulWidget {
  const ChangeAvatarScreen({super.key});

  @override
  State<ChangeAvatarScreen> createState() => _ChangeAvatarScreenState();
}

class _ChangeAvatarScreenState extends State<ChangeAvatarScreen> {
  String? selectedSeed;

  Color selectedColor = AppColors.secondColor;

  final avatarColors = [
    AppColors.avatarPurple,
    AppColors.avatarBlue,
    AppColors.avatarGreen,
    AppColors.avatarOrange,
    AppColors.avatarRed,
    AppColors.avatarCyan,
    AppColors.avatarPink,
    AppColors.avatarBrown,
    AppColors.whiteColor,
  ];

  final List<String> avatarSeeds = const [
    "Emma",
    "Sophia",
    "Olivia",
    "Ava",
    "Liam",
    "Noah",
    "Lucas",
    "James",
  ];

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ProfileViewModel>();

    return Dialog(
      backgroundColor: AppColors.mediumGrey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              AppStrings.chooseAvatar,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Divider(color: Colors.white24),

            const SizedBox(height: 20),

            if (selectedSeed == null)
              InitialAvatar(
                radius: 55,
                backgroundColor: selectedColor,
              )
            else
              DiceBearAvatar(
                seed: selectedSeed!,
                radius: 55,
                backgroundColor: selectedColor,
              ),

            const SizedBox(height: 20),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: avatarSeeds.length + 1,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                if (index == 0) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedSeed = null;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: selectedSeed == null
                              ? AppColors.secondColor
                              : Colors.transparent,
                          width: 3,
                        ),
                      ),
                      child: InitialAvatar(
                        radius: 25,
                        backgroundColor: selectedColor,
                      ),
                    ),
                  );
                }

                final seed = avatarSeeds[index - 1];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedSeed = seed;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: selectedSeed == seed
                            ? AppColors.secondColor
                            : Colors.transparent,
                        width: 3,
                      ),
                    ),
                    child: DiceBearAvatar(
                      seed: seed,
                      radius: 25,
                      backgroundColor: selectedColor,
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: avatarColors.map((color) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedColor = color;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: selectedColor == color
                            ? Colors.white
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: color,
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(AppStrings.cancel),
                ),
                const SizedBox(width: 10),
                FilledButton(
                  onPressed: () async {
                      await viewModel.saveAvatar(
                        seed: selectedSeed,
                        color: selectedColor,
                      );
                      if (!context.mounted) return;
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