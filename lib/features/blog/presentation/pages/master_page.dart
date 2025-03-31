import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_app/core/common/paths/app_path.dart';
import 'package:bloc_app/core/common/utils/app_dialog.dart';
import 'package:bloc_app/core/common/widgets/app_icon.dart';
import 'package:bloc_app/core/common/widgets/bottom_nav_app.dart';
import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/core/enums/page_type.dart';
import 'package:bloc_app/core/theme/app_colors.dart';
import 'package:bloc_app/core/theme/app_pallete.dart';
import 'package:bloc_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bloc_app/features/auth/presentation/pages/profile_page.dart';
import 'package:bloc_app/features/blog/presentation/bloc/blog_bloc/blog_bloc.dart';
import 'package:bloc_app/features/blog/presentation/pages/add_blog_page.dart';
import 'package:bloc_app/features/blog/presentation/pages/blog_page.dart';
import 'package:bloc_app/features/blog/presentation/pages/favorite_page.dart';
import 'package:bloc_app/features/blog/presentation/pages/search_page.dart';

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
    PageType.profile,
  ];
  final List<Widget> pages = [
    BlogPage(),
    SearchPage(),
    FavoritePage(),
    ProfilePage(),
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
        actions: [
          AnimatedOpacity(
            opacity: _currentTabIndex == 0 ? 1 : 0,
            duration: AppConstants.fadeShortDuration,
            child: AppIcon.asset(
              AppPath.icReload,
              size: AppConstants.iconMediumSize,
              margin: EdgeInsets.all(AppConstants.paddingTiny),
              onClick: () {
                context.read<BlogBloc>().add(BlogGetAllBlogsEvent());
              },
            ),
          ),
          AppIcon.asset(
            AppPath.icLogout,
            size: AppConstants.iconMediumSize,
            margin: EdgeInsets.all(
              AppConstants.paddingTiny,
            ).copyWith(right: AppConstants.paddingSmall),
            onClick: () {
              AppDialog.showSignOutDialog(
                context: context,
                onBack: () {
                  Navigator.of(context).pop();
                },
                onOk: () {
                  Navigator.of(context).pop();
                  context.read<AuthBloc>().add(AuthSignOut());
                },
              );
            },
          ),
        ],
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
                AppPath.icHome,
                color:
                    _currentTabIndex == 0
                        ? AppPallete.gradient1
                        : AppColors.white,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: AppConstants.paddingSuperTiny),
              child: AppIcon.asset(
                AppPath.icSearch,
                color:
                    _currentTabIndex == 1
                        ? AppPallete.gradient1
                        : AppColors.white,
              ),
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: AppConstants.paddingSuperTiny),
              child: AppIcon.asset(
                AppPath.icFavorite,
                color:
                    _currentTabIndex == 2
                        ? AppPallete.gradient1
                        : AppColors.white,
              ),
            ),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: AppConstants.paddingSuperTiny),
              child: AppIcon.asset(
                AppPath.icProfile,
                color:
                    _currentTabIndex == 3
                        ? AppPallete.gradient1
                        : AppColors.white,
              ),
            ),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton:
          _currentTabIndex == 0
              ? FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(AddBlogPage.route());
                },
                mini: true,
                backgroundColor: AppColors.black.withValues(alpha: .8),
                child: const Icon(Icons.add),
              )
              : null,
    );
  }
}
