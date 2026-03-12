import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:todo/core/constants/app_strings.dart';
import 'package:todo/core/dialogs/app_dialogs.dart';
import 'package:todo/core/dialogs/app_toasts.dart';
import 'package:todo/core/errors/failure.dart';
import 'package:todo/core/network/result_api.dart';
import 'package:todo/core/routing/app_router.dart';
import 'package:todo/core/theme/app_colors.dart';
import 'package:todo/core/theme/app_text_styles.dart';
import 'package:todo/core/utils/app_validator.dart';
import 'package:todo/core/common/widgets/buttons.dart';
import 'package:todo/core/common/widgets/text_form_field_widget.dart';
import 'package:todo/features/auth/presentation/models/login_response.dart';
import 'package:todo/features/auth/presentation/view_model/auth_view_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isRequestRunning = false;

  final AuthViewModel _viewModel = AuthViewModel();

  @override
  void initState() {
    super.initState();
    _clearFields();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Text(
                  AppStrings.login,
                  style: AppTextStyles.bold32.copyWith(
                    color: AppColors.whiteColor,
                  ),
                ),
                const SizedBox(height: 53),
                TextFormFieldWidget(
                  label: AppStrings.email,
                  controller: emailController,
                  fillColor: AppColors.darkGrey,
                  hint: AppStrings.enterYourEmail,
                  keyboardType: TextInputType.emailAddress,
                  myValidator: ValidatorApp.validateEmail,
                ),
                const SizedBox(height: 26),
                TextFormFieldWidget(
                  label: AppStrings.password,
                  fillColor: AppColors.darkGrey,
                  controller: passwordController,
                  obscureText: true,
                  myValidator: ValidatorApp.validatePassword,
                ),
                const SizedBox(height: 71),
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
                      if (_formKey.currentState!.validate()) {
                        _login();
                      }
                    },
                  ),
                ),
                const Spacer(),
                Center(
                  child: InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, AppRoutes.register),
                    child: Text.rich(
                      TextSpan(
                        text: AppStrings.doNotHaveAnAccount,
                        style: AppTextStyles.regular16.copyWith(
                          color: AppColors.mediumGrey,
                        ),
                        children: [
                          TextSpan(
                            text: AppStrings.register,
                            style: AppTextStyles.regular16.copyWith(
                              color: AppColors.deepPurple
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _login() async {
    if (_isRequestRunning) return;
    _isRequestRunning = true;

    AppDialogs.showLoadingDialog(context);

    final Result<LoginResponse> result = await _viewModel.login(
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    if (!mounted) return;
    AppDialogs.hideLoading(context);
    _isRequestRunning = false;

    if (result is SuccessAPI<LoginResponse>) {
      AppToast.showToast(
        context: context,
        title: AppStrings.success,
        description: AppStrings.loginSuccessful,
        type: ToastificationType.success,
      );

      Navigator.pushNamed(context, AppRoutes.main);
    } else if (result is ErrorAPI<LoginResponse>) {
      AppDialogs.showErrorDialog(context, result.failure.userMessage);
    }
  }

  void _clearFields() {
    emailController.clear();
    passwordController.clear();

    _formKey.currentState?.reset();
  }
}
