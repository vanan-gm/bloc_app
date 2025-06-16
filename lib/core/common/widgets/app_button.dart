import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/core/theme/app_colors.dart';
import 'package:bloc_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String? text;
  final Widget? child;
  final VoidCallback onPressed;
  final Color? color;
  final double? width;
  final double? height;
  final Stream<bool>? stream;

  const AppButton._({
    Key? key,
    required this.text,
    required this.onPressed,
    this.child,
    this.color,
    this.width,
    this.height,
    this.stream,
  }) : super(key: key);

  /// Text-only button
  factory AppButton.text({
    required String text,
    required VoidCallback onPressed,
    Color? color,
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
    );
  }

  /// Icon + text button
  factory AppButton.child({
    required Widget child,
    required VoidCallback onPressed,
    String? text,
    Color? color,
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
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        return Container(
          decoration: BoxDecoration(
            gradient:
                stream != null
                    ? snapshot.error == null && snapshot.data != null
                        ? snapshot.data!
                            ? gGradientColor
                            : null
                        : null
                    : null,
            color:
                stream != null
                    ? snapshot.error == null && snapshot.data != null
                        ? snapshot.data!
                            ? gColor
                            : null
                        : null
                    : null,
            borderRadius: BorderRadius.circular(AppConstants.borderImage),
          ),
          child: ElevatedButton(
            onPressed:
                stream != null
                    ? snapshot.error == null && snapshot.data != null
                        ? snapshot.data!
                            ? onPressed
                            : null
                        : null
                    : null,
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(400, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.0),
              ),
              backgroundColor: AppPallete.transparentColor,
              shadowColor: AppPallete.transparentColor,
            ),
            child:
                child ??
                Text(
                  text ?? "",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
                ),
          ),
        );
      },
    );
  }

  Gradient get gGradientColor => const LinearGradient(
    colors: [AppPallete.gradient1, AppPallete.gradient2],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  );

  Color get gColor => AppColors.grey;
}
