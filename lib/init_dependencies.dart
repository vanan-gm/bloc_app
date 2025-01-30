import 'package:bloc_app/core/secrets/app_secrets.dart';
import 'package:bloc_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:bloc_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:bloc_app/features/auth/domain/repository/auth_repository.dart';
import 'package:bloc_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:bloc_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supaBase = await Supabase.initialize(
      url: AppSecrets.supaBaseUrl, anonKey: AppSecrets.supaBaseAnonKey);
  getIt.registerLazySingleton(() => supaBase.client);
}

void _initAuth() {
  getIt.registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(supabaseClient: getIt()));
  getIt.registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(authRemoteDataSource: getIt()));
  getIt.registerFactory(() => UserSignUp(authRepository: getIt()));

  getIt.registerLazySingleton(() => AuthBloc(userSignUp: getIt()));
}
