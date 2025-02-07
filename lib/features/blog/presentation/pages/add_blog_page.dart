import 'dart:io';

import 'package:bloc_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:bloc_app/core/common/utils/pick_image.dart';
import 'package:bloc_app/core/common/utils/show_custom_overlay.dart';
import 'package:bloc_app/core/common/widgets/loading_widget.dart';
import 'package:bloc_app/core/common/widgets/ripple_effect.dart';
import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/core/theme/app_pallete.dart';
import 'package:bloc_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:bloc_app/features/blog/presentation/pages/blog_page.dart';
import 'package:bloc_app/features/blog/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddBlogPage extends StatefulWidget {
  static route() =>
      CupertinoPageRoute(builder: (context) => const AddBlogPage());

  const AddBlogPage({super.key});

  @override
  State<AddBlogPage> createState() => _AddBlogPageState();
}

class _AddBlogPageState extends State<AddBlogPage> {
  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _contentCtrl = TextEditingController();
  final List<String> _selectedTopics = [];
  File? image;

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  void handleUploadBlog(){
    final posterId =
        (context.read<AppUserCubit>().state as AppUserLoggedInState)
            .userEntity
            .id;
    context.read<BlogBloc>().add(BlogUploadEvent(
      posterId: posterId,
      title: _titleCtrl.text.trim(),
      content: _contentCtrl.text.trim(),
      image: image!,
      topics: _selectedTopics,
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _titleCtrl.dispose();
    _contentCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: handleUploadBlog,
              icon: const Icon(Icons.done_rounded)),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppConstants.paddingSmall),
          child: BlocConsumer<BlogBloc, BlogState>(
            listener: (context, state){
              if(state is BlogFailureState){
                showCustomOverlay(context: context, isSuccessType: false, content: 'Failed to upload blog');
              }else if(state is BlogSuccessState){
                Navigator.of(context).pushAndRemoveUntil(BlogPage.route(), (route) => false);
              }
            },
            builder: (context, state){
              if(state is BlogLoadingState){
                return const LoadingWidget();
              }else{
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      image == null
                          ? RippleEffect(
                        onTap: () {
                          selectImage();
                        },
                        child: DottedBorder(
                            color: AppPallete.borderColor,
                            dashPattern: const [10, 4],
                            radius:
                            const Radius.circular(AppConstants.borderImage),
                            borderType: BorderType.RRect,
                            strokeCap: StrokeCap.round,
                            child: SizedBox(
                              height: AppConstants.containerHeight,
                              width: AppConstants.widthScreen,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.folder_open,
                                    size: AppConstants.iconHugeSize,
                                  ),
                                  SizedBox(
                                    height: AppConstants.paddingSmall,
                                  ),
                                  const Text(
                                    'Select your image',
                                    style: TextStyle(
                                        fontSize: AppConstants.textMediumSize),
                                  )
                                ],
                              ),
                            )),
                      )
                          : RippleEffect(
                        onTap: selectImage,
                        child: SizedBox(
                          width: AppConstants.widthScreen,
                          height: AppConstants.containerHeight,
                          child: ClipRRect(
                            borderRadius:
                            BorderRadius.circular(AppConstants.borderImage),
                            child: Image.file(
                              image!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: AppConstants.paddingSmall,
                      ),
                      SizedBox(
                        height: AppConstants.containerTopicHeight,
                        child: ListView.builder(
                            itemCount: AppConstants.topics.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, i) {
                              final item = AppConstants.topics[i];
                              return Padding(
                                  padding: EdgeInsets.only(
                                      right: i != AppConstants.topics.length - 1
                                          ? AppConstants.paddingTiny
                                          : 0.0),
                                  child: RippleEffect(
                                    onTap: () {
                                      if (!_selectedTopics.contains(item)) {
                                        _selectedTopics.add(item);
                                      } else if (_selectedTopics.contains(item)) {
                                        _selectedTopics.remove(item);
                                      }
                                      setState(() {});
                                    },
                                    padding: EdgeInsets.symmetric(
                                        vertical: AppConstants.paddingTiny),
                                    child: Chip(
                                      label: Text(item),
                                      color: _selectedTopics.contains(item)
                                          ? const MaterialStatePropertyAll(
                                          AppPallete.gradient1)
                                          : null,
                                      side: const BorderSide(
                                          color: AppPallete.borderColor),
                                    ),
                                  ));
                            }),
                      ),
                      SizedBox(
                        height: AppConstants.paddingSmall,
                      ),
                      BlogEditor(controller: _titleCtrl, hintText: 'Blog title'),
                      SizedBox(
                        height: AppConstants.paddingSmall,
                      ),
                      BlogEditor(controller: _contentCtrl, hintText: 'Blog content'),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
