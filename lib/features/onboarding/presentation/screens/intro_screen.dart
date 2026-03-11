import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo/core/constants/app_assets.dart';
import 'package:todo/core/constants/app_strings.dart';
import 'package:todo/core/routing/app_router.dart';
import 'package:todo/core/theme/app_colors.dart';
import 'package:todo/core/theme/app_text_styles.dart';
import 'package:todo/core/widgets/buttons.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset(Assets.assetsIconsArrowLeft),
                ),
              ),
              SizedBox(height: 50),
              Text(
                AppStrings.welcomeToUpTodo,
                style: AppTextStyles.bold32.copyWith(
                  color: AppColors.whiteColor,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              Text(
                AppStrings.pleaseLogin,
                style: AppTextStyles.regular16.copyWith(
                  color: AppColors.lightGrey,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: AppStrings.login.toUpperCase(),
                  style: AppTextStyles.regular16.copyWith(
                    color: AppColors.whiteColor,
                  ),
                  backgroundColor: AppColors.secondColor,
                  borderColor: AppColors.secondColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 15,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.login);
                  },
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: AppStrings.createAccount.toUpperCase(),
                  style: AppTextStyles.regular16.copyWith(
                    color: AppColors.whiteColor,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.secondColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 15,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.register);
                  },
                ),
              ),
              SizedBox(height: 40,)
            ],
          ),
        ),
      ),
    );
  }
}
