import 'package:bloc_app/core/common/extesions/localization_ext.dart';
import 'package:bloc_app/core/common/widgets/app_icon.dart';
import 'package:bloc_app/generated/assets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/core/theme/app_colors.dart';

class AppDialog {
  AppDialog._();

  static bool _isShowingLoading = false;

  static void showLoadingDialog({required BuildContext context}) {
    if (_isShowingLoading) return;
    _isShowingLoading = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: AppConstants.paddingHuge,
                ),
                child: Center(
                  child: CircularProgressIndicator(color: AppColors.gradient1),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static void hideLoadingDialog(BuildContext context) {
    if (_isShowingLoading) {
      _isShowingLoading = false;
      Navigator.of(context).pop();
    }
  }

  static void showSignOutDialog({
    required BuildContext context,
    required VoidCallback onBack,
    required VoidCallback onOk,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.whiteColor,
          title: Text(
            context.translate.logoutOfYourAccount,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                context.translate.logoutWarning,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(color: AppColors.black),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: onBack,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.transparentColor,
                shadowColor: AppColors.transparentColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppConstants.borderButton,
                  ),
                ),
              ),
              child: Text(
                context.translate.cancel,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: onOk,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppConstants.borderButton,
                  ),
                ),
              ),
              child: Text(
                context.translate.logout,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
          ],
          actionsAlignment: MainAxisAlignment.spaceAround,
        );
      },
    );
  }

  static void showFunctionInProgressDialog({
    required BuildContext context,
    required VoidCallback onOk,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.whiteColor,
          title: Text(
            context.translate.notification,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: AppColors.black,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppIcon.asset(
                Assets.iconsIcWarning,
                size: AppConstants.iconGiantSize,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppConstants.paddingSmall,
                ).copyWith(top: AppConstants.paddingSmall),
                child: Text(
                  context.translate.featureInProgressMessage,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(color: AppColors.black),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: onOk,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.gradient1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppConstants.borderButton,
                  ),
                ),
              ),
              child: Text(
                context.translate.ok,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
          ],
          actionsAlignment: MainAxisAlignment.center,
        );
      },
    );
  }

  static void showImageViewerDialog({
    required BuildContext context,
    required String imageUrl,
  }) {
    showImageViewer(
      context,
      CachedNetworkImageProvider(imageUrl),
      barrierColor: AppColors.transparentColor,
    );
  }
}
