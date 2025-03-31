import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

void showCustomOverlay({required BuildContext context, String content = 'Success', bool isSuccessType = true}) {
  OverlayState overlayState = Overlay.of(context);
  late OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      bottom: 20,
      left: isSuccessType ? 50 : 70,
      right: isSuccessType ? 50 : 70,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(AppConstants.paddingTiny),
          decoration: BoxDecoration(
            color: isSuccessType ? AppColors.green : AppColors.red,
            borderRadius: BorderRadius.circular(AppConstants.borderWide),
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(isSuccessType ? Icons.check : Icons.close, color: AppColors.white),
              Padding(
                padding: EdgeInsets.only(left: AppConstants.paddingSmall),
                child: Text(
                  content,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );

  overlayState.insert(overlayEntry);

  // Remove the utils after 2 seconds
  Future.delayed(const Duration(seconds: 2), () {
    overlayEntry.remove();
  });
}
