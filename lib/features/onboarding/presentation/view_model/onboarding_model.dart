import 'package:todo/core/constants/app_assets.dart';
import 'package:todo/core/constants/app_strings.dart';

class OnboardingModel {
  final String image;
  final String title;
  final String body;

  OnboardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnboardingViewModel {
  static final List<OnboardingModel> onboardingData = [
    OnboardingModel(
      image: Assets.assetsImagesOnboarding1,
      title: AppStrings.manageYourTasks,
      body: AppStrings.youCanEasily,
    ),
    OnboardingModel(
      image: Assets.assetsImagesOnboarding2,
      title: AppStrings.createDailyRoutine,
      body: AppStrings.inUptodo,
    ),
    OnboardingModel(
      image: Assets.assetsImagesOnboarding3,
      title: AppStrings.orgonaizeYourTasks,
      body: AppStrings.youCanOrganize,
    ),
  ];
}