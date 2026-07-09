import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/constants/app_strings.dart';
import 'package:todo/core/services/auth_service.dart';
import 'package:todo/core/routing/app_router.dart';
import 'package:todo/core/theme/app_colors.dart';
import 'package:todo/core/theme/app_text_styles.dart';
import 'package:todo/features/profile/model/profile_menu_item_data.dart';
import 'package:todo/features/profile/model_view/profile_view_model.dart';
import 'package:todo/features/profile/widget/profile_avatar.dart';
import 'package:todo/features/profile/widget/profile_logout_button.dart';
import 'package:todo/features/profile/widget/profile_section.dart';
import 'package:todo/features/profile/widget/show_change_name.dart';
import 'package:todo/features/profile/widget/show_change_password.dart';
import 'package:todo/features/profile/widget/statistic_card.dart';
import 'package:todo/features/home/presentation/view_model/task_view_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileViewModel>().fetchProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileVm = context.watch<ProfileViewModel>();
    final taskVm = context.watch<TaskViewModel>();

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ProfileAvatar(radius: 50),
              const SizedBox(height: 16),

              Text(
                profileVm.user?.name ?? "User",
                style: AppTextStyles.bold16.copyWith(
                  color: AppColors.whiteColor,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: StatisticCard(
                      label: "Remaining",
                      count: taskVm.tasks
                          .where((task) => !task.completed)
                          .length,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: StatisticCard(
                      label: "Completed",
                      count: taskVm.tasks
                          .where((task) => task.completed)
                          .length,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ProfileSection(
                sectionTitle: AppStrings.settings,
                items: [
                  ProfileMenuItemData(
                    icon: Icons.settings_outlined,
                    title: 'App Settings',
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.appSettings);
                    },
                  ),
                ],
              ),
              ProfileSection(
                sectionTitle: AppStrings.account,
                items: [
                  ProfileMenuItemData(
                    icon: Icons.person_outline,
                    title: 'Change account name',
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => const ShowChangeName(),
                      );
                    },
                  ),
                  ProfileMenuItemData(
                    icon: Icons.lock_outline,
                    title: 'Change account password',
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => const ShowChangePassword(),
                      );
                    },
                  ),
                  ProfileMenuItemData(
                    icon: Icons.image_outlined,
                    title: 'Change account image',
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.changeAccountImage,
                      );
                    },
                  ),
                ],
              ),
              ProfileSection(
                sectionTitle: AppStrings.uptodo,
                items: [
                  ProfileMenuItemData(
                    icon: Icons.info_outline,
                    title: 'About Us',
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.aboutUs);
                    },
                  ),
                  ProfileMenuItemData(
                    icon: Icons.help_outline,
                    title: 'FAQ',
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.faq);
                    },
                  ),
                  ProfileMenuItemData(
                    icon: Icons.feedback_outlined,
                    title: 'Help & Feedback',
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.helpFeedback);
                    },
                  ),
                  ProfileMenuItemData(
                    icon: Icons.support_agent_outlined,
                    title: 'Support Us',
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.supportUs);
                    },
                  ),
                ],
              ),
              ProfileLogoutButton(
                onTap: () async {
                  final navigator = Navigator.of(context);
                  await AuthService.instance.clearSession();

                  if (!mounted) return;
                  navigator.pushNamedAndRemoveUntil(
                    AppRoutes.login,
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
