import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_app/features/blog/domain/entities/blog.dart';
import 'package:bloc_app/features/blog/domain/usecases/get_blogs_by_user_id.dart';

part 'profile_state.dart';

part 'profile_event.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetBlogsByUserId _getBlogsByUserId;

  ProfileBloc({required GetBlogsByUserId getBlogsByUserId})
    : _getBlogsByUserId = getBlogsByUserId,
      super(ProfileInitialState()) {
    on<ProfileEvent>((_, emit) => emit(ProfileLoadingState()));
    on<GetProfileBlogEvent>(_onGetProfileBlogsEvent);
  }

  FutureOr<void> _onGetProfileBlogsEvent(
    GetProfileBlogEvent event,
    Emitter<ProfileState> emit,
  ) async {
    final res = await _getBlogsByUserId.call(event.userId);
    res.fold(
      (failure) => emit(ProfileFailureState(message: failure.message)),
      (blogs) => emit(ProfileFetchedState(blogs: blogs)),
    );
  }
}
