import 'package:flutter/material.dart';
import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/core/theme/app_colors.dart';
import 'package:bloc_app/core/theme/app_pallete.dart';
import 'package:bloc_app/core/theme/app_style.dart';

class BottomNavApp extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<BottomNavigationBarItem> items;
  final Color? backgroundColor;

  const BottomNavApp({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppConstants.containerBottomHeight,
      color: AppColors.backgroundColor,
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        items: items,
        elevation: 0.0,
        backgroundColor: backgroundColor,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppPallete.gradient1,
        unselectedItemColor: AppPallete.whiteColor,
        selectedLabelStyle: AppStyle.defaultStyle(fontSize: AppConstants.textTinySize),
        unselectedLabelStyle: AppStyle.defaultStyle(fontSize: AppConstants.textTinySize),
      ),
    );
  }
}
