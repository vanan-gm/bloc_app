import 'package:bloc_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:bloc_app/core/error/exceptions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension BuildcontextExt on BuildContext{
  String get currentUserId{
    final state = read<AppUserCubit>().state;
    if(state is AppUserLoggedInState){
      return state.userEntity.id;
    }else{
      throw ServerException(message: 'User not logged in');
    }
  }
}