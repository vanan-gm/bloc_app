import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppConstants{

  static double widthScreen = ScreenUtil().screenWidth;
  static double heightScreen = ScreenUtil().screenHeight;

  static double paddingSmall = 5.w;
  static double paddingMedium = 10.w;
  static double paddingLarge = 15.w;

  static const double borderRadius = 20.0;

  static const List<String> topics = [
    'Technology',
    'Business',
    'Programming',
    'Entertainment',
  ];

  static const noConnectionErrorMessage = 'Not connected to a network!';
}