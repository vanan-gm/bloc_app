import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:bloc_app/core/common/widgets/ripple_effect.dart';
import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/core/theme/app_colors.dart';

class CircleAvatarImage extends StatelessWidget {
  final String image;
  final double radius;
  final VoidCallback? onTap;
  const CircleAvatarImage({
    super.key,
    required this.image,
    required this.radius,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return RippleEffect(
      onTap: onTap,
      radius: AppConstants.borderRound,
      child: CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(image),
        backgroundColor: AppColors.white,
        radius: radius,
      ),
    );
  }
}
