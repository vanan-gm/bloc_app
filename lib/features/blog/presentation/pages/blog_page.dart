import 'package:bloc_app/core/common/utils/show_custom_overlay.dart';
import 'package:bloc_app/core/common/widgets/loading_widget.dart';
import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bloc_app/features/auth/presentation/pages/login_page.dart';
import 'package:bloc_app/features/blog/presentation/bloc/blog_bloc/blog_bloc.dart';
import 'package:bloc_app/features/blog/presentation/pages/blog_detail_page.dart';
import 'package:bloc_app/features/blog/presentation/widgets/blog_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatefulWidget {
  static route() => CupertinoPageRoute(builder: (context) => const BlogPage());

  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(BlogGetAllBlogsEvent());
  }

  Future<void> _handleRefreshPage() async {
    await Future.delayed(AppConstants.refreshDuration, () {});
    if (!mounted) return;
    context.read<BlogBloc>().add(BlogGetAllBlogsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSignOutSuccessState) {
            Navigator.of(context).pushAndRemoveUntil(
              LoginPage.route(),
                  (route) => false,
            );
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
                      showCustomOverlay(
                          context: context,
                          content: state.message,
                          isSuccessType: false);
                    }
                  },
                  builder: (context, state) {
                    if (state is BlogLoadingState) {
                      return const LoadingWidget();
                    } else if (state is BlogGetAllSuccessState) {
                      return ListView.builder(
                          itemCount: state.blogs.length,
                          itemBuilder: (context, i) {
                            final blog = state.blogs[i];
                            return BlogCard(
                              blog: blog,
                              padding: EdgeInsets.symmetric(horizontal: AppConstants.paddingSmall).copyWith(bottom: AppConstants.paddingSmall),
                              onTap: () {
                                Navigator.of(context)
                                    .push(BlogDetailPage.route(blog: blog));
                              },
                            );
                          });
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
    );
  }
}
