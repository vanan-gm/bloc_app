import 'dart:ui';

import 'package:bloc_app/core/common/extesions/date_time_ext.dart';
import 'package:bloc_app/core/common/extesions/string_ext.dart';
import 'package:bloc_app/core/common/widgets/custom_shimmer.dart';
import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/core/theme/app_colors.dart';
import 'package:bloc_app/features/blog/domain/entities/blog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogDetailPage extends StatefulWidget {
  final Blog blog;

  static route({required Blog blog}) =>
      CupertinoPageRoute(builder: (_) => BlogDetailPage(blog: blog));

  const BlogDetailPage({super.key, required this.blog});

  @override
  State<BlogDetailPage> createState() => _BlogDetailPageState();
}

class _BlogDetailPageState extends State<BlogDetailPage> {
  final ScrollController _scrollController = ScrollController();
  bool _showFloatingButton = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels > 55) {
        _showFloatingButton = true;
      } else {
        _showFloatingButton = false;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Scrollbar(
          controller: _scrollController,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Padding(
              padding: EdgeInsets.all(AppConstants.paddingSmall),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.blog.title,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: AppConstants.textBigSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: AppConstants.paddingSmall,
                      bottom: AppConstants.paddingTiny,
                    ),
                    child: Text(
                      'By ${widget.blog.posterName}',
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: AppConstants.textMediumSize,
                      ),
                    ),
                  ),
                  Text(
                    '${widget.blog.updatedAt.formatDMY()}. ${widget.blog.content.toReadingTime()} mins',
                    style: TextStyle(
                      color: AppColors.white.withOpacity(.8),
                      fontSize: AppConstants.textMediumSize,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: AppConstants.paddingSmall,
                    ),
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(AppConstants.borderImage),
                      child: CachedNetworkImage(
                        imageUrl: widget.blog.imageUrl,
                        fit: BoxFit.cover,
                        width: AppConstants.widthScreen,
                        height: AppConstants.containerCardHeight,
                        placeholder: (context, url) => CustomShimmer(
                          width: AppConstants.widthScreen,
                          height: AppConstants.containerCardHeight,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    widget.blog.content,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: AppConstants.textSmallSize,
                      wordSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: _showFloatingButton,
        child: FloatingActionButton(
          onPressed: () => _scrollController.animateTo(
            0.0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeIn,
          ),
          backgroundColor: AppColors.black.withOpacity(.7),
          mini: true,
          shape: const CircleBorder(),
          child: const RotatedBox(
            quarterTurns: 1,
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
