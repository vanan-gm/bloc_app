part of 'profile_bloc.dart';

abstract class ProfileEvent {}

final class GetProfileBlogEvent extends ProfileEvent {
  final String userId;
  GetProfileBlogEvent({required this.userId});
}
