import 'package:bloc_app/core/common/extensions/buildcontext_ext.dart';
import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingBlogWidget extends StatelessWidget {
  const LoadingBlogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.grey,
      highlightColor: AppColors.black.withValues(alpha: .6),
      child: Container(
        width: AppConstants.widthScreen,
        height: AppConstants.containerCardHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.borderImage),
          color:
              context.isLightMode
                  ? AppColors.black.withValues(alpha: .6)
                  : AppColors.white.withValues(alpha: .2),
        ),
        margin: EdgeInsets.only(bottom: AppConstants.paddingSmall),
        padding: EdgeInsets.all(AppConstants.paddingSmall),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder:
                    (context, i) => Container(
                      width: 85,
                      height: 10,
                      margin: EdgeInsets.only(right: AppConstants.paddingTiny),
                      decoration: BoxDecoration(
                        color: AppColors.grey,
                        borderRadius: BorderRadius.circular(
                          AppConstants.borderSmall,
                        ),
                      ),
                    ),
              ),
            ),
            Container(
              width: AppConstants.widthScreen,
              height: 20,
              margin: EdgeInsets.only(top: AppConstants.paddingTiny),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppConstants.borderSmall),
                color: AppColors.grey,
              ),
            ),
            Container(
              width: AppConstants.widthScreen * .4,
              height: 20,
              margin: EdgeInsets.only(top: AppConstants.paddingSuperTiny),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppConstants.borderSmall),
                color: AppColors.grey,
              ),
            ),
            Spacer(),
            Container(
              width: AppConstants.widthScreen * .2,
              height: 20,
              margin: EdgeInsets.only(top: AppConstants.paddingSuperTiny),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppConstants.borderSmall),
                color: AppColors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
