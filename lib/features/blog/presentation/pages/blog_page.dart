import 'package:bloc_app/core/common/extensions/widget_ext.dart';
import 'package:bloc_app/core/common/utils/app_toast.dart';
import 'package:bloc_app/core/common/widgets/loading_widget.dart';
import 'package:bloc_app/core/common/widgets/smart_list_view.dart';
import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/core/theme/app_colors.dart';
import 'package:bloc_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bloc_app/features/auth/presentation/pages/login_page.dart';
import 'package:bloc_app/features/blog/presentation/bloc/blog_bloc/blog_bloc.dart';
import 'package:bloc_app/features/blog/presentation/pages/blog_detail_page.dart';
import 'package:bloc_app/features/blog/presentation/widgets/blog_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class BlogPage extends StatefulWidget {
  static route() => CupertinoPageRoute(builder: (context) => const BlogPage());

  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() {
    if (!mounted) return;
    context.read<BlogBloc>().add(GetBlogsEvent(page: 1));
  }

  Future<void> _handleRefreshPage() async {
    await Future.delayed(AppConstants.refreshDuration, () {});
    if (!mounted) return;
    context.read<BlogBloc>().add(GetBlogsEvent(page: 1, isRefresh: true));
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSignOutSuccessState) {
              Navigator.of(
                context,
              ).pushAndRemoveUntil(LoginPage.route(), (route) => false);
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                RefreshIndicator(
                  onRefresh: _handleRefreshPage,
                  child: BlocConsumer<BlogBloc, BlogState>(
                    listener: (context, state) {
                      if (state is BlogFailureState) {
                        AppToast.showToast(
                          context: context,
                          title: "Failure!",
                          message: state.message,
                          type: ToastType.error,
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is BlogLoadingState) {
                        return const LoadingWidget();
                      } else if (state is BlogFetchedDataState) {
                        return SmartListView(
                          scrollController: _scrollController,
                          itemBuilder: (context, i) {
                            final blog = state.blogs[i];
                            final cappedIndex = i.clamp(0, 10);
                            final delay =
                                AppConstants.fadeItemOfListDuration *
                                cappedIndex;
                            return BlogCard(
                              blog: blog,
                              chipBackgroudColor: AppColors.black,
                              chipTextColor: AppColors.white,
                              padding: EdgeInsets.symmetric(
                                horizontal: AppConstants.paddingSmall,
                              ).copyWith(bottom: AppConstants.paddingSmall),
                              onTap: () {
                                Navigator.of(
                                  context,
                                ).push(BlogDetailPage.route(blog: blog));
                              },
                            ).useFadeAnimation(delay: delay);
                          },
                          dataList: state.blogs,
                          hasReachedEnd: state.hasReachedEnd,
                          onLoadMore:
                              (int page) => context.read<BlogBloc>().add(
                                GetBlogsEvent(page: page),
                              ),
                          loadingWidget: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppConstants.paddingSmall,
                            ),
                            child: Shimmer.fromColors(
                              baseColor: AppColors.black.withValues(alpha: .6),
                              highlightColor: AppColors.gradient1.withValues(
                                alpha: .6,
                              ),
                              child: Container(
                                width: AppConstants.widthScreen,
                                height: AppConstants.containerCardHeight,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    AppConstants.borderImage,
                                  ),
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return SizedBox(
                          width: AppConstants.widthScreen,
                          height: AppConstants.containerCardHeight,
                        );
                      }
                    },
                  ),
                ),
                state is AuthLoadingState
                    ? SizedBox(
                      width: AppConstants.widthScreen,
                      height: AppConstants.heightScreen,
                      child: const LoadingWidget(),
                    )
                    : const SizedBox(),
              ],
            );
          },
        ),
      ),
    );
  }
}
