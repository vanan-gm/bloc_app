part of 'favorite_bloc.dart';

@immutable
sealed class FavoriteBlogEvent {}

final class FavoriteBlogGetAllEvent extends FavoriteBlogEvent{
  final String userId;
  FavoriteBlogGetAllEvent({required this.userId});
}

