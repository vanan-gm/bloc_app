import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';

extension WidgetExt on Widget {
  Animate useFadeAnimation({
    Duration? duration,
    Offset? offset,
    Duration? delay,
  }) {
    return animate()
        .fadeIn(
          duration: duration ?? AppConstants.fadeDuration600,
          delay: delay,
        )
        .move(
          duration: duration ?? AppConstants.fadeDuration600,
          begin: offset ?? AppConstants.offsetLeft50,
          curve: Curves.easeInOut,
          delay: delay,
        )
        .fade(duration: duration ?? AppConstants.fadeDuration600, delay: delay);
  }

  Animate useScaleAnimation({
    Duration? duration,
    Offset? offset,
    Duration? delay,
  }) {
    return animate()
        .scale(
          begin: AppConstants.offsetScale,
          duration: duration ?? AppConstants.fadeDuration600,
          curve: Curves.easeInOut,
          delay: delay,
        )
        .fadeIn(
          duration: duration ?? AppConstants.fadeDuration600,
          delay: delay,
        );
  }
}
