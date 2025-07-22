import 'package:flutter/material.dart';
import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/core/theme/app_colors.dart';

class AppButton extends StatelessWidget {
  final String? text;
  final Widget? child;
  final VoidCallback onPressed;
  final Color? color;
  final double? width;
  final double? height;
  final Stream<bool>? stream;
  final Color? textColor;

  const AppButton._({
    Key? key,
    required this.text,
    required this.onPressed,
    this.child,
    this.color,
    this.width,
    this.height,
    this.stream,
    this.textColor,
  }) : super(key: key);

  factory AppButton.text({
    required String text,
    required VoidCallback onPressed,
    Color? color,
    Color? textColor,
    double? width,
    double? height,
    Stream<bool>? stream,
  }) {
    return AppButton._(
      text: text,
      onPressed: onPressed,
      color: color,
      width: width,
      height: height,
      stream: stream,
      textColor: textColor,
    );
  }

  factory AppButton.child({
    required Widget child,
    required VoidCallback onPressed,
    String? text,
    Color? color,
    Color? textColor,
    double? width,
    double? height,
    Stream<bool>? stream,
  }) {
    return AppButton._(
      text: text,
      onPressed: onPressed,
      color: color,
      width: width,
      height: height,
      stream: stream,
      textColor: textColor,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return stream != null
        ? StreamBuilder<bool>(
          stream: stream,
          builder: (context, snapshot) {
            final enabled = snapshot.data ?? false;
            return _buildButton(context, enabled: enabled);
          },
        )
        : _buildButton(context, enabled: true);
  }

  Widget _buildButton(BuildContext context, {required bool enabled}) {
    final Size buttonSize = Size(
      width ?? AppConstants.defaultButtonWidth,
      height ?? AppConstants.defaultButtonHeight,
    );
    final Gradient? gradient = stream != null && enabled ? _gradient : null;
    final Color? backgroundColor =
        stream != null && enabled ? null : color ?? AppColors.grey;

    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        color: gradient == null ? backgroundColor : null,
        borderRadius: BorderRadius.circular(AppConstants.borderImage),
      ),
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          fixedSize: buttonSize,
          backgroundColor: AppColors.transparent,
          shadowColor: AppColors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderButton),
          ),
        ),
        child:
            child ??
            Text(
              text ?? '',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: textColor ?? AppColors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
      ),
    );
  }

  Gradient get _gradient => const LinearGradient(
    colors: [AppColors.gradient1, AppColors.gradient2],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  );
}
