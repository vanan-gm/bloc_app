part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

final class AuthSignUp extends AuthEvent{
  final String name;
  final String email;
  final String password;
  AuthSignUp({required this.name, required this.email, required this.password});
}

final class AuthLogin extends AuthEvent{
  final String email;
  final String password;
  AuthLogin({required this.email, required this.password});
}

final class AuthSignOut extends AuthEvent{}

final class AuthIsUserLoggedIn extends AuthEvent{}