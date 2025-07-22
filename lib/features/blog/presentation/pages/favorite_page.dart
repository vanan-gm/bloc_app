import 'package:bloc_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:bloc_app/core/common/extensions/buildcontext_ext.dart';
import 'package:bloc_app/core/common/extensions/localization_ext.dart';
import 'package:bloc_app/core/common/widgets/loading_widget.dart';
import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/features/blog/presentation/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:bloc_app/features/blog/presentation/pages/blog_detail_page.dart';
import 'package:bloc_app/features/blog/presentation/widgets/blog_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    super.initState();
    getFavoriteBlogs();
  }

  void getFavoriteBlogs() {
    if (!mounted) return;
    final userId = context.currentUserId;
    context.read<FavoriteBlogBloc>().add(
      GetAllFavoriteBlogsEvent(userId: userId),
    );
  }

  Future<void> handleRefreshFavoriteBlogs() async {
    await Future.delayed(AppConstants.refreshDuration, () {
      if (!mounted) return;
      final userId = context.currentUserId;
      context.read<FavoriteBlogBloc>().add(
        GetAllFavoriteBlogsEvent(userId: userId),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.paddingSmall,
        vertical: AppConstants.paddingSmall,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${context.translate.myFavoriteBlogs}:',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w700),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: handleRefreshFavoriteBlogs,
              child: Padding(
                padding: EdgeInsets.only(top: AppConstants.paddingSmall),
                child: BlocBuilder<FavoriteBlogBloc, FavoriteBlogState>(
                  builder: (context, state) {
                    if (state is FavoriteBlogLoadingState) {
                      return const LoadingWidget();
                    } else if (state is FavoriteBlogsFetchedState) {
                      return ListView.builder(
                        itemCount: state.blogs.length,
                        itemBuilder: (context, i) {
                          final blog = state.blogs[i];
                          return BlogCard(
                            blog: blog,
                            padding: EdgeInsets.only(
                              bottom: AppConstants.paddingSmall,
                            ),
                            onTap: () {
                              Navigator.of(
                                context,
                              ).push(BlogDetailPage.route(blog: blog));
                            },
                          );
                        },
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
