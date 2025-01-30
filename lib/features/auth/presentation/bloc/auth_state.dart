part of 'auth_bloc.dart';

@immutable
abstract class AuthState {
  const AuthState();
}

final class AuthInitialState extends AuthState {}

final class AuthLoadingState extends AuthState{}

final class AuthSuccessState extends AuthState{
  final UserEntity user;
  const AuthSuccessState({required this.user});
}

final class AuthFailureState extends AuthState{
  final String message;
  const AuthFailureState({required this.message});
}