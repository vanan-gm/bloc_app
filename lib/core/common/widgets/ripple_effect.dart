import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class RippleEffect extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final double? radius;
  const RippleEffect({super.key, required this.child, required this.onTap, this.padding, this.radius});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned.fill(
          child: Material(
            color: AppColors.transparentColor,
            borderRadius: BorderRadius.circular(radius ?? AppConstants.borderButton),
            child: Container(
              margin: padding,
              child: InkWell(
                onTap: onTap,
                splashColor: Colors.white.withValues(alpha: 0.1), // Custom splash color
                highlightColor: Colors.white.withValues(alpha: 0.2), // Custom highlight color
                borderRadius: BorderRadius.circular(radius ?? AppConstants.borderButton), // Custom border radius
              ),
            ),
          ),
        ),
      ],
    );
  }
}