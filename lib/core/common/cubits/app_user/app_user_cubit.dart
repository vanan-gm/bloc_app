import 'package:bloc_app/core/common/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(AppUserInitialState());

  void updateUser(User? user) {
    if (user == null) {
      emit(AppUserInitialState());
    } else {
      emit(AppUserLoggedInState(user: user));
    }
  }
}
