import 'dart:async';
import 'package:bloc_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:bloc_app/core/usercase/usecase.dart';
import 'package:bloc_app/core/common/entities/user_entity.dart';
import 'package:bloc_app/features/auth/domain/usecases/get_current_user.dart';
import 'package:bloc_app/features/auth/domain/usecases/user_login.dart';
import 'package:bloc_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final GetCurrentUser _getCurrentUser;
  final AppUserCubit _appUserCubit;

  AuthBloc(
      {required UserSignUp userSignUp,
      required UserLogin userLogin,
      required GetCurrentUser getCurrentUser,
      required AppUserCubit appUserCubit})
      : _userSignUp = userSignUp,
        _userLogin = userLogin,
        _getCurrentUser = getCurrentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitialState()) {
    // Here we handle for every events, we will emit LoadingState first for all of them
    on<AuthEvent>((_, emit) => emit(AuthLoadingState()));
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
    on<AuthIsUserLoggedIn>(_onAuthIsUserLoggedIn);
  }

  FutureOr<dynamic> _onAuthSignUp(
      AuthSignUp event, Emitter<AuthState> emit) async {
    final res = await _userSignUp.call(UserSignUpParams(
        name: event.name, email: event.email, password: event.password));
    res.fold((failure) => emit(AuthFailureState(message: failure.message)),
        (user) => _emitAuthSuccess(user, emit));
  }

  FutureOr<void> _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    final res = await _userLogin
        .call(UserLoginParams(email: event.email, password: event.password));
    res.fold((failure) => emit(AuthFailureState(message: failure.message)),
        (user) => _emitAuthSuccess(user, emit));
  }

  FutureOr<void> _onAuthIsUserLoggedIn(
      AuthIsUserLoggedIn event, Emitter<AuthState> emit) async {
    final res = await _getCurrentUser(NoParams());
    res.fold((failure) {
      emit(AuthFailureState(message: failure.message));
    }, (user) {
      _emitAuthSuccess(user, emit);
    });
  }

  void _emitAuthSuccess(UserEntity user, Emitter<AuthState> emit){
    _appUserCubit.updateUser(user);
    emit(AuthSuccessState(user: user));
  }
}
