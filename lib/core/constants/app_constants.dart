import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppConstants{

  static double widthScreen = ScreenUtil().screenWidth;
  static double heightScreen = ScreenUtil().screenHeight;

  // Paddings
  static double paddingTiny = 10.w;
  static double paddingSmall = 15.w;
  static double paddingMedium = 30.w;
  static double paddingLarge = 45.w;
  static double paddingBig = 60.w;
  static double paddingHuge = 75.w;

  // Radius
  static const double borderWide = 20.0;
  static const double borderImage = 10.0;
  static const double borderButton = 8.0;

  // TextSize
  static const double textTinySize = 12;
  static const double textSmallSize = 14;
  static const double textMediumSize = 16;
  static const double textLargeSize = 20;
  static const double textBigSize = 24;

  // Icon Size
  static const double iconSmallSize = 18;
  static const double iconMediumSize = 24;
  static const double iconLargeSize = 28;
  static const double iconBigSize = 34;
  static const double iconHugeSize = 40;

  // Custom
  static const double containerHeight = 150;
  static const double containerTopicHeight = 50;
  static const double containerCardHeight = 200;

  // Duration
  static const Duration refreshDuration = Duration(seconds: 2);

  static const List<String> topics = [
    'Technology',
    'Business',
    'Programming',
    'Entertainment',
    'Planetary',
    'Music',
    'Travelling',
    'Nature',
    'Communication',
    'Education',
    'Science',
    'Social',
  ];

  static const noConnectionErrorMessage = 'Not connected to a network!';
}