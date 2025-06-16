import 'package:bloc_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  final double width;
  final double height;
  const CustomShimmer({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: AppColors.grey,
      child: Shimmer.fromColors(
        baseColor: AppColors.grey.withValues(alpha: .5),
        highlightColor: AppColors.black.withValues(alpha: .5),
        child: const SizedBox(),
      ),
    );
  }
}
