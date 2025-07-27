import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/features/blog/presentation/widgets/loading_blog_widget.dart';
import 'package:flutter/material.dart';

class LoadingBlogsList extends StatelessWidget {
  const LoadingBlogsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: AppConstants.itemPerPage,
      itemBuilder: (context, index) {
        return LoadingBlogWidget();
      },
    );
  }
}
