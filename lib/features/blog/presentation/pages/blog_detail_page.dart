import 'package:bloc_app/core/common/extesions/buildcontext_ext.dart';
import 'package:bloc_app/core/common/extesions/date_time_ext.dart';
import 'package:bloc_app/core/common/extesions/localization_ext.dart';
import 'package:bloc_app/core/common/extesions/string_ext.dart';
import 'package:bloc_app/core/common/utils/app_dialog.dart';
import 'package:bloc_app/core/common/widgets/app_icon.dart';
import 'package:bloc_app/core/common/widgets/app_text.dart';
import 'package:bloc_app/core/common/widgets/app_text_painter.dart';
import 'package:bloc_app/core/common/widgets/circle_avatar_image.dart';
import 'package:bloc_app/core/common/widgets/custom_shimmer.dart';
import 'package:bloc_app/core/common/widgets/loading_widget.dart';
import 'package:bloc_app/core/common/widgets/ripple_effect.dart';
import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/core/enums/like_state.dart';
import 'package:bloc_app/core/enums/update_state_type.dart';
import 'package:bloc_app/core/theme/app_colors.dart';
import 'package:bloc_app/features/blog/domain/entities/blog.dart';
import 'package:bloc_app/features/blog/presentation/bloc/detail_bloc/blog_detail_bloc.dart';
import 'package:bloc_app/generated/assets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  final GlobalKey _key = GlobalKey();
  double _titleHeight = 0.0;
  bool _showFloatingButton = false;
  String _appBarTitle = '';
  String _userId = '';

  @override
  void initState() {
    super.initState();
    // Here we will calculate title height to handle display appbar title when user overscroll title blog
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBox =
          _key.currentContext?.findRenderObject() as RenderBox;
      setState(() {
        _titleHeight = renderBox.size.height;
      });
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels > _titleHeight) {
        _appBarTitle = widget.blog.title;
      } else {
        _appBarTitle = '';
      }
      if (_scrollController.position.pixels > 55) {
        _showFloatingButton = true;
      } else {
        _showFloatingButton = false;
      }
      setState(() {});
    });
    getBlogLikeState();
  }

  void getBlogLikeState() {
    if (!mounted) return;
    final userId = context.currentUserId;
    _userId = userId;
    context.read<BlogDetailBloc>().add(
      GetBlogLikeStateEvent(blogId: widget.blog.id, userId: userId),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: AnimatedOpacity(
          opacity: _appBarTitle.trim().isNotEmpty ? 1.0 : 0.0,
          duration: AppConstants.fadeDuration,
          curve: Curves.easeInOut,
          child: Text(
            _appBarTitle,
            style: Theme.of(
              context,
            ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        centerTitle: false,
      ),
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
                  AppText.padding(
                    text: widget.blog.title,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    key: _key,
                    padding: EdgeInsets.only(bottom: AppConstants.paddingTiny),
                  ),
                  categoryRenderWidget,
                  authorRenderWidget,
                  imageRenderWidget,
                  contentRenderWidget,
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: _showFloatingButton,
        child: FloatingActionButton(
          onPressed:
              () => _scrollController.animateTo(
                0.0,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeIn,
              ),
          backgroundColor: AppColors.black.withValues(alpha: .7),
          mini: true,
          shape: const CircleBorder(),
          child: const RotatedBox(
            quarterTurns: 1,
            child: Icon(Icons.arrow_back_ios_rounded, color: AppColors.white),
          ),
        ),
      ),
    );
  }

  Widget get contentRenderWidget {
    return AppTextPainter(
      text: widget.blog.content,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(wordSpacing: 1.5),
    );
  }

  Widget get categoryRenderWidget {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.blog.topics.length,
        itemBuilder: (context, i) {
          return Padding(
            padding: EdgeInsets.only(right: AppConstants.paddingSmall),
            child: Chip(
              label: Text(
                widget.blog.topics[i],
                style: Theme.of(
                  context,
                ).textTheme.bodySmall!.copyWith(color: AppColors.white),
              ),
              color: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
                return AppColors.gradient1;
              }),
            ),
          );
        },
      ),
    );
  }

  Widget get imageRenderWidget {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppConstants.paddingSmall),
      child: RippleEffect(
        onTap:
            () => AppDialog.showImageViewerDialog(
              context: context,
              imageUrl: widget.blog.imageUrl,
            ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppConstants.borderImage),
          child: CachedNetworkImage(
            imageUrl: widget.blog.imageUrl,
            fit: BoxFit.cover,
            width: AppConstants.widthScreen,
            height: AppConstants.containerCardHeight,
            placeholder:
                (context, url) => CustomShimmer(
                  width: AppConstants.widthScreen,
                  height: AppConstants.containerCardHeight,
                ),
          ),
        ),
      ),
    );
  }

  Widget get authorRenderWidget {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: AppConstants.paddingSmall,
            bottom: AppConstants.paddingTiny,
          ),
          child: Row(
            children: [
              if (widget.blog.posterImage.isNotEmptyOrNull())
                CircleAvatarImage(
                  image: widget.blog.posterImage ?? '',
                  radius: AppConstants.circleAvatarDetailPageSize,
                ),
              Padding(
                padding: EdgeInsets.only(left: AppConstants.paddingTiny),
                child: Text(
                  '${context.translate.by} ${widget.blog.posterName}',
                  style: const TextStyle(fontSize: AppConstants.textMediumSize),
                ),
              ),
              Spacer(),
              BlocBuilder<BlogDetailBloc, BlogDetailState>(
                builder: (context, state) {
                  if (state is BlogDetailLoadingState) {
                    return SizedBox(
                      width: AppConstants.loadingLikeIconSize,
                      height: AppConstants.loadingLikeIconSize,
                      child: LoadingWidget(
                        strokeWidth: AppConstants.loadingStrokeWidth,
                      ),
                    );
                  } else if (state is GetBlogDetailLikeStateSuccessState) {
                    return StatefulBuilder(
                      builder: (context, setSt) {
                        final liked = state.state == LikeState.liked;
                        return AppIcon.asset(
                          liked ? Assets.iconsIcFullHeart : Assets.iconsIcHeart,
                          color:
                              liked
                                  ? AppColors.red
                                  : (context.isLightMode
                                      ? AppColors.black
                                      : AppColors.white),
                          onClick: () {
                            context.read<BlogDetailBloc>().add(
                              UpdateBlogLikeStateEvent(
                                blogId: widget.blog.id,
                                userId: _userId,
                                type:
                                    liked
                                        ? UpdateStateType.removeLike
                                        : UpdateStateType.setLike,
                              ),
                            );
                          },
                        );
                      },
                    );
                  } else if (state is UpdateBlogDetailLikeStateSuccessState) {
                    final liked = state.state == LikeState.liked;
                    return StatefulBuilder(
                      builder: (context, setSt) {
                        return AppIcon.asset(
                          liked ? Assets.iconsIcFullHeart : Assets.iconsIcHeart,
                          color:
                              liked
                                  ? AppColors.red
                                  : (context.isLightMode
                                      ? AppColors.black
                                      : AppColors.white),
                          onClick: () {
                            context.read<BlogDetailBloc>().add(
                              UpdateBlogLikeStateEvent(
                                blogId: widget.blog.id,
                                userId: _userId,
                                type:
                                    liked
                                        ? UpdateStateType.removeLike
                                        : UpdateStateType.setLike,
                              ),
                            );
                          },
                        );
                      },
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
        Text(
          '${widget.blog.updatedAt.formatDMY()}. ${widget.blog.content.toReadingTime()} mins',
          style: TextStyle(
            color:
                context.isLightMode
                    ? AppColors.black.withValues(alpha: .8)
                    : AppColors.white.withValues(alpha: .8),
            fontSize: AppConstants.textMediumSize,
          ),
        ),
      ],
    );
  }
}
