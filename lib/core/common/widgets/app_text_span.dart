import 'package:flutter/material.dart';

class AppTextSpan extends StatelessWidget {
  final String firstText;
  final String secondText;
  final EdgeInsetsGeometry? padding;
  final TextStyle? firstStyle;
  final TextStyle? secondStyle;

  const AppTextSpan({
    super.key,
    required this.firstText,
    required this.secondText,
    this.padding,
    this.firstStyle,
    this.secondStyle,
  });

  const AppTextSpan.padding({
    super.key,
    required this.firstText,
    required this.secondText,
    required EdgeInsetsGeometry this.padding,
    this.firstStyle,
    this.secondStyle,
  });

  @override
  Widget build(BuildContext context) {
    final richText = RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: [
          TextSpan(
            text: firstText,
            style:
                firstStyle ??
                Theme.of(
                  context,
                ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600),
          ),
          TextSpan(
            text: secondText,
            style: secondStyle ?? Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );

    return padding != null
        ? Padding(padding: padding!, child: richText)
        : richText;
  }
}
