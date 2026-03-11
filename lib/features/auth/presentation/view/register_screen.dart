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
import 'package:todo/core/widgets/text_form_field_widget.dart';
import 'package:todo/features/auth/presentation/models/register_response.dart';
import 'package:todo/features/auth/presentation/view_model/auth_view_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  bool isPasswordHidden = true;
  bool isConfirmHidden = true;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _clearFields();
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  final AuthViewModel _viewModel = AuthViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 70),
                Text(
                  AppStrings.register,
                  style: AppTextStyles.bold32.copyWith(
                    color: AppColors.whiteColor
                  ),
                ),
                SizedBox(height: 23),
                TextFormFieldWidget(
                  label: AppStrings.username,
                  controller: usernameController,
                  fillColor: AppColors.darkGrey,
                  myValidator: ValidatorApp.validateName,
                ),
                const SizedBox(height: 16),
                TextFormFieldWidget(
                  label: AppStrings.email,
                  controller: emailController,
                  fillColor: AppColors.darkGrey,
                  keyboardType: TextInputType.emailAddress,
                  myValidator: ValidatorApp.validateEmail,
                ),
                const SizedBox(height: 16),
                TextFormFieldWidget(
                  label: AppStrings.password,
                  controller: passwordController,
                  fillColor: AppColors.darkGrey,
                  isPassword: true,
                  obscureText: true,
                  myValidator: ValidatorApp.validatePassword,
                ),
                SizedBox(height: 16),
                TextFormFieldWidget(
                  label: AppStrings.confirmPassword,
                  controller: confirmController,
                  fillColor: AppColors.darkGrey,
                  isPassword: true,
                  obscureText: true,
                  myValidator: (value) {
                    return ValidatorApp.validateConfirmPassword(
                      value,
                      passwordController.text,
                    );
                  },
                ),
                const SizedBox(height: 80),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _registerUser();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.secondColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      AppStrings.register,
                      style: AppTextStyles.regular16.copyWith(
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Center(
                  child: InkWell(
                    onTap: () => Navigator.pushNamed(context, AppRoutes.login),
                    child: Text.rich(
                      TextSpan(
                        text: AppStrings.alreadyHaveAnAccount,
                        style: AppTextStyles.regular16.copyWith(
                          color: AppColors.mediumGrey,
                        ),
                        children: [
                          TextSpan(
                            text: AppStrings.login,
                            style: AppTextStyles.regular16.copyWith(
                              color: AppColors.deepPurple,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 33),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _registerUser() async {
    if (isLoading) return;

    isLoading = true;

    AppDialogs.showLoadingDialog(context);

    final Result<RegisterResponse> result = await _viewModel.register(
      usernameController.text.trim(),
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    if (!mounted) return;

    AppDialogs.hideLoading(context);

    isLoading = false;

    if (result is SuccessAPI<RegisterResponse>) {
      AppToast.showToast(
        context: context,
        title: AppStrings.success,
        description: AppStrings.registerSuccessful,
        type: ToastificationType.success,
      );

      Navigator.pushNamed(context, AppRoutes.login);
    } else if (result is ErrorAPI<RegisterResponse>) {
      AppToast.showToast(
        context: context,
        title: AppStrings.error,
        description: result.failure.userMessage,
        type: ToastificationType.error,
      );
    }
  }
  void _clearFields() {
    passwordController.clear();
    confirmController.clear();
    usernameController.clear();

    _formKey.currentState?.reset();
  }
}
