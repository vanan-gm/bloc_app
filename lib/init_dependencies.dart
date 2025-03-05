import 'package:bloc_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:bloc_app/core/network/connection_checker.dart';
import 'package:bloc_app/core/secrets/app_secrets.dart';
import 'package:bloc_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:bloc_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:bloc_app/features/auth/domain/repository/auth_repository.dart';
import 'package:bloc_app/features/auth/domain/usecases/get_current_user.dart';
import 'package:bloc_app/features/auth/domain/usecases/user_login.dart';
import 'package:bloc_app/features/auth/domain/usecases/user_sign_out.dart';
import 'package:bloc_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:bloc_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bloc_app/features/auth/presentation/streams/login_stream.dart';
import 'package:bloc_app/features/auth/presentation/streams/signup_stream.dart';
import 'package:bloc_app/features/blog/data/data_sources/blog_local_data_source.dart';
import 'package:bloc_app/features/blog/data/data_sources/blog_remote_data_source.dart';
import 'package:bloc_app/features/blog/data/repository/blog_repository_impl.dart';
import 'package:bloc_app/features/blog/domain/repository/blog_repository.dart';
import 'package:bloc_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:bloc_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:bloc_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  _initStreams();

  final supaBase = await Supabase.initialize(
      url: AppSecrets.supaBaseUrl, anonKey: AppSecrets.supaBaseAnonKey);
  Hive.defaultDirectory = (await getApplicationDocumentsDirectory()).path;
  getIt.registerLazySingleton(() => supaBase.client);

  getIt.registerLazySingleton(() => Hive.box(name: 'blogs'));

  getIt.registerFactory(() => InternetConnectionChecker.instance);

  // core
  getIt.registerLazySingleton(() => AppUserCubit());
  // Internet Checker
  getIt.registerFactory<ConnectionChecker>(
      () => ConnectionCheckerImpl(connectionChecker: getIt()));
}

void _initAuth() {
  // Datasource
  getIt
    ..registerFactory<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(supabaseClient: getIt()))
    // Repository
    ..registerFactory<AuthRepository>(() => AuthRepositoryImpl(
        authRemoteDataSource: getIt(), connectionChecker: getIt()))
    // Usecase
    ..registerFactory(() => UserSignUp(authRepository: getIt()))
    ..registerFactory(() => UserLogin(authRepository: getIt()))
    ..registerFactory(() => GetCurrentUser(authRepository: getIt()))
    ..registerFactory(() => UserSignOut(authRepository: getIt()))
    // Bloc
    ..registerLazySingleton(() => AuthBloc(
        userSignUp: getIt(),
        userLogin: getIt(),
        getCurrentUser: getIt(),
        appUserCubit: getIt(),
        userSignOut: getIt()));
}

void _initBlog() {
  // Datasource
  getIt
    ..registerFactory<BlogRemoteDataSource>(
        () => BlogRemoteDataSourceImpl(supabaseClient: getIt()))
    ..registerFactory<BlogLocalDataSource>(
        () => BlogLocalDataSourceImpl(box: getIt()))
    // Repository
    ..registerFactory<BlogRepository>(() => BlogRepositoryImpl(
          blogRemoteDataSource: getIt(),
          blogLocalDataSource: getIt(),
          connectionChecker: getIt(),
        ))
    // Usecase
    ..registerFactory(() => UploadBlog(blogRepository: getIt()))
    ..registerFactory(() => GetAllBlogs(blogRepository: getIt()))
    // Bloc
    ..registerLazySingleton(
        () => BlogBloc(uploadBlog: getIt(), getAllBlogs: getIt()));
}

void _initStreams() {
  getIt.registerLazySingleton<LoginStream>(() => LoginStream());
  getIt.registerLazySingleton<SignupStream>(() => SignupStream());
}
