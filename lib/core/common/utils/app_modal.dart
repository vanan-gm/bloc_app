import 'package:bloc_app/core/common/extesions/localization_ext.dart';
import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/core/theme/app_colors.dart';
import 'package:bloc_app/features/settings/presentation/cubit/language_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppModal {
  AppModal._();

  static Future<void> showBottomSheet({
    required BuildContext context,
    required void Function(String localeCode) onSelected,
  }) async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        final locale = context.read<LanguageCubit>().state;
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: AppConstants.paddingSmall,
                ),
                child: Text(
                  context.translate.selectLanguage,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),

              // Language options
              ListTile(
                leading: Icon(Icons.language),
                title: Text(
                  context.translate.english,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                trailing:
                    locale.languageCode == AppConstants.localeEn
                        ? Icon(Icons.check, color: AppColors.white)
                        : null,
                onTap: () {
                  onSelected(AppConstants.localeEn);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.language),
                title: Text(
                  context.translate.vietnamese,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                trailing:
                    locale.languageCode == AppConstants.localeVi
                        ? Icon(Icons.check, color: AppColors.white)
                        : null,
                onTap: () {
                  onSelected(AppConstants.localeVi);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
