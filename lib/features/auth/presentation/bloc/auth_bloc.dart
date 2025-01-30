import 'dart:async';
import 'package:bloc_app/features/auth/domain/entities/user_entity.dart';
import 'package:bloc_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;

  AuthBloc({required UserSignUp userSignUp})
      : _userSignUp = userSignUp,
        super(AuthInitialState()) {
    on<AuthSignUp>(_onAuthSignUp);
  }

  FutureOr<dynamic> _onAuthSignUp(
      AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    final res = await _userSignUp.call(UserSignUpParams(
        name: event.name, email: event.email, password: event.password));
    res.fold((failure) => emit(AuthFailureState(message: failure.message)),
        (user) => emit(AuthSuccessState(user: user)));
  }
}
