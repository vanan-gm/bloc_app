import 'dart:math';

import 'package:bloc_app/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_app/core/common/paths/app_path.dart';
import 'package:bloc_app/core/common/widgets/app_icon.dart';
import 'package:bloc_app/core/common/widgets/loading_widget.dart';
import 'package:bloc_app/core/common/widgets/ripple_effect.dart';
import 'package:bloc_app/core/common/widgets/search_field.dart';
import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/features/blog/domain/entities/blog.dart';
import 'package:bloc_app/features/blog/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:bloc_app/features/blog/presentation/pages/blog_detail_page.dart';
import 'package:bloc_app/features/blog/presentation/widgets/blog_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchCtrl = TextEditingController();
  List<Blog> blogs = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.paddingSmall,
      ).copyWith(bottom: AppConstants.paddingSmall),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: SearchField(
                  controller: _searchCtrl,
                  hintText: "Search blogs here...",
                  onClear: (){
                    setState(() {
                      blogs = [];
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: AppConstants.paddingTiny),
                child: RippleEffect(
                  onTap: (){
                    FocusManager.instance.primaryFocus!.unfocus();
                    context.read<SearchBloc>().add(SearchBlogsEvent(keyword: _searchCtrl.text.trim()));
                  },
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: AppIcon.asset(Assets.iconsIcSend)
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: AppConstants.paddingSmall),
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state){
                  if(state is SearchBlogsLoadingState){
                    return const LoadingWidget();
                  }else if(state is SearchBlogsSuccessState){
                    return ListView.builder(
                        itemCount: state.blogs.length,
                        itemBuilder: (context, i) {
                          final blog = state.blogs[i];
                          return BlogCard(
                            blog: blog,
                            padding: EdgeInsets.only(bottom: AppConstants.paddingSmall),
                            onTap: () {
                              Navigator.of(context)
                                  .push(BlogDetailPage.route(blog: blog));
                            },
                          );
                        });
                  }else{
                    return SizedBox();
                  }
                }
              ),
            ),
          )
        ],
      ),
    );
  }
}
