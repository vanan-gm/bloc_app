import 'dart:io';

import 'package:bloc_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:bloc_app/core/common/extesions/buildcontext_ext.dart';
import 'package:bloc_app/core/common/extesions/localization_ext.dart';
import 'package:bloc_app/core/common/utils/image_picker_service.dart';
import 'package:bloc_app/core/common/utils/show_custom_overlay.dart';
import 'package:bloc_app/core/common/widgets/loading_widget.dart';
import 'package:bloc_app/core/common/widgets/ripple_effect.dart';
import 'package:bloc_app/core/common/widgets/common_text_field.dart';
import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/core/theme/app_colors.dart';
import 'package:bloc_app/core/theme/app_pallete.dart';
import 'package:bloc_app/features/blog/presentation/bloc/blog_bloc/blog_bloc.dart';
import 'package:bloc_app/features/blog/presentation/pages/blog_page.dart';
import 'package:bloc_app/features/blog/presentation/pages/master_page.dart';
import 'package:bloc_app/features/blog/presentation/streams/add_blog_stream.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_app/init_dependencies.dart';

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
  final ValueNotifier<bool> _enableSaveButton = ValueNotifier(false);
  final ValueNotifier<List<String>> _selectedTopics = ValueNotifier([]);
  final addBlogStream = getIt<AddBlogStream>();
  final ValueNotifier<File?> _image = ValueNotifier(null);

  void selectImage() async {
    final pickedImage = await getIt<ImagePickerService>().pickFromGallery();
    if (pickedImage != null) {
      _image.value = pickedImage;
      setValueForSaveButton();
    }
  }

  void handleUploadBlog() {
    final posterId = context.currentUserId;
    context.read<BlogBloc>().add(
      BlogUploadEvent(
        posterId: posterId,
        title: _titleCtrl.text.trim(),
        content: _contentCtrl.text.trim(),
        image: _image.value!,
        topics: _selectedTopics.value,
      ),
    );
  }

  bool get checkBeforeAddBlog =>
      _image.value != null &&
      _selectedTopics.value.isNotEmpty &&
      _titleCtrl.text.trim().isNotEmpty &&
      _titleCtrl.text.trim().length >= 6 &&
      _contentCtrl.text.trim().isNotEmpty &&
      _contentCtrl.text.trim().length >= 6;

  void setValueForSaveButton() {
    _enableSaveButton.value = checkBeforeAddBlog;
  }

  @override
  void initState() {
    super.initState();
    _titleCtrl.addListener(setValueForSaveButton);
    _contentCtrl.addListener(setValueForSaveButton);
  }

  @override
  void dispose() {
    super.dispose();
    _titleCtrl.dispose();
    _contentCtrl.dispose();
    addBlogStream.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          actions: [buildActionButton],
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(AppConstants.paddingSmall),
            child: BlocConsumer<BlogBloc, BlogState>(
              listener: (context, state) {
                if (state is BlogFailureState) {
                  showCustomOverlay(
                    context: context,
                    isSuccessType: false,
                    content: context.translate.failedToUploadBlog,
                  );
                } else if (state is BlogSuccessState) {
                  Navigator.of(context).pop(true);
                }
              },
              builder: (context, state) {
                if (state is BlogLoadingState) {
                  return const LoadingWidget();
                } else {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        buildImageSelection,
                        SizedBox(height: AppConstants.paddingSmall),
                        buildCategorySelection,
                        SizedBox(height: AppConstants.paddingSmall),
                        CommonTextField(
                          controller: _titleCtrl,
                          hintText: context.translate.blogTitle,
                          stream: addBlogStream.blogTitleStreamS(context),
                          onChange: addBlogStream.blogTitleChange,
                          linesLimit: null,
                        ),
                        SizedBox(height: AppConstants.paddingSmall),
                        CommonTextField(
                          controller: _contentCtrl,
                          hintText: context.translate.blogContent,
                          stream: addBlogStream.blogContentStreams(context),
                          onChange: addBlogStream.blogContentChange,
                          linesLimit: null,
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget get buildActionButton {
    return ValueListenableBuilder(
      valueListenable: _enableSaveButton,
      builder: (context, enableButton, _) {
        return IconButton(
          onPressed: enableButton ? handleUploadBlog : null,
          icon: Icon(
            Icons.done_rounded,
            color:
                enableButton
                    ? (context.isLightMode ? AppColors.black : AppColors.white)
                    : (context.isLightMode
                        ? AppColors.black.withValues(alpha: .4)
                        : AppColors.white.withValues(alpha: .4)),
          ),
        );
      },
    );
  }

  Widget get buildImageSelection {
    return ValueListenableBuilder(
      valueListenable: _image,
      builder: (context, image, _) {
        return image == null
            ? RippleEffect(
              onTap: () {
                selectImage();
              },
              child: DottedBorder(
                color: AppPallete.borderColor,
                dashPattern: const [10, 4],
                radius: const Radius.circular(AppConstants.borderImage),
                borderType: BorderType.RRect,
                strokeCap: StrokeCap.round,
                child: SizedBox(
                  height: AppConstants.containerHeight,
                  width: AppConstants.widthScreen,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.folder_open, size: AppConstants.iconHugeSize),
                      SizedBox(height: AppConstants.paddingSmall),
                      Text(
                        context.translate.selectYourImage,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            )
            : RippleEffect(
              onTap: selectImage,
              child: SizedBox(
                width: AppConstants.widthScreen,
                height: AppConstants.containerHeight,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppConstants.borderImage),
                  child: Image.file(image, fit: BoxFit.cover),
                ),
              ),
            );
      },
    );
  }

  Widget get buildCategorySelection {
    return ValueListenableBuilder(
      valueListenable: _selectedTopics,
      builder: (context, selectedTopics, _) {
        return SizedBox(
          height: AppConstants.containerTopicHeight,
          child: ListView.builder(
            itemCount: AppConstants.topics(context).length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, i) {
              final item = AppConstants.topics(context)[i];
              return Padding(
                padding: EdgeInsets.only(
                  right:
                      i != AppConstants.topics(context).length - 1
                          ? AppConstants.paddingTiny
                          : 0.0,
                ),
                child: FilterChip(
                  label: Text(
                    item,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color:
                          selectedTopics.contains(item)
                              ? AppColors.white
                              : (context.isLightMode
                                  ? AppColors.black
                                  : AppColors.white),
                    ),
                  ),
                  color:
                      selectedTopics.contains(item)
                          ? const WidgetStatePropertyAll(AppPallete.gradient1)
                          : null,
                  side: const BorderSide(color: AppPallete.borderColor),
                  selected: selectedTopics.contains(item),
                  checkmarkColor: AppColors.white,
                  onSelected: (value) {
                    if (!_selectedTopics.value.contains(item)) {
                      _selectedTopics.value = [..._selectedTopics.value, item];
                    } else if (_selectedTopics.value.contains(item)) {
                      _selectedTopics.value =
                          _selectedTopics.value
                              .where(
                                (e) =>
                                    e.trim().toLowerCase() !=
                                    item.trim().toLowerCase(),
                              )
                              .toList();
                    }
                    setValueForSaveButton();
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
