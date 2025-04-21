import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class AppTextPainter extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const AppTextPainter({super.key, required this.text, this.style});

  @override
  Widget build(BuildContext context) {
    final textStyle = style ?? Theme.of(context).textTheme.bodyMedium;
    // Use LayoutBuilder to get screen constraints
    return LayoutBuilder(
      builder: (context, constraints) {
        final painter = TextPainter(
          text: TextSpan(
            text: text,
            style: textStyle,
          ),
          textAlign: TextAlign.left,
          textDirection: ui.TextDirection.ltr,
          maxLines: null,
        );

        painter.layout(maxWidth: constraints.maxWidth);
        final textHeight = painter.height;

        return SingleChildScrollView(
          child: CustomPaint(
            size: Size(constraints.maxWidth, textHeight),
            painter: MyTextPainter(text, constraints.maxWidth, textStyle!),
          ),
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
      text: TextSpan(
        text: text,
        style: style,
      ),
      textDirection: ui.TextDirection.ltr,
      textAlign: TextAlign.left,
    );

    painter.layout(maxWidth: maxWidth);
    painter.paint(canvas, Offset.zero);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
