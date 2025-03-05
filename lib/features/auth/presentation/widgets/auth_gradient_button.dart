import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/core/theme/app_colors.dart';
import 'package:bloc_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AuthGradientButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Stream<bool>? stream;

  const AuthGradientButton(
      {super.key, required this.onPressed, required this.text, this.stream});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        return Container(
          decoration: BoxDecoration(
            gradient: stream != null
                ? snapshot.error == null && snapshot.data != null
                    ? gGradientColor
                    : null
                : gGradientColor,
            color: stream != null
                ? snapshot.error == null && snapshot.data != null
                    ? gColor
                    : null
                : gColor,
            borderRadius: BorderRadius.circular(AppConstants.borderImage),
          ),
          child: ElevatedButton(
            onPressed: stream != null
                ? snapshot.error == null && snapshot.data != null
                    ? onPressed
                    : null
                : onPressed,
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(400, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.0),
              ),
              backgroundColor: AppPallete.transparentColor,
              shadowColor: AppPallete.transparentColor,
            ),
            child: Text(
              text,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
          ),
        );
      },
    );
  }

  Gradient get gGradientColor => const LinearGradient(colors: [
        AppPallete.gradient1,
        AppPallete.gradient2,
      ], begin: Alignment.bottomLeft, end: Alignment.topRight);

  Color get gColor => AppColors.greyColor;
}
