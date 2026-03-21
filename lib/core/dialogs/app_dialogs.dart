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

  static Future<bool?> showDeleteDialog(
    BuildContext context, {
    required String title,
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: AppColors.mediumGrey,
          title: Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: AppColors.redColor,
                size: 28,
              ),
              const SizedBox(width: 8),
              Text(
                "Confirm Delete",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.whiteColor,
                ),
              ),
            ],
          ),
          content: RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 17, color: AppColors.lightGrey2),
              children: [
                const TextSpan(text: "Are you sure you want to delete "),
                TextSpan(
                  text: title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.redColor,
                  ),
                ),
                const TextSpan(text: "?"),
              ],
            ),
          ),
          actionsPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(
                "Cancel",
                style: TextStyle(color: AppColors.lightGrey2),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.redColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () => Navigator.pop(context, true),
              child: const Text(
                "Delete",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
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

  