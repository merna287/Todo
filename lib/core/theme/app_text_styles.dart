import 'package:flutter/material.dart';

class AppTextStyles {
  static const String _regular = "Lato-Regular";
  static const String _bold = "Lato-Bold";

  static TextStyle _style({
    required double size,
    required String family,
  }) {
    return TextStyle(
      fontFamily: family,
      fontSize: size,
    );
  }

  static final regular12 = _style(size: 12, family: _regular);
  static final regular14 = _style(size: 14, family: _regular);
  static final regular16 = _style(size: 16, family: _regular);
  static final regular20 = _style(size: 20, family: _regular);

  static final bold16 = _style(size: 16, family: _bold);
  static final bold32 = _style(size: 32, family: _bold);
}