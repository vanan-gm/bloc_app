part of 'auth_bloc.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

final class AuthInitialState extends AuthState {}

final class AuthLoadingState extends AuthState {}

final class AuthSuccessState extends AuthState {
  final User user;
  const AuthSuccessState({required this.user});
}

final class AuthSignOutSuccessState extends AuthState {}

final class AuthUpdateAvatarSuccessState extends AuthState {
  final String imageUrl;
  const AuthUpdateAvatarSuccessState({required this.imageUrl});
}

final class AuthChangePasswordSuccessState extends AuthState {}

final class AuthFailureState extends AuthState {
  final String message;
  const AuthFailureState({required this.message});
}
