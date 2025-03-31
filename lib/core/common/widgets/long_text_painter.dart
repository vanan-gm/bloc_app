import 'package:flutter/material.dart';
import 'package:bloc_app/core/constants/app_constants.dart';

class LongTextPainter extends StatefulWidget {
  final String text;
  final TextStyle textStyle;

  const LongTextPainter({
    super.key,
    required this.text,
    this.textStyle = const TextStyle(fontSize: 16, color: Colors.black),
  });

  @override
  _LongTextPainterState createState() => _LongTextPainterState();
}

class _LongTextPainterState extends State<LongTextPainter> {
  double _calculatedHeight = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateTextHeight();
    });
  }

  void _calculateTextHeight() {
    final screenWidth = AppConstants.widthScreen - (AppConstants.paddingSmall * 2); // Adjust for padding
    final List<String> paragraphs = widget.text.split('\n\n');
    double totalHeight = 0;

    for (String paragraph in paragraphs) {
      final List<String> lines = paragraph.split('\n');

      for (String line in lines) {
        final textSpan = TextSpan(text: line, style: widget.textStyle);
        final textPainter = TextPainter(
          text: textSpan,
          textDirection: TextDirection.ltr,
          maxLines: null,
        );

        textPainter.layout(maxWidth: screenWidth);
        totalHeight += textPainter.height;
      }

      totalHeight += AppConstants.paddingSmall; // ✅ Extra spacing between paragraphs
    }

    setState(() {
      _calculatedHeight = totalHeight - AppConstants.paddingSmall; // ❌ Remove last extra spacing
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = AppConstants.widthScreen - (AppConstants.paddingSmall * 2);

    return SingleChildScrollView(
      controller: _scrollController,
      child: CustomPaint(
        painter: ParagraphTextPainter(widget.text, widget.textStyle, screenWidth),
        size: Size(screenWidth, _calculatedHeight),
      ),
    );
  }
}

class ParagraphTextPainter extends CustomPainter {
  final String text;
  final TextStyle textStyle;
  final double maxWidth;

  ParagraphTextPainter(this.text, this.textStyle, this.maxWidth);

  @override
  void paint(Canvas canvas, Size size) {
    final List<String> paragraphs = text.split('\n\n'); // ✅ Preserve empty lines as paragraph breaks
    double yOffset = 0;

    for (String paragraph in paragraphs) {
      final List<String> lines = paragraph.split('\n'); // ✅ Handle individual lines inside a paragraph

      for (String line in lines) {
        final textSpan = TextSpan(text: line, style: textStyle);
        final textPainter = TextPainter(
          text: textSpan,
          textAlign: TextAlign.left,
          textDirection: TextDirection.ltr,
          maxLines: null, // ✅ Allow text wrapping
        );

        textPainter.layout(maxWidth: maxWidth);
        textPainter.paint(canvas, Offset(0, yOffset));
        yOffset += textPainter.height; // ✅ Move down for next line
      }

      yOffset += AppConstants.paddingSmall; // ✅ Extra spacing between paragraphs
    }
  }

  @override
  bool shouldRepaint(ParagraphTextPainter oldDelegate) {
    return oldDelegate.text != text || oldDelegate.textStyle != textStyle || oldDelegate.maxWidth != maxWidth;
  }
}
