import 'package:bloc_app/core/common/extensions/buildcontext_ext.dart';
import 'package:bloc_app/core/common/extensions/localization_ext.dart';
import 'package:bloc_app/core/common/extensions/theme_mode_ext.dart';
import 'package:bloc_app/core/common/utils/app_dialog.dart';
import 'package:bloc_app/core/common/utils/app_modal.dart';
import 'package:bloc_app/core/common/utils/app_toast.dart';
import 'package:bloc_app/core/common/widgets/app_icon.dart';
import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/core/enums/theme_mode.dart' as tm;
import 'package:bloc_app/core/theme/app_colors.dart';
import 'package:bloc_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bloc_app/features/auth/presentation/pages/change_password_page.dart';
import 'package:bloc_app/features/auth/presentation/pages/login_page.dart';
import 'package:bloc_app/features/auth/presentation/pages/profile_page.dart';
import 'package:bloc_app/features/auth/presentation/widgets/setting_item.dart';
import 'package:bloc_app/features/settings/presentation/cubit/language_cubit.dart';
import 'package:bloc_app/features/settings/presentation/cubit/theme_cubit.dart';
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
        horizontal: AppConstants.paddingMedium,
      ).copyWith(top: AppConstants.paddingSmall),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSignOutSuccessState) {
            AppDialog.hideLoadingDialog(context);
            AppToast.showToast(
              context: context,
              title: "Success!",
              message: context.translate.signOutSuccessMessage,
              type: ToastType.success,
            );
            Navigator.of(
              context,
            ).pushAndRemoveUntil(LoginPage.route(), (route) => false);
          } else if (state is AuthFailureState) {
            AppDialog.hideLoadingDialog(context);
            AppToast.showToast(
              context: context,
              title: "Failure!",
              message: context.translate.encounterError,
              type: ToastType.error,
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
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w700,
                    color:
                        context.isLightMode ? AppColors.black : AppColors.white,
                  ),
                ),
              ),
              itemBox(
                context: context,
                icon: Assets.iconsIcUser,
                text: context.translate.editProfile,
                onTap: () {
                  navigatePage(ProfilePage.route());
                },
              ),
              itemBox(
                context: context,
                icon: Assets.iconsIcSecure,
                text: context.translate.changePassword,
                onTap:
                    () =>
                        Navigator.of(context).push(ChangePasswordPage.route()),
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
              itemBox(
                context: context,
                icon: Assets.iconsIcLanguage,
                text: context.translate.language,
                onTap: () {
                  AppModal.showLanguageBottomSheet(
                    context: context,
                    onSelected: (localeCode) {
                      context.read<LanguageCubit>().changeLocale(localeCode);
                    },
                  );
                },
              ),
              ValueListenableBuilder(
                valueListenable: _isLightTheme,
                builder: (context, isLightTheme, _) {
                  return switchThemeBox(
                    context: context,
                    icon: Assets.iconsIcLightMode,
                    text: context.translate.lightMode,
                    isLightMode: isLightTheme,
                    onTap: () {
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
                context: context,
                icon: Assets.iconsIcFingerprint,
                text: context.translate.enableFingerPrint,
                onTap:
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
              itemBox(
                context: context,
                icon: Assets.iconsIcInfo,
                text: context.translate.aboutApp,
                onTap:
                    () => AppDialog.showAboutAppDialog(
                      context: context,
                      onOk: () => Navigator.of(context).pop(),
                    ),
              ),
              itemBox(
                context: context,
                icon: Assets.iconsIcRate,
                text: context.translate.rateUs,
                onTap:
                    () => AppDialog.showFunctionInProgressDialog(
                      context: context,
                      onOk: () => Navigator.of(context).pop(),
                    ),
              ),
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
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color:
                          context.isLightMode
                              ? AppColors.black
                              : AppColors.white,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "${context.translate.version} v1.1.1",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color:
                        context.isLightMode
                            ? AppColors.black.withValues(alpha: .6)
                            : AppColors.white.withValues(alpha: .6),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemBox({
    required BuildContext context,
    required String icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: .5),
      child: SettingsItem(
        onTap: onTap,
        child: Row(
          children: [
            AppIcon.asset(
              icon,
              color: context.isLightMode ? AppColors.black : AppColors.white,
            ),
            Padding(
              padding: EdgeInsets.only(left: AppConstants.paddingMedium),
              child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
            ),
            Spacer(),
            AppIcon.asset(
              Assets.iconsIcRightArrow,
              color: context.isLightMode ? AppColors.black : AppColors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget switchThemeBox({
    required BuildContext context,
    required String icon,
    required String text,
    required bool isLightMode,
    required VoidCallback onTap,
  }) {
    return SettingsItem(
      onTap: onTap,
      child: Row(
        children: [
          AppIcon.asset(
            icon,
            color: context.isLightMode ? AppColors.black : AppColors.white,
          ),
          Padding(
            padding: EdgeInsets.only(left: AppConstants.paddingMedium),
            child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
          ),
          Spacer(),
          AnimatedCrossFade(
            firstChild: AppIcon.asset(
              Assets.iconsIcLightMode,
              color: context.isLightMode ? AppColors.black : AppColors.white,
              size: AppConstants.iconMediumSmallSize,
            ),
            secondChild: AppIcon.asset(
              Assets.iconsIcDarkMode,
              color: context.isLightMode ? AppColors.black : AppColors.white,
              size: AppConstants.iconMediumSmallSize,
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
