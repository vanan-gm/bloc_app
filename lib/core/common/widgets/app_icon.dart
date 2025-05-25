import 'package:bloc_app/core/common/widgets/ripple_effect.dart';
import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  final IconData? icon;
  final Color? color;
  final double size;
  final VoidCallback? onClick;
  final EdgeInsets? margin;
  final double rippleRadius;
  String? path;

  AppIcon.icon(
    this.icon, {
    Key? key,
    this.color,
    this.size = AppConstants.iconMediumSize,
    this.margin,
    this.onClick,
    this.rippleRadius = AppConstants.borderButton2,
  }) : super(key: key);

  AppIcon.asset(
    this.path, {
    Key? key,
    this.color,
    this.size = AppConstants.iconMediumSmallSize,
    this.margin,
    this.onClick,
    this.rippleRadius = AppConstants.borderButton2,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget body() =>
        icon == null
            ? assetIcon()
            : Icon(
              icon,
              color: color ?? AppColors.transparentColor,
              size: size,
            );
    return margin == null
        ? onClick == null
            ? body()
            : RippleEffect(onTap: onClick, radius: rippleRadius, child: body())
        : Container(
          margin: margin,
          child:
              onClick == null
                  ? body()
                  : RippleEffect(
                    onTap: onClick,
                    radius: rippleRadius,
                    child: body(),
                  ),
        );
  }

  Widget assetIcon() => Image.asset(
    path!,
    width: size,
    height: size,
    color: color,
    colorBlendMode: BlendMode.srcIn,
  );
}
