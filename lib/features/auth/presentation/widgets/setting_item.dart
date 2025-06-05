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
              ? RippleEffect(onTap: onTap, child: buildChild)
              : buildChild,
    );
  }

  Widget get buildChild => Container(
    width: width,
    padding: EdgeInsets.symmetric(
      horizontal: AppConstants.paddingSmall,
      vertical: AppConstants.paddingSmall,
    ),
    decoration: BoxDecoration(
      color: AppColors.gradient1.withValues(alpha: .15),
      // border: Border.all(color: AppColors.gradient1, width: 1.0),
      borderRadius: BorderRadius.circular(AppConstants.borderImage),
    ),
    alignment: alignment,
    child: child,
  );
}
