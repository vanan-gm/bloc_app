import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final EdgeInsetsGeometry? padding;
  final TextStyle? style;

  const AppText({super.key, required this.text, this.padding, this.style});

  const AppText.padding({
    super.key,
    required this.text,
    required EdgeInsetsGeometry this.padding,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final child = Text(
      text,
      style: style ?? Theme.of(context).textTheme.bodyMedium,
    );

    return padding != null ? Padding(padding: padding!, child: child) : child;
  }
}
