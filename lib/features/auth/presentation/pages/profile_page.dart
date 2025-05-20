import 'dart:math';

import 'package:bloc_app/core/common/utils/image_picker_service.dart';
import 'package:bloc_app/core/common/widgets/app_icon.dart';
import 'package:bloc_app/core/common/widgets/circle_avatar_image.dart';
import 'package:bloc_app/features/auth/data/models/user.dart';
import 'package:bloc_app/generated/assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:bloc_app/core/common/extesions/string_ext.dart';
import 'package:bloc_app/core/common/paths/app_path.dart';
import 'package:bloc_app/core/common/utils/app_dialog.dart';
import 'package:bloc_app/core/common/widgets/cached_network_img.dart';
import 'package:bloc_app/core/common/widgets/loading_widget.dart';
import 'package:bloc_app/core/common/widgets/ripple_effect.dart';
import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/core/enums/card_type.dart';
import 'package:bloc_app/core/theme/app_colors.dart';
import 'package:bloc_app/features/auth/presentation/bloc/auth_bloc.dart' as ab;
import 'package:bloc_app/features/blog/domain/entities/blog.dart';
import 'package:bloc_app/features/blog/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:bloc_app/features/blog/presentation/pages/blog_detail_page.dart';
import 'package:bloc_app/features/blog/presentation/widgets/blog_card.dart';
import 'package:bloc_app/init_dependencies.dart';

class ProfilePage extends StatefulWidget {
  static route() => CupertinoPageRoute(builder: (_) => const ProfilePage());
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ValueNotifier<UserModel?> _user = ValueNotifier(null);
  bool _showDetails = true;
  final ValueNotifier<String> _image = ValueNotifier(
    AppPath.defaultUserImageUrl,
  );
  final ValueNotifier<bool> _isLoading = ValueNotifier(false);
  final List<String> images = [
    AppPath.picturesProfileImageUrl1,
    AppPath.picturesProfileImageUrl2,
    AppPath.picturesProfileImageUrl3,
    AppPath.picturesProfileImageUrl4,
    AppPath.picturesProfileImageUrl5,
    AppPath.picturesProfileImageUrl6,
    AppPath.picturesProfileImageUrl7,
    AppPath.picturesProfileImageUrl8,
    AppPath.picturesProfileImageUrl9,
    AppPath.picturesProfileImageUrl10,
    AppPath.picturesProfileImageUrl11,
    AppPath.picturesProfileImageUrl12,
  ];
  List<Blog> blogs = [];

  @override
  void initState() {
    super.initState();
    callReads();
  }

  Future<void> handleRefresh() async {
    await Future.delayed(AppConstants.refreshDuration, () {});
    if (!mounted) return;
    callReads();
  }

  void callReads() {
    context.read<ab.AuthBloc>().add(ab.CheckUserLoggedInEvent());
    context.read<ProfileBloc>().add(
      GetProfileBlogsEvent(
        userId: getIt<SupabaseClient>().auth.currentSession!.user.id,
      ),
    );
  }

  void setDetailAppear() {
    setState(() {
      _showDetails = !_showDetails;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          "Profile",
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: AppConstants.paddingSmall,
            bottom: AppConstants.paddingTiny,
          ),
          child: BlocListener<ab.AuthBloc, ab.AuthState>(
            listener: (context, state) {
              if (state is ab.AuthSuccessState) {
                _isLoading.value = false;
                _user.value = UserModel.fromEntity(state.user);
                _image.value = state.user.imageUrl;
              } else if (state is ab.AuthLoadingState) {
                _isLoading.value = true;
              } else if (state is ab.AuthUpdateAvatarSuccessState) {
                _isLoading.value = false;
                _image.value = state.imageUrl;
              }
            },
            child: BlocListener<ProfileBloc, ProfileState>(
              listener: (context, state) {
                if (state is GetProfileSuccessState) {
                  blogs = state.blogs;
                  setState(() {});
                }
              },
              child: ValueListenableBuilder(
                valueListenable: _isLoading,
                builder: (context, isLoading, _) {
                  return AbsorbPointer(
                    absorbing: isLoading,
                    child: RefreshIndicator(
                      onRefresh: handleRefresh,
                      child: ValueListenableBuilder(
                        valueListenable: _user,
                        builder: (context, user, _) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ValueListenableBuilder(
                                valueListenable: _image,
                                builder: (context, image, _) {
                                  return Align(
                                    alignment: Alignment.center,
                                    child: CircleAvatarImage(
                                      image: image,
                                      radius: AppConstants.circleAvatarBigSize,
                                      onTap: () async {
                                        final pickedImage =
                                            await getIt<ImagePickerService>()
                                                .pickFromGallery();
                                        if (pickedImage == null) return;
                                        if (!context.mounted) return;
                                        context.read<ab.AuthBloc>().add(
                                          ab.UpdateUserAvatarEvent(
                                            userId: _user.value!.id,
                                            imageFile: pickedImage,
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: AppConstants.paddingSmall,
                                ),
                                child: Row(
                                  children: [
                                    Spacer(),
                                    Text(
                                      user != null
                                          ? user.name
                                              .upperFirstLetterWithSpace()
                                          : "",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleMedium!.copyWith(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: AppConstants.paddingTiny,
                                        ),
                                        child: RippleEffect(
                                          onTap: () => setDetailAppear.call(),
                                          child: TweenAnimationBuilder(
                                            tween: Tween<double>(
                                              begin: pi,
                                              end: _showDetails ? pi : 0,
                                            ),
                                            duration:
                                                AppConstants.rotationDuration,
                                            builder: (context, value, child) {
                                              return Transform.rotate(
                                                angle: value,
                                                child: AppIcon.asset(
                                                  Assets.iconsIcUpArrow,
                                                  color: AppColors.white,
                                                  size:
                                                      AppConstants
                                                          .iconMediumSize,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              AnimatedContainer(
                                duration: AppConstants.rotationDuration,
                                height:
                                    _showDetails
                                        ? AppConstants.containerDetailHeight
                                        : 0,
                                curve: Curves.easeInOut,
                                padding: EdgeInsets.only(
                                  top: AppConstants.paddingSmall,
                                  left: AppConstants.paddingMediumSmall,
                                  right: AppConstants.paddingMediumSmall,
                                ),
                                child: ClipRect(
                                  child: SingleChildScrollView(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        buildInfoSection("28K", 'Followers'),
                                        buildInfoSection(
                                          "${blogs.length}",
                                          'Posts',
                                        ),
                                        buildInfoSection("734K", 'Likes'),
                                        buildInfoSection("983K", 'Views'),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: AppConstants.paddingSmall,
                                  ),
                                  child: DefaultTabController(
                                    length: 3,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal:
                                                AppConstants.paddingMediumSmall,
                                          ),
                                          child: SizedBox(
                                            height: 35,
                                            child: TabBar(
                                              labelColor: AppColors.white,
                                              unselectedLabelColor:
                                                  AppColors.white,
                                              indicatorColor:
                                                  AppColors.transparentColor,
                                              labelStyle:
                                                  Theme.of(
                                                    context,
                                                  ).textTheme.bodyMedium,
                                              unselectedLabelStyle:
                                                  Theme.of(
                                                    context,
                                                  ).textTheme.bodyMedium,
                                              dividerColor:
                                                  AppColors.transparentColor,
                                              splashBorderRadius:
                                                  BorderRadius.circular(
                                                    AppConstants.borderTab,
                                                  ),
                                              indicatorSize:
                                                  TabBarIndicatorSize.tab,
                                              indicator: BoxDecoration(
                                                color: AppColors.gradient1,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                      AppConstants.borderTab,
                                                    ),
                                              ),
                                              tabs: [
                                                Tab(text: "Updates"),
                                                Tab(text: "Pictures"),
                                                Tab(text: "About"),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              top: AppConstants.paddingTiny,
                                            ),
                                            child: TabBarView(
                                              children: [
                                                buildFirstTab(blogs),
                                                buildSecondTab(),
                                                buildThirdTab(
                                                  user != null ? user.name : "",
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFirstTab(List<Blog> blogs) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoadingState) {
          return const LoadingWidget();
        } else if (state is GetProfileSuccessState) {
          return ListView.builder(
            itemCount: blogs.length,
            itemBuilder: (context, i) {
              return BlogCard(
                blog: blogs[i],
                cardType: CardType.horizontal,
                padding: EdgeInsets.symmetric(
                  horizontal: AppConstants.paddingSmall,
                ).copyWith(
                  bottom:
                      i < blogs.length - 1 ? AppConstants.paddingSmall : 0.0,
                ),
                onTap: () {
                  Navigator.of(
                    context,
                  ).push(BlogDetailPage.route(blog: blogs[i]));
                },
              );
            },
          );
        } else {
          return SizedBox();
        }
      },
    );
  }

  Widget buildSecondTab() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppConstants.paddingSmall),
      child: MasonryGridView.builder(
        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
        itemCount: images.length,
        itemBuilder: (context, index) {
          return RippleEffect(
            onTap:
                () => AppDialog.showImageViewerDialog(
                  context: context,
                  imageUrl: images[index],
                ),
            child: CachedNetworkImg(imageUrl: images[index]),
          );
        },
      ),
    );
  }

  Widget buildThirdTab(String name) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppConstants.paddingSmall),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "Hi, I'm $name, a passionate traveler, storyteller, and blogger with an insatiable curiosity for exploring the world. "
              "Traveling isn't just a hobby for me—it's a way of life. From wandering through ancient streets filled with history to relaxing on pristine,"
              " untouched beaches, every journey fuels my desire to discover and share.",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(height: 1.7),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: AppConstants.paddingSmall,
              ),
              child: CachedNetworkImg(imageUrl: AppPath.aboutProfileImageUrl),
            ),
            Text(
              "Through my blog, I bring my experiences to life with vivid storytelling, "
              "stunning photography, and practical travel tips. I love uncovering hidden gems, immersing myself in diverse cultures, and capturing the essence of each place I visit."
              " Whether it's solo adventures, cultural deep dives, food explorations, or road trips to breathtaking landscapes, I believe every journey has a story worth telling.",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(height: 1.7),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoSection(String title, String des) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: AppConstants.paddingMicroSmall * .1),
          child: Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        Text(
          des,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: AppColors.whiteColor.withValues(alpha: .6),
          ),
        ),
      ],
    );
  }
}
