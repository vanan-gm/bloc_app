import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final double? strokeWidth;
  const LoadingWidget({super.key, this.strokeWidth});

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(strokeWidth: strokeWidth,),);
  }
}
