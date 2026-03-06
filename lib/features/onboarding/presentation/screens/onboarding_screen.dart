import 'package:flutter/material.dart';
import 'package:todo/core/constants/app_strings.dart';
import 'package:todo/core/routing/app_router.dart';
import 'package:todo/core/theme/app_colors.dart';
import 'package:todo/core/theme/app_text_styles.dart';
import 'package:todo/core/widgets/buttons.dart';
import 'package:todo/features/onboarding/presentation/view_model/onboarding_model.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController controller = PageController();
  int _currentPage = 0;
  int length = OnboardingViewModel.onboardingData.length;

  @override
  Widget build(BuildContext context) {
    final item = OnboardingViewModel.onboardingData[_currentPage];

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            child: Align(
              alignment: Alignment.topLeft,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    Navigator.pushNamed(context, AppRoutes.intro);
                  });
                },
                child: Text(
                  AppStrings.skip.toUpperCase(),
                  style: AppTextStyles.regular16.copyWith(
                    color: AppColors.mediumGrey,
                  ),
                ),
              ),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 30,
                children: [
                  Image.asset(item.image, height: 290),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        height: 5,
                        width: 28,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? AppColors.whiteColor
                              : AppColors.mediumGrey,
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    item.title,
                    style: AppTextStyles.bold32.copyWith(
                      color: AppColors.whiteColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    item.body,
                    style: AppTextStyles.regular16.copyWith(
                      color: AppColors.lightGrey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  text: AppStrings.back.toUpperCase(),
                  style: AppTextStyles.regular16.copyWith(
                    color: AppColors.mediumGrey,
                  ),
                  onPressed: _currentPage == 0
                      ? null
                      : () {
                          setState(() {
                            _currentPage--;
                          });
                        },
                ),

                CustomButton(
                  text: _currentPage != 2
                      ? AppStrings.next.toUpperCase()
                      : AppStrings.getStarted.toUpperCase(),
                  style: AppTextStyles.regular16.copyWith(
                    color: AppColors.whiteColor,
                  ),
                  backgroundColor: AppColors.secondColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  onPressed: () {
                    if (_currentPage < length - 1) {
                      setState(() {
                        _currentPage++;
                      });
                    } else {
                      Navigator.pushNamed(context, AppRoutes.intro);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
