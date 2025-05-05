import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/core/theme/app_colors.dart';

class AppDialog {
  AppDialog._();

  static bool _isShowingLoading = false;

  static void showLoadingDialog({required BuildContext context}){
    if(_isShowingLoading) return;
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
                padding: EdgeInsets.symmetric(vertical: AppConstants.paddingHuge),
                child: Center(child: CircularProgressIndicator(color: AppColors.gradient1,),),
              ),
            ],
          )
        );
      },
    );
  }

  static void hideLoadingDialog(BuildContext context){
    if(_isShowingLoading){
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
            'Log Out of Your Account?',
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
                'Logging out will temporarily hide all blogs. To see them again, log back in to your account.',
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
                "Cancel",
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
                "Logout",
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

  static void showImageViewerDialog({
    required BuildContext context,
    required String imageUrl,
  }) {
    showImageViewer(context, CachedNetworkImageProvider(imageUrl), barrierColor: AppColors.transparentColor);
  }
}
