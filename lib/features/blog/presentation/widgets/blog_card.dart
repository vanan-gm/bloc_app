import 'package:bloc_app/core/common/extensions/buildcontext_ext.dart';
import 'package:bloc_app/core/common/extensions/localization_ext.dart';
import 'package:bloc_app/core/common/extensions/string_ext.dart';
import 'package:bloc_app/core/common/widgets/cached_network_img.dart';
import 'package:bloc_app/core/common/widgets/ripple_effect.dart';
import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/core/enums/card_type.dart';
import 'package:bloc_app/core/theme/app_colors.dart';
import 'package:bloc_app/features/blog/domain/entities/blog.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  final VoidCallback onTap;
  final CardType cardType;
  final EdgeInsets? padding;
  final Color? chipBackgroudColor;
  final Color? chipTextColor;

  const BlogCard({
    super.key,
    required this.blog,
    required this.onTap,
    this.cardType = CardType.vertical,
    this.padding,
    this.chipBackgroudColor,
    this.chipTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: RippleEffect(
        onTap: onTap,
        child:
            cardType == CardType.vertical
                ? buildVertical(context)
                : buildHorizontal(context),
      ),
    );
  }

  Widget buildVertical(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImg(imageUrl: blog.imageUrl),
        Container(
          height: AppConstants.containerCardHeight,
          width: AppConstants.widthScreen,
          padding: EdgeInsets.all(AppConstants.paddingSmall),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstants.borderImage),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: blog.topics.length,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: EdgeInsets.only(
                            right: AppConstants.paddingSmall,
                          ),
                          child: Chip(
                            label: Text(
                              blog.topics[i],
                              style: Theme.of(
                                context,
                              ).textTheme.bodySmall!.copyWith(
                                color:
                                    chipTextColor ??
                                    (context.isLightMode
                                        ? AppColors.gradient1
                                        : AppColors.white),
                              ),
                            ),
                            backgroundColor:
                                chipBackgroudColor ??
                                (context.isLightMode
                                    ? AppColors.white
                                    : AppColors.gradient1),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: AppColors.transparent),
                              borderRadius: BorderRadius.circular(
                                AppConstants.borderSmall,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Text(
                    blog.title,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
              Text(
                '${blog.content.toReadingTime()} ${context.translate.mins}',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall!.copyWith(color: AppColors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildHorizontal(BuildContext context) {
    return Row(
      children: [
        CachedNetworkImg(imageUrl: blog.imageUrl, width: 150, height: 100),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: AppConstants.paddingTiny),
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  blog.title,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "Read more  >",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color:
                        context.isLightMode
                            ? AppColors.black.withValues(alpha: .8)
                            : AppColors.white.withValues(alpha: .8),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
