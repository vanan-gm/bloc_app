import 'package:bloc_app/core/common/extensions/buildcontext_ext.dart';
import 'package:bloc_app/core/common/extensions/locale_ext.dart';
import 'package:bloc_app/core/theme/app_colors.dart';
import 'package:bloc_app/features/blog/domain/entities/blog_category.dart';
import 'package:bloc_app/features/settings/presentation/cubit/language_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryChipItem extends StatelessWidget {
  final BlogCategory category;
  final bool isChosen;
  final ValueChanged<bool> onChanged;
  const CategoryChipItem({super.key, required this.category, this.isChosen = false, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(
        context.read<LanguageCubit>().state.isVietnamese
            ? category.titleVi
            : category.titleEn,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color:
          isChosen
              ? AppColors.white
              : (context.isLightMode ? AppColors.black : AppColors.white),
        ),
      ),
      color:
      isChosen ? WidgetStatePropertyAll(AppColors.gradient1) : null,
      side: BorderSide(color: AppColors.borderColor),
      selected: isChosen,
      checkmarkColor: AppColors.white,
      onSelected: onChanged,
    );
  }
}
