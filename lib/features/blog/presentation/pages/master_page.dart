import 'package:bloc_app/core/common/extensions/buildcontext_ext.dart';
import 'package:bloc_app/core/common/extensions/localization_ext.dart';
import 'package:bloc_app/core/common/extensions/object_ext.dart';
import 'package:bloc_app/core/common/widgets/app_text.dart';
import 'package:bloc_app/features/auth/presentation/pages/settings_page.dart';
import 'package:bloc_app/features/blog/presentation/bloc/blog_bloc/blog_bloc.dart';
import 'package:bloc_app/generated/assets.dart';
import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bloc_app/core/common/widgets/app_icon.dart';
import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/core/enums/page_type.dart';
import 'package:bloc_app/core/theme/app_colors.dart';
import 'package:bloc_app/core/theme/app_pallete.dart';
import 'package:bloc_app/features/blog/presentation/pages/add_blog_page.dart';
import 'package:bloc_app/features/blog/presentation/pages/blog_page.dart';
import 'package:bloc_app/features/blog/presentation/pages/favorite_page.dart';
import 'package:bloc_app/features/blog/presentation/pages/search_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MasterPage extends StatefulWidget {
  static route() =>
      CupertinoPageRoute(builder: (context) => const MasterPage());

  const MasterPage({super.key});

  @override
  State<MasterPage> createState() => _MasterPageState();
}

class _MasterPageState extends State<MasterPage> {
  final List<PageType> pagesTitle = [
    PageType.home,
    PageType.search,
    PageType.favorite,
    PageType.settings,
  ];
  final List<Widget> pages = [
    BlogPage(),
    SearchPage(),
    FavoritePage(),
    SettingsPage(),
  ];
  int _currentTabIndex = 0;

  void changeTabIndex(int index) {
    setState(() {
      _currentTabIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Blog App',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w700,
              color: context.isLightMode ? AppColors.black : AppColors.white,
            ),
          ),
          centerTitle: true,
          forceMaterialTransparency: true,
        ),
        body: SafeArea(
          child: IndexedStack(index: _currentTabIndex, children: pages),
        ),
        bottomNavigationBar: BottomBar(
          selectedIndex: _currentTabIndex,
          onTap: changeTabIndex,
          padding: EdgeInsets.symmetric(horizontal: AppConstants.paddingSmall),
          height: 65,
          items: <BottomBarItem>[
            BottomBarItem(
              icon: AppIcon.asset(
                Assets.iconsIcHome,
                size: AppConstants.iconMediumSize,
                color: getTabColor(context: context, requiredIndex: 0),
              ),
              title: AppText(
                text: context.translate.home,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: getTabColor(context: context, requiredIndex: 0),
                ),
              ),
              activeColor: AppColors.gradient1,
            ),
            BottomBarItem(
              icon: AppIcon.asset(
                Assets.iconsIcSearch,
                size: AppConstants.iconMediumSize,
                color: getTabColor(context: context, requiredIndex: 1),
              ),
              title: AppText(
                text: context.translate.search,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: getTabColor(context: context, requiredIndex: 1),
                ),
              ),
              activeColor: AppColors.gradient1,
            ),
            BottomBarItem(
              icon: AppIcon.asset(
                Assets.iconsIcHeart,
                size: AppConstants.iconMediumSize,
                color: getTabColor(context: context, requiredIndex: 2),
              ),
              title: AppText(
                text: context.translate.favorite,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: getTabColor(context: context, requiredIndex: 2),
                ),
              ),
              activeColor: AppColors.gradient1,
            ),
            BottomBarItem(
              icon: AppIcon.asset(
                Assets.iconsIcSettings,
                size: AppConstants.iconMediumSize,
                color: getTabColor(context: context, requiredIndex: 3),
              ),
              title: AppText(
                text: context.translate.settings,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: getTabColor(context: context, requiredIndex: 3),
                ),
              ),
              activeColor: AppColors.gradient1,
            ),
          ],
        ),
        floatingActionButton:
            _currentTabIndex == 0
                ? FloatingActionButton(
                  onPressed: () async {
                    final result = await Navigator.of(
                      context,
                    ).push(AddBlogPage.route());
                    if (result.isNotNull && context.mounted) {
                      context.read<BlogBloc>().add(BlogGetAllBlogsEvent());
                    }
                  },
                  mini: true,
                  backgroundColor:
                      context.isLightMode
                          ? AppColors.white.withValues(alpha: .8)
                          : AppColors.black.withValues(alpha: .8),
                  child: const Icon(Icons.add),
                )
                : null,
      ),
    );
  }

  Color getTabColor({
    required BuildContext context,
    required int requiredIndex,
  }) {
    if (_currentTabIndex == requiredIndex) return AppPallete.gradient1;
    return context.isLightMode ? AppColors.black : AppColors.white;
  }
}
