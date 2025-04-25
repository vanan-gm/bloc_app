part of 'profile_bloc.dart';

abstract class ProfileEvent{}

final class GetProfileBlogsEvent extends ProfileEvent{
  final String userId;
  GetProfileBlogsEvent({required this.userId});
}