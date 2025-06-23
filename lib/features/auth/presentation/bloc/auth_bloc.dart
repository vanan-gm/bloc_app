import 'dart:async';
import 'dart:io';
import 'package:bloc_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:bloc_app/core/usercase/usecase.dart';
import 'package:bloc_app/core/common/entities/user.dart';
import 'package:bloc_app/features/auth/domain/usecases/change_password.dart';
import 'package:bloc_app/features/auth/domain/usecases/get_current_user.dart';
import 'package:bloc_app/features/auth/domain/usecases/update_user_avatar.dart';
import 'package:bloc_app/features/auth/domain/usecases/user_login.dart';
import 'package:bloc_app/features/auth/domain/usecases/user_sign_out.dart';
import 'package:bloc_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final GetCurrentUser _getCurrentUser;
  final UserSignOut _userSignOut;
  final AppUserCubit _appUserCubit;
  final ChangePassword _changePassword;
  final UpdateUserAvatar _updateAvatar;

  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
    required GetCurrentUser getCurrentUser,
    required UserSignOut userSignOut,
    required AppUserCubit appUserCubit,
    required ChangePassword changePassword,
    required UpdateUserAvatar updateAvatar,
  }) : _userSignUp = userSignUp,
       _userLogin = userLogin,
       _getCurrentUser = getCurrentUser,
       _userSignOut = userSignOut,
       _appUserCubit = appUserCubit,
       _changePassword = changePassword,
       _updateAvatar = updateAvatar,
       super(AuthInitialState()) {
    // Here we handle for every events, we will emit LoadingState first for all of them
    on<AuthEvent>((_, emit) => emit(AuthLoadingState()));
    on<SignUpEvent>(_onSignUp);
    on<LoginEvent>(_onLogin);
    on<SignOutEvent>(_onSignOut);
    on<CheckUserLoggedInEvent>(_onCheckUserLoggedIn);
    on<ChangePasswordEvent>(_onChangePasswordEvent);
    on<UpdateUserAvatarEvent>(_onUpdateUserAvatarEvent);
  }

  FutureOr<dynamic> _onSignUp(
    SignUpEvent event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _userSignUp.call(
      UserSignUpParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );
    res.fold(
      (failure) => emit(AuthFailureState(message: failure.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  FutureOr<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    final res = await _userLogin.call(
      UserLoginParams(email: event.email, password: event.password),
    );
    res.fold(
      (failure) => emit(AuthFailureState(message: failure.message)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  Future<void> _onSignOut(SignOutEvent event, Emitter<AuthState> emit) async {
    final res = await _userSignOut.call(NoParams());
    res.fold(
      (failure) => emit(AuthFailureState(message: failure.message)),
      (_) => emit(AuthSignOutSuccessState()),
    );
  }

  FutureOr<void> _onCheckUserLoggedIn(
    CheckUserLoggedInEvent event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _getCurrentUser(NoParams());
    res.fold(
      (failure) {
        emit(AuthFailureState(message: failure.message));
      },
      (user) {
        _emitAuthSuccess(user, emit);
      },
    );
  }

  FutureOr<void> _onChangePasswordEvent(
    ChangePasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _changePassword.call(
      ChangePasswordParams(
        newPassword: event.newPassword,
        confirmPassword: event.confirmPassword,
      ),
    );
    res.fold(
      (failure) => emit(AuthFailureState(message: failure.message)),
      (data) => emit(AuthChangePasswordSuccessState()),
    );
  }

  FutureOr<void> _onUpdateUserAvatarEvent(
    UpdateUserAvatarEvent event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _updateAvatar.call(
      UpdateAvatarParams(userId: event.userId, image: event.imageFile),
    );
    res.fold(
      (failure) => emit(AuthFailureState(message: failure.message)),
      (imageUrl) => emit(AuthUpdateAvatarSuccessState(imageUrl: imageUrl)),
    );
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccessState(user: user));
  }
}
