import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/core/enums/fade_animation_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class FadeAnimationWidget extends StatelessWidget {
  final Widget child;
  final Offset? offset;
  final FadeAnimationType? animationType;
  final Duration? duration;

  const FadeAnimationWidget({
    super.key,
    required this.child,
    this.offset = AppConstants.offsetLeft50,
    this.animationType = FadeAnimationType.fromLeft,
    this.duration = AppConstants.fadeDuration600,
  });

  @override
  Widget build(BuildContext context) {
    return child
        .animate()
        .fadeIn(duration: duration)
        .move(duration: duration, begin: offset)
        .fade(duration: duration);
  }
}
