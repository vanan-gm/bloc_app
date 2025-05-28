import 'package:bloc_app/core/common/extesions/localization_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppConstants {
  static double widthScreen = ScreenUtil().screenWidth;
  static double heightScreen = ScreenUtil().screenHeight;

  // Paddings
  static double paddingMicroSmall = 1.w;
  static double paddingSuperTiny = 5.w;
  static double paddingTiny = 10.w;
  static double paddingSmall = 15.w;
  static double paddingMediumSmall = 25.w;
  static double paddingMedium = 30.w;
  static double paddingLarge = 45.w;
  static double paddingBig = 60.w;
  static double paddingHuge = 75.w;

  // Radius
  static const double borderWide = 20.0;
  static const double borderTab = 30.0;
  static const double borderImage = 10.0;
  static const double borderButton = 8.0;
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
  static const double containerTopicHeight = 50;
  static const double containerCardHeight = 200;
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
  static const String tableProfiles = 'profiles';
  static const String bucketBlogImages = 'blog_images';
  static const String bucketUserImages = 'user-images';

  // SharedPreference constants
  static const String appLocale = 'app_locale';

  // App Constants
  static const String localeEn = 'en';
  static const String localeVi = 'vi';
}
