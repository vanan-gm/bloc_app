part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

final class SignUpEvent extends AuthEvent{
  final String name;
  final String email;
  final String password;
  SignUpEvent({required this.name, required this.email, required this.password});
}

final class LoginEvent extends AuthEvent{
  final String email;
  final String password;
  LoginEvent({required this.email, required this.password});
}

final class SignOutEvent extends AuthEvent{}

final class CheckUserLoggedInEvent extends AuthEvent{}

final class UpdateUserAvatarEvent extends AuthEvent{}