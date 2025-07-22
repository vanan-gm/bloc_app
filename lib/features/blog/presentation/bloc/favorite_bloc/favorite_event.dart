part of 'favorite_bloc.dart';

@immutable
sealed class FavoriteBlogEvent {}

final class GetAllFavoriteBlogsEvent extends FavoriteBlogEvent {
  final String userId;
  GetAllFavoriteBlogsEvent({required this.userId});
}
