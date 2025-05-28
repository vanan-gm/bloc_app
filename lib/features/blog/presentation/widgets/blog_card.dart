import 'package:bloc_app/core/common/extesions/localization_ext.dart';
import 'package:bloc_app/core/common/extesions/string_ext.dart';
import 'package:bloc_app/core/common/widgets/cached_network_img.dart';
import 'package:bloc_app/core/common/widgets/custom_shimmer.dart';
import 'package:bloc_app/core/common/widgets/ripple_effect.dart';
import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/core/enums/card_type.dart';
import 'package:bloc_app/core/theme/app_colors.dart';
import 'package:bloc_app/core/theme/app_pallete.dart';
import 'package:bloc_app/features/blog/domain/entities/blog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  final VoidCallback onTap;
  final CardType cardType;
  final EdgeInsets? padding;

  const BlogCard({
    super.key,
    required this.blog,
    required this.onTap,
    this.cardType = CardType.vertical,
    this.padding,
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
                              style: Theme.of(context).textTheme.bodySmall,
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
                    ),
                  ),
                ],
              ),
              Text(
                '${blog.content.toReadingTime()} ${context.translate.mins}',
                style: Theme.of(context).textTheme.bodySmall,
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
                    color: AppColors.whiteColor.withValues(alpha: .8),
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
