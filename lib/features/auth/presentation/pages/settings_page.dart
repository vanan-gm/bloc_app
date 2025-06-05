import 'package:bloc_app/core/common/extesions/buildcontext_ext.dart';
import 'package:bloc_app/core/common/extesions/localization_ext.dart';
import 'package:bloc_app/core/common/extesions/theme_mode_ext.dart';
import 'package:bloc_app/core/common/utils/app_dialog.dart';
import 'package:bloc_app/core/common/utils/app_modal.dart';
import 'package:bloc_app/core/common/utils/show_custom_overlay.dart';
import 'package:bloc_app/core/common/widgets/app_icon.dart';
import 'package:bloc_app/core/common/widgets/ripple_effect.dart';
import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/core/theme/app_colors.dart';
import 'package:bloc_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bloc_app/features/auth/presentation/pages/change_password_page.dart';
import 'package:bloc_app/features/auth/presentation/pages/login_page.dart';
import 'package:bloc_app/features/auth/presentation/pages/profile_page.dart';
import 'package:bloc_app/features/auth/presentation/widgets/setting_item.dart';
import 'package:bloc_app/features/settings/presentation/cubit/language_cubit.dart';
import 'package:bloc_app/features/settings/presentation/cubit/theme_cubit.dart';
import 'package:bloc_app/core/enums/theme_mode.dart' as tm;
import 'package:bloc_app/generated/assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final ValueNotifier<bool> _isLightTheme = ValueNotifier(false);

  void navigatePage(CupertinoPageRoute route) {
    Navigator.of(context).push(route);
  }

  @override
  void initState() {
    super.initState();
    setThemeIcon();
  }

  void setThemeIcon() {
    final state = context.getThemeMode;
    if (state.isLightMode) {
      _isLightTheme.value = true;
    } else {
      _isLightTheme.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppConstants.paddingSmall,
        horizontal: AppConstants.paddingMedium,
      ),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSignOutSuccessState) {
            AppDialog.hideLoadingDialog(context);
            showCustomOverlay(
              context: context,
              isSuccessType: true,
              content: context.translate.signOutSuccessMessage,
            );
            Navigator.of(
              context,
            ).pushAndRemoveUntil(LoginPage.route(), (route) => false);
          } else if (state is AuthFailureState) {
            AppDialog.hideLoadingDialog(context);
            showCustomOverlay(
              context: context,
              isSuccessType: false,
              content: context.translate.encounterError,
            );
          }
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: AppConstants.paddingSuperTiny),
                child: Text(
                  context.translate.account,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              itemBox(Assets.iconsIcUser, context.translate.editProfile, () {
                navigatePage(ProfilePage.route());
              }),
              itemBox(
                Assets.iconsIcSecure,
                context.translate.changePassword,
                () => Navigator.of(context).push(ChangePasswordPage.route()),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: AppConstants.paddingSuperTiny,
                ),
                child: Text(
                  context.translate.preference,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              itemBox(Assets.iconsIcLanguage, context.translate.language, () {
                AppModal.showBottomSheet(
                  context: context,
                  onSelected: (localeCode) {
                    context.read<LanguageCubit>().changeLocale(localeCode);
                  },
                );
              }),
              ValueListenableBuilder(
                valueListenable: _isLightTheme,
                builder: (context, isLightTheme, _) {
                  return switchThemeBox(
                    Assets.iconsIcLightMode,
                    context.translate.lightMode,
                    isLightTheme,
                    () {
                      context.read<ThemeCubit>().changeTheme(
                        isLightTheme
                            ? tm.ThemeMode.darkMode
                            : tm.ThemeMode.lightMode,
                      );
                      _isLightTheme.value = !_isLightTheme.value;
                    },
                  );
                },
              ),
              itemBox(
                Assets.iconsIcFingerprint,
                context.translate.enableFingerPrint,
                () => AppDialog.showFunctionInProgressDialog(
                  context: context,
                  onOk: () => Navigator.of(context).pop(),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: AppConstants.paddingSuperTiny,
                ),
                child: Text(
                  context.translate.aboutApp,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              itemBox(Assets.iconsIcInfo, context.translate.aboutApp, () {}),
              itemBox(Assets.iconsIcRate, context.translate.rateUs, () {}),
              Padding(
                padding: EdgeInsets.only(top: AppConstants.paddingMedium),
                child: SettingsItem(
                  onTap: () {
                    AppDialog.showSignOutDialog(
                      context: context,
                      onBack: () {
                        Navigator.of(context).pop();
                      },
                      onOk: () {
                        Navigator.of(context).pop();
                        context.read<AuthBloc>().add(SignOutEvent());
                      },
                    );
                  },
                  width: AppConstants.widthScreen,
                  alignment: Alignment.center,
                  child: Text(
                    context.translate.logout,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "${context.translate.version} v1.1",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppColors.white.withValues(alpha: .5),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemBox(String icon, String text, VoidCallback onTap) {
    return SettingsItem(
      onTap: onTap,
      child: Row(
        children: [
          AppIcon.asset(icon, color: AppColors.white),
          Padding(
            padding: EdgeInsets.only(left: AppConstants.paddingMedium),
            child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
          ),
          Spacer(),
          AppIcon.asset(Assets.iconsIcRightArrow, color: AppColors.white),
        ],
      ),
    );
  }

  Widget switchThemeBox(
    String icon,
    String text,
    bool isLightMode,
    VoidCallback onTap,
  ) {
    return SettingsItem(
      onTap: onTap,
      child: Row(
        children: [
          AppIcon.asset(icon, color: AppColors.white),
          Padding(
            padding: EdgeInsets.only(left: AppConstants.paddingMedium),
            child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
          ),
          Spacer(),
          AnimatedCrossFade(
            firstChild: AppIcon.asset(
              Assets.iconsIcLightMode,
              color: AppColors.whiteColor,
              size: AppConstants.iconMediumSize,
            ),
            secondChild: AppIcon.asset(
              Assets.iconsIcDarkMode,
              color: AppColors.whiteColor,
              size: AppConstants.iconMediumSize,
            ),
            crossFadeState:
                isLightMode
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
            duration: AppConstants.fadeDuration,
          ),
        ],
      ),
    );
  }
}
