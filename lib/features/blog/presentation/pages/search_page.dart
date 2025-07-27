import 'dart:math';

import 'package:bloc_app/core/common/extensions/buildcontext_ext.dart';
import 'package:bloc_app/core/common/extensions/localization_ext.dart';
import 'package:bloc_app/core/common/extensions/object_ext.dart';
import 'package:bloc_app/core/common/extensions/widget_ext.dart';
import 'package:bloc_app/core/common/widgets/app_button.dart';
import 'package:bloc_app/core/common/widgets/app_text.dart';
import 'package:bloc_app/core/common/widgets/multiple_value_notifier_builder.dart';
import 'package:bloc_app/core/common/widgets/smart_list_view.dart';
import 'package:bloc_app/core/theme/app_colors.dart';
import 'package:bloc_app/features/blog/domain/entities/blog_category.dart';
import 'package:bloc_app/features/blog/presentation/widgets/category_chip_item.dart';
import 'package:bloc_app/features/blog/presentation/widgets/category_filter_bottom_sheet.dart';
import 'package:bloc_app/features/blog/presentation/widgets/loading_blog_widget.dart';
import 'package:bloc_app/features/blog/presentation/widgets/loading_blogs_list.dart';
import 'package:bloc_app/features/settings/presentation/cubit/blog_category_cubit.dart';
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
  final ValueNotifier<List<BlogCategory>> _categories = ValueNotifier([]);
  final ValueNotifier<List<String>> _chosenCategories = ValueNotifier([]);

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() {
    if (!mounted) return;
    context.read<SearchBloc>().add(FetchBlogsEvent(page: 1));
  }

  Future<void> _handleRefreshPage() async {
    if (!mounted) return;
    context.read<SearchBloc>().add(FetchBlogsEvent(page: 1));
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _searchCtrl.dispose();
    _categories.dispose();
    _chosenCategories.dispose();
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
                    onSubmit: (value) {
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
                categoryFilterBox,
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: AppConstants.paddingSmall),
                child: BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    if (state is SearchBlogsLoadingState) {
                      return const LoadingBlogsList();
                    } else if (state is SearchBlogsFetchedState) {
                      return SmartListView(
                        scrollController: _scrollController,
                        itemBuilder: (context, i) {
                          final blog = state.blogs[i];
                          final cappedIndex = i.clamp(0, 10);
                          final delay =
                              AppConstants.fadeItemOfListDuration * cappedIndex;
                          return BlogCard(
                            blog: blog,
                            chipBackgroudColor: AppColors.black,
                            chipTextColor: AppColors.white,
                            padding: EdgeInsets.only(
                              bottom: AppConstants.paddingSmall,
                            ),
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
                            (int page) => context.read<SearchBloc>().add(
                              SearchBlogsEvent(
                                page: page,
                                keyword: _searchCtrl.text.trim(),
                                isLoadingMore: true,
                              ),
                            ),
                        onRefresh: _handleRefreshPage,
                        loadingWidget: const LoadingBlogWidget(),
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

  Widget get categoryFilterBox {
    return ValueListenableBuilder(
      valueListenable: _chosenCategories,
      builder: (context, chosenCategories, _) {
        return Stack(
          children: [
            Container(
              padding: EdgeInsets.all(AppConstants.paddingMicroSmall),
              child: RippleEffect(
                onTap: () async {
                  FocusManager.instance.primaryFocus!.unfocus();
                  final result = await showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppConstants.borderButton2,
                      ),
                    ),
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return Padding(
                        padding: EdgeInsets.all(AppConstants.paddingSmall),
                        child: CategoryFilterBottomSheet(
                          chosenCategories: _chosenCategories.value,
                        ),
                      );
                    },
                  );
                  if (result == null) return;
                  result as List<String>;
                  if (result.isNotEmpty) {
                    _chosenCategories.value = result;
                  } else {
                    _chosenCategories.value.clear();
                  }
                },
                child: SizedBox(
                  height: AppConstants.circleAvatarMedSize,
                  width: AppConstants.circleAvatarMedSize,
                  child: AppIcon.asset(Assets.iconsIcFilter),
                ),
              ),
            ),
            if (chosenCategories.isNotEmpty)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.gradient1,
                  ),
                  alignment: Alignment.center,
                  child: AppText(
                    text: chosenCategories.length.toString(),
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall!.copyWith(color: AppColors.white),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
