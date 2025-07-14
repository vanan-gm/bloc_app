import 'package:bloc_app/core/common/extensions/localization_ext.dart';
import 'package:bloc_app/core/common/widgets/app_button.dart';
import 'package:bloc_app/core/common/widgets/app_icon.dart';
import 'package:bloc_app/core/common/widgets/app_text.dart';
import 'package:bloc_app/core/common/widgets/elevated_app_button.dart';
import 'package:bloc_app/core/common/widgets/two_text_row.dart';
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
          backgroundColor: AppColors.white,
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
            ElevatedAppButton(
              onPressed: onBack,
              backgroundColor: AppColors.transparent,
              buttonText: context.translate.cancel,
              textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            ElevatedAppButton(
              onPressed: onOk,
              backgroundColor: AppColors.red,
              buttonText: context.translate.logout,
              textStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.white,
              ),
            ),
            // ElevatedButton(
            //   onPressed: onBack,
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: AppColors.transparent,
            //     shadowColor: AppColors.transparent,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(
            //         AppConstants.borderButton,
            //       ),
            //     ),
            //   ),
            //   child: Text(
            //     context.translate.cancel,
            //     style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            //       color: AppColors.black,
            //       fontWeight: FontWeight.w700,
            //     ),
            //   ),
            // ),
            // ElevatedButton(
            //   onPressed: onOk,
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: AppColors.red,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(
            //         AppConstants.borderButton,
            //       ),
            //     ),
            //   ),
            //   child: Text(
            //     context.translate.logout,
            //     style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            //       fontWeight: FontWeight.w700,
            //       color: AppColors.white,
            //     ),
            //   ),
            // ),
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
          backgroundColor: AppColors.white,
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
            ElevatedAppButton(
              onPressed: onOk,
              buttonText: context.translate.ok,
              buttonSize: AppConstants.buttonDialogSize,
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
      barrierColor: AppColors.transparent,
    );
  }

  static void showAboutAppDialog({
    required BuildContext context,
    required VoidCallback onOk,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          content: SizedBox(
            width: AppConstants.widthScreen * .8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText(
                  text: "Blog App",
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w700),
                ),
                AppText(
                  text: '"${context.translate.aboutAppSlogan}"',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.black.withValues(alpha: .7),
                    fontStyle: FontStyle.italic,
                  ),
                  padding: EdgeInsets.only(top: AppConstants.paddingSuperTiny),
                ),
                TwoTextRow(
                  leftText: context.translate.version,
                  rightText: "1.1.1",
                  leftTextStyle: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(
                    color: AppColors.black.withValues(alpha: .5),
                    fontWeight: FontWeight.w600,
                  ),
                  rightTextStyle: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(
                    color: AppColors.black.withValues(alpha: .7),
                    fontWeight: FontWeight.w600,
                  ),
                  padding: EdgeInsets.only(top: AppConstants.paddingMedium),
                ),
                TwoTextRow(
                  leftText: context.translate.build,
                  rightText: "2025.06.16",
                  leftTextStyle: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(
                    color: AppColors.black.withValues(alpha: .5),
                    fontWeight: FontWeight.w600,
                  ),
                  rightTextStyle: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(
                    color: AppColors.black.withValues(alpha: .7),
                    fontWeight: FontWeight.w600,
                  ),
                  padding: EdgeInsets.only(top: AppConstants.paddingSmall),
                ),
                TwoTextRow(
                  leftText: context.translate.size,
                  rightText: "28.4 MB",
                  leftTextStyle: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(
                    color: AppColors.black.withValues(alpha: .5),
                    fontWeight: FontWeight.w600,
                  ),
                  rightTextStyle: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(
                    color: AppColors.black.withValues(alpha: .7),
                    fontWeight: FontWeight.w600,
                  ),
                  padding: EdgeInsets.only(top: AppConstants.paddingSmall),
                ),
                TwoTextRow(
                  leftText: context.translate.platform,
                  rightText: "IOS & Android",
                  leftTextStyle: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(
                    color: AppColors.black.withValues(alpha: .5),
                    fontWeight: FontWeight.w600,
                  ),
                  rightTextStyle: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(
                    color: AppColors.black.withValues(alpha: .7),
                    fontWeight: FontWeight.w600,
                  ),
                  padding: EdgeInsets.only(top: AppConstants.paddingSmall),
                ),
                TwoTextRow(
                  leftText: context.translate.minOsVersion,
                  rightText: "IOS 14.0 / Android 8.0",
                  leftTextStyle: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(
                    color: AppColors.black.withValues(alpha: .5),
                    fontWeight: FontWeight.w600,
                  ),
                  rightTextStyle: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(
                    color: AppColors.black.withValues(alpha: .7),
                    fontWeight: FontWeight.w600,
                  ),
                  padding: EdgeInsets.only(top: AppConstants.paddingSmall),
                ),
                TwoTextRow(
                  leftText: context.translate.license,
                  rightText: "MIT License",
                  leftTextStyle: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(
                    color: AppColors.black.withValues(alpha: .5),
                    fontWeight: FontWeight.w600,
                  ),
                  rightTextStyle: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(
                    color: AppColors.black.withValues(alpha: .7),
                    fontWeight: FontWeight.w600,
                  ),
                  padding: EdgeInsets.only(top: AppConstants.paddingSmall),
                ),
                TwoTextRow(
                  leftText: context.translate.designedBy,
                  rightText: "Van An",
                  leftTextStyle: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(
                    color: AppColors.black.withValues(alpha: .5),
                    fontWeight: FontWeight.w600,
                  ),
                  rightTextStyle: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(
                    color: AppColors.black.withValues(alpha: .7),
                    fontWeight: FontWeight.w600,
                  ),
                  padding: EdgeInsets.only(top: AppConstants.paddingSmall),
                ),
              ],
            ),
          ),
          actions: [
            ElevatedAppButton(
              onPressed: onOk,
              buttonText: context.translate.ok,
              buttonSize: AppConstants.buttonDialogSize,
            ),
          ],
          actionsAlignment: MainAxisAlignment.center,
        );
      },
    );
  }
}
