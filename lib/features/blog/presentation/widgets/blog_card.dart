import 'package:bloc_app/core/common/extesions/string_ext.dart';
import 'package:bloc_app/core/common/widgets/custom_shimmer.dart';
import 'package:bloc_app/core/common/widgets/ripple_effect.dart';
import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/features/blog/domain/entities/blog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  final VoidCallback onTap;
  const BlogCard({
    super.key,
    required this.blog,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return RippleEffect(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(AppConstants.paddingSmall).copyWith(
          bottom: AppConstants.paddingTiny,
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppConstants.borderImage),
              child: CachedNetworkImage(
                imageUrl: blog.imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => CustomShimmer(
                  width: AppConstants.widthScreen,
                  height: AppConstants.containerCardHeight,
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                height: AppConstants.containerCardHeight,
                width: AppConstants.widthScreen,
              ),
            ),
            Container(
              height: AppConstants.containerCardHeight,
              width: AppConstants.widthScreen,
              padding: EdgeInsets.all(AppConstants.paddingSmall),
              decoration: BoxDecoration(
                // image: DecorationImage(image: CachedNetworkImageProvider(blog.imageUrl)),
                borderRadius: BorderRadius.circular(AppConstants.borderImage),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: blog.topics
                              .map(
                                (e) => Padding(
                                  padding:
                                      EdgeInsets.all(AppConstants.paddingSmall)
                                          .copyWith(left: 0.0, top: 0.0),
                                  child: Chip(
                                    label: Text(e),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      Text(
                        blog.title,
                        maxLines: 2,
                        style: const TextStyle(
                          fontSize: AppConstants.textLargeSize,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  Text('${blog.content.toReadingTime()} mins'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
