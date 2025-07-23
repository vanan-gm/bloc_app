import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';

extension WidgetExt on Widget {
  Animate useFadeAnimation({Duration? duration, Offset? offset}) {
    return animate()
        .fadeIn(duration: duration ?? AppConstants.fadeDuration600)
        .move(
          duration: duration ?? AppConstants.fadeDuration600,
          begin: offset ?? AppConstants.offsetLeft50,
          curve: Curves.easeInOut,
        )
        .fade(duration: duration ?? AppConstants.fadeDuration600);
  }

  Animate useScaleAnimation({Duration? duration, Offset? offset}) {
    return animate()
        .scale(
          begin: AppConstants.offsetScale,
          duration: duration ?? AppConstants.fadeDuration600,
          curve: Curves.easeInOut,
        )
        .fadeIn(duration: duration ?? AppConstants.fadeDuration600);
  }
}
