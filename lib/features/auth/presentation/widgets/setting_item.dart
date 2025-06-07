import 'package:bloc_app/core/common/extesions/buildcontext_ext.dart';
import 'package:bloc_app/core/common/extesions/object_ext.dart';
import 'package:bloc_app/core/common/widgets/ripple_effect.dart';
import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget child;
  final double? width;
  final AlignmentGeometry? alignment;

  const SettingsItem({
    super.key,
    required this.child,
    this.onTap,
    this.width,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppConstants.paddingSuperTiny),
      child:
          onTap.isNotNull
              ? RippleEffect(onTap: onTap, child: buildChild(context))
              : buildChild(context),
    );
  }

  Widget buildChild(BuildContext context) => Container(
    width: width,
    padding: EdgeInsets.symmetric(
      horizontal: AppConstants.paddingSmall,
      vertical: AppConstants.paddingSmall,
    ),
    decoration: BoxDecoration(
      color:
          context.isLightMode
              ? AppColors.white
              : AppColors.gradient1.withValues(alpha: .15),
      borderRadius: BorderRadius.circular(AppConstants.borderImage),
      boxShadow:
          context.isLightMode
              ? [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: .2),
                  blurRadius: .2,
                  spreadRadius: .2,
                  offset: const Offset(.5, .5),
                ),
              ]
              : null,
    ),
    alignment: alignment,
    child: child,
  );
}
