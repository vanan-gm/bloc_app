import 'dart:math';

import 'package:bloc_app/core/common/extensions/localization_ext.dart';
import 'package:bloc_app/core/common/widgets/app_button.dart';
import 'package:bloc_app/core/common/widgets/app_text.dart';
import 'package:bloc_app/core/common/widgets/multiple_value_notifier_builder.dart';
import 'package:bloc_app/core/common/widgets/smart_list_view.dart';
import 'package:bloc_app/core/theme/app_colors.dart';
import 'package:bloc_app/features/blog/domain/entities/blog_category.dart';
import 'package:bloc_app/features/blog/presentation/widgets/category_chip_item.dart';
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
                Padding(
                  padding: EdgeInsets.only(left: AppConstants.paddingTiny),
                  child: RippleEffect(
                    onTap: () {
                      FocusManager.instance.primaryFocus!.unfocus();
                      showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppConstants.borderButton2,
                          ),
                        ),
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          _categories.value =
                              context.read<BlogCategoryCubit>().state;
                          return Padding(
                            padding: EdgeInsets.all(AppConstants.paddingSmall),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Spacer(),
                                    Expanded(
                                      child: AppText(
                                        text: "Category Filter",
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.bodyLarge,
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: RippleEffect(
                                          onTap:
                                              () => Navigator.of(context).pop(),
                                          child: AppIcon.asset(
                                            Assets.iconsIcClose,
                                            color: AppColors.white,
                                            size: AppConstants.iconMediumSize,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: AppConstants.paddingSmall,
                                  ),
                                  child: MultiValueListenerBuilder(
                                    notifiers: [_categories, _chosenCategories],
                                    builder: (context, values) {
                                      final List<BlogCategory> categories =
                                          values[0];
                                      final List<String> chosenCategories =
                                          values[1];
                                      return Wrap(
                                        spacing: 4,
                                        runSpacing: 4,
                                        children: List.generate(
                                          categories.length,
                                          (index) {
                                            return CategoryChipItem(
                                              category: categories[index],
                                              isChosen: chosenCategories
                                                  .contains(
                                                    categories[index]
                                                        .categoryId,
                                                  ),
                                              onChanged: (bool isChosen) {
                                                if (isChosen) {
                                                  _chosenCategories.value = [
                                                    ..._chosenCategories.value,
                                                    categories[index]
                                                        .categoryId,
                                                  ];
                                                } else if (!isChosen) {
                                                  _chosenCategories.value =
                                                      _chosenCategories.value
                                                          .where(
                                                            (c) =>
                                                                c !=
                                                                categories[index]
                                                                    .categoryId,
                                                          )
                                                          .toList();
                                                }
                                              },
                                            );
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: AppConstants.paddingSmall,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      AppButton.text(
                                        text: "Apply",
                                        color: AppColors.gradient1,
                                        onPressed: () {},
                                      ),
                                      AppButton.text(
                                        text: "Cancel",
                                        color: AppColors.red,
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: AppIcon.asset(Assets.iconsIcFilter),
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
