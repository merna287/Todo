import 'package:flutter/material.dart';
import 'package:todo/core/theme/app_colors.dart';

abstract class AppDialogs {
  static void showLoadingDialog(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return PopScope(
            canPop: false,
            child: AlertDialog(
              backgroundColor: AppColors.primaryColor,
              content: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(color: AppColors.whiteColor),
                  const SizedBox(width: 16),
                  Text(
                    'Loading...',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  static void hideLoading(BuildContext context) {
  if (Navigator.canPop(context)) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}

  static void showErrorDialog(BuildContext context, String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => _ErrorDialog(message: message),
      );
    });
  }
}

class _ErrorDialog extends StatelessWidget {
  final String message;

  const _ErrorDialog({required this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.darkGrey,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error, color: AppColors.errorRed, size: 40),
            const SizedBox(height: 12),
            Text(
              message,
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 22),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
