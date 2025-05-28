import 'package:bloc_app/core/common/extesions/localization_ext.dart';
import 'package:bloc_app/core/common/extesions/object_ext.dart';
import 'package:bloc_app/features/auth/presentation/pages/settings_page.dart';
import 'package:bloc_app/features/blog/presentation/bloc/blog_bloc/blog_bloc.dart';
import 'package:bloc_app/generated/assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bloc_app/core/common/widgets/app_icon.dart';
import 'package:bloc_app/core/common/widgets/bottom_nav_app.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Blog App',
          style: Theme.of(
            context,
          ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        forceMaterialTransparency: true,
      ),
      body: SafeArea(
        child: IndexedStack(index: _currentTabIndex, children: pages),
      ),
      bottomNavigationBar: BottomNavApp(
        currentIndex: _currentTabIndex,
        onTap: changeTabIndex,
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: AppConstants.paddingSuperTiny),
              child: AppIcon.asset(
                Assets.iconsIcHome,
                color:
                    _currentTabIndex == 0
                        ? AppPallete.gradient1
                        : AppColors.white,
              ),
            ),
            label: context.translate.home,
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: AppConstants.paddingSuperTiny),
              child: AppIcon.asset(
                Assets.iconsIcSearch,
                color:
                    _currentTabIndex == 1
                        ? AppPallete.gradient1
                        : AppColors.white,
              ),
            ),
            label: context.translate.search,
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: AppConstants.paddingSuperTiny),
              child: AppIcon.asset(
                Assets.iconsIcHeart,
                color:
                    _currentTabIndex == 2
                        ? AppPallete.gradient1
                        : AppColors.white,
              ),
            ),
            label: context.translate.favorite,
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: AppConstants.paddingSuperTiny),
              child: AppIcon.asset(
                Assets.iconsIcSettings,
                color:
                    _currentTabIndex == 3
                        ? AppPallete.gradient1
                        : AppColors.white,
              ),
            ),
            label: context.translate.settings,
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
                backgroundColor: AppColors.black.withValues(alpha: .8),
                child: const Icon(Icons.add),
              )
              : null,
    );
  }
}
