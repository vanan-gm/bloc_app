import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:bloc_app/core/common/widgets/custom_shimmer.dart';
import 'package:bloc_app/core/constants/app_constants.dart';

class CachedNetworkImg extends StatelessWidget {
  final double? imageRadius;
  final String imageUrl;
  final double? width;
  final double? height;
  const CachedNetworkImg({super.key, this.imageRadius, required this.imageUrl, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(imageRadius ?? AppConstants.borderImage),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        placeholder: (context, url) => CustomShimmer(
          width: width ?? AppConstants.widthScreen,
          height: height ?? AppConstants.containerCardHeight,
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        height: height ?? AppConstants.containerCardHeight,
        width: width ?? AppConstants.widthScreen,
      ),
    );
  }
}
