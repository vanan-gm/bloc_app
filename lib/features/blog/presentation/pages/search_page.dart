import 'dart:math';

import 'package:bloc_app/core/common/extensions/localization_ext.dart';
import 'package:bloc_app/core/common/widgets/smart_list_view.dart';
import 'package:bloc_app/core/theme/app_colors.dart';
import 'package:bloc_app/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_app/core/common/paths/app_path.dart';
import 'package:bloc_app/core/common/widgets/app_icon.dart';
import 'package:bloc_app/core/common/widgets/loading_widget.dart';
import 'package:bloc_app/core/common/widgets/ripple_effect.dart';
import 'package:bloc_app/core/common/widgets/search_field.dart';
import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/features/blog/domain/entities/blog.dart';
import 'package:bloc_app/features/blog/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:bloc_app/features/blog/presentation/pages/blog_detail_page.dart';
import 'package:bloc_app/features/blog/presentation/widgets/blog_card.dart';
import 'package:shimmer/shimmer.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchCtrl = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData(){
    if(!mounted) return;
    context.read<SearchBloc>().add(FetchBlogsEvent(page: 1));
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppConstants.paddingSmall,
        ).copyWith(bottom: AppConstants.paddingSmall),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: SearchField(
                    controller: _searchCtrl,
                    hintText: context.translate.searchBlogsHere,
                    onSubmit: (value){
                      FocusManager.instance.primaryFocus!.unfocus();
                      context.read<SearchBloc>().add(
                        SearchBlogsEvent(keyword: value, page: 1),
                      );
                    },
                    onClear: () {
                      context.read<SearchBloc>().add(FetchBlogsEvent(page: 1));
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: AppConstants.paddingTiny),
                  child: RippleEffect(
                    onTap: () {
                      FocusManager.instance.primaryFocus!.unfocus();
                      context.read<SearchBloc>().add(
                        SearchBlogsEvent(keyword: _searchCtrl.text.trim(), page: 1),
                      );
                    },
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: AppIcon.asset(Assets.iconsIcSend),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: AppConstants.paddingSmall),
                child: BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    if (state is SearchBlogsLoadingState) {
                      return const LoadingWidget();
                    } else if (state is SearchBlogsFetchedState) {
                      return SmartListView(
                        scrollController: _scrollController,
                        itemBuilder: (context, i) {
                          final blog = state.blogs[i];
                          return BlogCard(
                            blog: blog,
                            chipBackgroudColor: AppColors.black,
                            chipTextColor: AppColors.white,
                            padding: EdgeInsets.only(bottom: AppConstants.paddingSmall),
                            onTap: () {
                              Navigator.of(
                                context,
                              ).push(BlogDetailPage.route(blog: blog));
                            },
                          );
                        },
                        dataList: state.blogs,
                        hasReachedEnd: state.hasReachedEnd,
                        onLoadMore:
                            (int page) => context.read<SearchBloc>().add(
                              SearchBlogsEvent(page: page, keyword: _searchCtrl.text.trim(), isLoadingMore: true),
                        ),
                        loadingWidget: Padding(
                          padding: EdgeInsets.symmetric(horizontal: AppConstants.paddingSmall),
                          child: Shimmer.fromColors(
                            baseColor: AppColors.black.withValues(alpha: .6),
                            highlightColor: AppColors.gradient1.withValues(alpha: .6),
                            child: Container(
                              width: AppConstants.widthScreen,
                              height: AppConstants.containerCardHeight,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(AppConstants.borderImage),
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
