part of 'app_user_cubit.dart';

@immutable
abstract class AppUserState {}

final class AppUserInitialState extends AppUserState {}

final class AppUserLoggedInState extends AppUserState {
  final User user;
  AppUserLoggedInState({required this.user});
}

// core cannot depend on other features
// other features can depend on core
