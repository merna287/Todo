import 'package:flutter/material.dart';
import 'package:todo/core/theme/app_colors.dart';

typedef Validator = String? Function(String?);

class TextFormFieldWidget extends StatefulWidget {
  const TextFormFieldWidget({
    super.key,
    this.label,
    required this.controller,
    required this.myValidator,
    this.keyboardType = TextInputType.text,
    this.hint,
    this.obscureText = false,
    this.isPassword = false,
    this.widthBorder = 1.0,
    this.prefixIcon,
    this.fillColor,
  });

  final String? label;
  final String? hint;
  final Color? fillColor;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool isPassword;
  final TextEditingController controller;
  final Validator myValidator;
  final double widthBorder;
  final Widget? prefixIcon;

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  late bool _isHidden;
  bool _isTouched = false;

  @override
  void initState() {
    super.initState();
    _isHidden = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label ?? "",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.lightGrey,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          obscureText: widget.isPassword && _isHidden,
          validator: (value) {
            if (!_isTouched) return null;
            return widget.myValidator(value);
          },
          onChanged: (_) {
            if (!_isTouched) {
              setState(() {
                _isTouched = true;
              });
            }
          },
          style: TextStyle(color: AppColors.lightGrey, fontSize: 16),
          decoration: InputDecoration(
            filled: widget.fillColor != null,
            fillColor: widget.fillColor,
            hintText: widget.hint ?? widget.label,
            hintStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: AppColors.mediumGrey,
            ),
            errorStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _isHidden ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _isHidden = !_isHidden;
                      });
                    },
                  )
                : null,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Color(0xffBEBEBE),
                width: widget.widthBorder,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColors.secondColor),
            ),
          ),
        ),
      ],
    );
  }
}
