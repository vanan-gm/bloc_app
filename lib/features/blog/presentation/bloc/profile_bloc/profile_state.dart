part of 'profile_bloc.dart';

abstract class ProfileState {}

final class ProfileInitialState extends ProfileState {}

final class ProfileLoadingState extends ProfileState {}

final class ProfileFetchedState extends ProfileState {
  final List<Blog> blogs;
  ProfileFetchedState({required this.blogs});
}

final class ProfileFailureState extends ProfileState {
  final String message;
  ProfileFailureState({required this.message});
}
