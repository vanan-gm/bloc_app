import 'dart:ui' as ui;
import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

class AppTextPainter extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final double? fontSize;
  final Duration? duration;

  const AppTextPainter({
    super.key,
    required this.text,
    this.style,
    this.fontSize,
    this.duration,
  });

  @override
  Widget build(BuildContext context) {
    final baseStyle = style ?? Theme.of(context).textTheme.bodyMedium!;
    return LayoutBuilder(
      builder: (context, constraints) {
        return TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: fontSize, end: fontSize),
          duration: duration ?? AppConstants.fadeDuration,
          curve: Curves.easeInOut,
          builder: (context, animatedFontSize, child) {
            final animatedStyle = baseStyle.copyWith(
              fontSize: animatedFontSize,
            );
            final painter = TextPainter(
              text: TextSpan(text: text, style: animatedStyle),
              textAlign: TextAlign.left,
              textDirection: ui.TextDirection.ltr,
              maxLines: null,
            );
            painter.layout(maxWidth: constraints.maxWidth);

            return SingleChildScrollView(
              child: CustomPaint(
                size: Size(constraints.maxWidth, painter.height),
                painter: MyTextPainter(
                  text,
                  constraints.maxWidth,
                  animatedStyle,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class MyTextPainter extends CustomPainter {
  final String text;
  final double maxWidth;
  final TextStyle style;

  MyTextPainter(this.text, this.maxWidth, this.style);

  @override
  void paint(Canvas canvas, Size size) {
    final painter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: ui.TextDirection.ltr,
      textAlign: TextAlign.left,
    );

    painter.layout(maxWidth: maxWidth);
    painter.paint(canvas, Offset.zero);
  }

  @override
  bool shouldRepaint(covariant MyTextPainter oldDelegate) {
    return oldDelegate.text != text ||
        oldDelegate.maxWidth != maxWidth ||
        oldDelegate.style != style;
  }
}
