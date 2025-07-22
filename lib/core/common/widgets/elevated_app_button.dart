import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ElevatedAppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final double? borderRadius;
  final Size? buttonSize;
  final String buttonText;
  final TextStyle? textStyle;
  final Color? shadowColor;
  const ElevatedAppButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.backgroundColor,
    this.shadowColor,
    this.borderRadius,
    this.buttonSize,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.gradient1,
        shadowColor: shadowColor ?? AppColors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            borderRadius ?? AppConstants.borderButton,
          ),
        ),
        fixedSize: buttonSize,
      ),
      child: Text(
        buttonText,
        style:
            textStyle ??
            Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            ),
      ),
    );
  }
}
