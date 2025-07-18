import 'package:bloc_app/core/common/extensions/buildcontext_ext.dart';
import 'package:bloc_app/core/common/widgets/app_button.dart';
import 'package:bloc_app/core/common/widgets/app_icon.dart';
import 'package:bloc_app/core/common/widgets/app_text.dart';
import 'package:bloc_app/core/common/widgets/multiple_value_notifier_builder.dart';
import 'package:bloc_app/core/common/widgets/ripple_effect.dart';
import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/core/theme/app_colors.dart';
import 'package:bloc_app/features/blog/domain/entities/blog_category.dart';
import 'package:bloc_app/features/blog/presentation/widgets/category_chip_item.dart';
import 'package:bloc_app/features/settings/presentation/cubit/blog_category_cubit.dart';
import 'package:bloc_app/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryFilterBottomSheet extends StatefulWidget {
  final List<String> chosenCategories;
  const CategoryFilterBottomSheet({super.key, required this.chosenCategories});

  @override
  State<CategoryFilterBottomSheet> createState() =>
      _CategoryFilterBottomSheetState();
}

class _CategoryFilterBottomSheetState extends State<CategoryFilterBottomSheet> {
  final ValueNotifier<List<BlogCategory>> _categories = ValueNotifier([]);
  final ValueNotifier<List<String>> _chosenCategories = ValueNotifier([]);

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() {
    if (!mounted) return;
    _categories.value = context.read<BlogCategoryCubit>().state;
    _chosenCategories.value = widget.chosenCategories;
  }

  @override
  void dispose() {
    super.dispose();
    _categories.dispose();
    _chosenCategories.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Spacer(),
            Expanded(
              child: AppText(
                text: "Category Filter",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: RippleEffect(
                  onTap: () => Navigator.of(context).pop(),
                  child: AppIcon.asset(
                    Assets.iconsIcClose,
                    color:
                        context.isLightMode ? AppColors.black : AppColors.white,
                    size: AppConstants.iconMediumSize,
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: AppConstants.paddingSmall),
          child: MultiValueListenerBuilder(
            notifiers: [_categories, _chosenCategories],
            builder: (context, values) {
              final List<BlogCategory> categories = values[0];
              final List<String> chosenCategories = values[1];
              return Wrap(
                spacing: 4,
                runSpacing: 4,
                children: List.generate(categories.length, (index) {
                  return CategoryChipItem(
                    category: categories[index],
                    isChosen: chosenCategories.contains(
                      categories[index].categoryId,
                    ),
                    onChanged: (bool isChosen) {
                      if (isChosen) {
                        _chosenCategories.value = [
                          ..._chosenCategories.value,
                          categories[index].categoryId,
                        ];
                      } else if (!isChosen) {
                        _chosenCategories.value =
                            _chosenCategories.value
                                .where((c) => c != categories[index].categoryId)
                                .toList();
                      }
                    },
                  );
                }),
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: AppConstants.paddingSmall),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppButton.text(
                text: "Apply",
                color: AppColors.gradient1,
                width: AppConstants.filterButtonWidth,
                onPressed: () {
                  Navigator.of(context).pop(_chosenCategories.value);
                },
              ),
              AppButton.text(
                text: "Clear",
                color: AppColors.red,
                width: AppConstants.filterButtonWidth,
                onPressed: () {
                  _chosenCategories.value = [];
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
