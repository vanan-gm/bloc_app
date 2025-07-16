import 'package:bloc_app/core/common/extensions/localization_ext.dart';
import 'package:flutter/cupertino.dart';

class AppConstants {
  static double? _screenWidth;
  static double? _screenHeight;

  static void init(BuildContext context) {
    _screenWidth = MediaQuery.sizeOf(context).width;
    _screenHeight = MediaQuery.sizeOf(context).height;

    _initializePaddings();
  }

  static void _initializePaddings() {
    final width = _screenWidth ?? 0;
    paddingMicroSmall = width * 0.01;
    paddingSuperTiny = width * 0.02;
    paddingTiny = width * 0.025;
    paddingSmall = width * 0.045;
    paddingSmallPlus = width * 0.05;
    paddingMediumSmall = width * 0.06;
    paddingMedium = width * 0.07;
    paddingLarge = width * 0.08;
    paddingBig = width * 0.09;
    paddingHuge = width * 0.1;
  }

  static double get widthScreen => _screenWidth ?? 0;
  static double get heightScreen => _screenHeight ?? 0;

  // Paddings
  static double paddingMicroSmall = 0;
  static double paddingSuperTiny = 0;
  static double paddingTiny = 0;
  static double paddingSmall = 0;
  static double paddingSmallPlus = 0;
  static double paddingMediumSmall = 0;
  static double paddingMedium = 0;
  static double paddingLarge = 0;
  static double paddingBig = 0;
  static double paddingHuge = 0;

  // Fixed value paddings
  static double getPadding(double value) => value;

  // Radius
  static const double borderWide = 20.0;
  static const double borderTab = 30.0;
  static const double borderImage = 10.0;
  static const double borderButton = 8.0;
  static const double borderSmall = 5.0;
  static const double borderButton2 = 15.0;
  static const double borderRound = 50.0;

  // TextSize
  static const double textTinySize = 12;
  static const double textSmallSize = 14;
  static const double textMediumSize = 16;
  static const double textMediumLargeSize = 18;
  static const double textLargeSize = 20;
  static const double textBigSize = 22;
  static const double textHugeSize = 28;
  static const double textGiantSize = 34;
  static const double textEnormousSize = 40;

  // Icon Size
  static const double iconSmallSize = 18;
  static const double iconMediumSmallSize = 19;
  static const double iconMediumSize = 24;
  static const double iconLargeSize = 28;
  static const double iconBigSize = 34;
  static const double iconHugeSize = 40;
  static const double iconGiantSize = 48;

  // Custom
  static const double containerHeight = 150;
  static const double containerSmallHeight = 25;
  static const double containerTopicHeight = 50;
  static const double containerCardHeight = 200;
  static const double containerBigHeight = 400;
  static const double containerMediumHeight = 300;
  static const double containerBottomHeight = 100;
  static const double containerDetailHeight = 70;
  static const double circleAvatarDetailPageSize = 18;
  static const double circleAvatarSmallSize = 24;
  static const double circleAvatarMedSize = 30;
  static const double circleAvatarBigSize = 42;
  static const double loadingLikeIconSize = 18;
  static const double loadingStrokeWidth = 1.4;

  // Duration
  static const Duration refreshDuration = Duration(seconds: 2);
  static const Duration fadeDuration = Duration(milliseconds: 300);
  static const Duration fadeShortDuration = Duration(milliseconds: 100);
  static const Duration rotationDuration = Duration(milliseconds: 200);
  static const Duration scrollToTopDuration = Duration(milliseconds: 200);
  static const Duration throttleDuration = Duration(milliseconds: 100);
  static const Duration debounceDuration = Duration(seconds: 1);
  static const Duration toastDuration = Duration(seconds: 1);
  static const Duration animationCtrlDuration = Duration(milliseconds: 300);

  // Elevation
  static const double elevationZero = 0.0;

  static List<String> topics(BuildContext context) => [
    context.translate.technology,
    context.translate.business,
    context.translate.programming,
    context.translate.entertainment,
    context.translate.planetary,
    context.translate.music,
    context.translate.travelling,
    context.translate.nature,
    context.translate.communication,
    context.translate.education,
    context.translate.science,
    context.translate.social,
    context.translate.health,
    context.translate.selfImprovement,
    context.translate.history,
    context.translate.cultureAndTraditions,
    context.translate.gaming,
    context.translate.photography,
    context.translate.moviesAndTvShows,
    context.translate.spaceAndAstronomy,
    context.translate.aiAndMachineLearning,
  ];

  static const noConnectionErrorMessage = 'Not connected to a network!';
  static const userNotLoggedIn = 'User not logged in';
  static const userNotFound = 'Can not find this user';

  // Supabase constants
  static const String tableBlogs = 'blogs';
  static const String tableLikes = 'likes';
  static const String tableCategories = 'categories';
  static const String tableProfiles = 'profiles';
  static const String bucketBlogImages = 'blog_images';
  static const String bucketUserImages = 'user-images';

  // SharedPreference constants
  static const String appLocale = 'app_locale';
  static const String appTheme = 'app_theme';
  static const String darkMode = 'darkMode';
  static const String lightMode = 'lightMode';
  static const String blogCategories = 'blog_categories';

  // App Constants
  static const String emptyString = "";
  static const String localeEn = 'en';
  static const String localeVi = 'vi';
  static const int itemPerPage = 10;

  // Fixed size
  static const Size buttonDialogSize = Size(200, 30);
  static const double minContentTextSize = 14.0;
  static const double maxContentTextSize = 24.0;
  static const double distanceFloatingButtons = 55.0;
}
