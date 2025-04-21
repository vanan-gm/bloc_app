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
import 'package:bloc_app/features/blog/data/data_sources/blog_remote_data_source.dart';
import 'package:bloc_app/features/blog/data/repository/blog_repository_impl.dart';
import 'package:bloc_app/features/blog/domain/repository/blog_repository.dart';
import 'package:bloc_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:bloc_app/features/blog/domain/usecases/get_blog_like_state.dart';
import 'package:bloc_app/features/blog/domain/usecases/get_blogs_by_keyword.dart';
import 'package:bloc_app/features/blog/domain/usecases/get_blogs_by_user_id.dart';
import 'package:bloc_app/features/blog/domain/usecases/update_blog_like_state.dart';
import 'package:bloc_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:bloc_app/features/blog/presentation/bloc/blog_bloc/blog_bloc.dart';
import 'package:bloc_app/features/blog/presentation/bloc/detail_bloc/blog_detail_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:bloc_app/features/blog/presentation/bloc/profile_blog/profile_bloc.dart';
import 'package:bloc_app/features/blog/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:bloc_app/features/blog/presentation/streams/add_blog_stream.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  _initStreams();

  final supaBase = await Supabase.initialize(
    url: AppSecrets.supaBaseUrl,
    anonKey: AppSecrets.supaBaseAnonKey,
  );
  getIt.registerLazySingleton(() => supaBase.client);

  getIt.registerFactory(() => InternetConnectionChecker.instance);

  // core
  getIt.registerLazySingleton(() => AppUserCubit());
  // Internet Checker
  getIt.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(connectionChecker: getIt()),
  );
}

void _initAuth() {
  // Datasource
  getIt
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(supabaseClient: getIt()),
    )
    // Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        authRemoteDataSource: getIt(),
        connectionChecker: getIt(),
      ),
    )
    // Usecase
    ..registerFactory(() => UserSignUp(authRepository: getIt()))
    ..registerFactory(() => UserLogin(authRepository: getIt()))
    ..registerFactory(() => GetCurrentUser(authRepository: getIt()))
    ..registerFactory(() => UserSignOut(authRepository: getIt()))
    // Bloc
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: getIt(),
        userLogin: getIt(),
        getCurrentUser: getIt(),
        appUserCubit: getIt(),
        userSignOut: getIt(),
      ),
    );
}

void _initBlog() {
  // Datasource
  getIt
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImpl(supabaseClient: getIt()),
    )
    // Repository
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(
        blogRemoteDataSource: getIt(),
        connectionChecker: getIt(),
      ),
    )
    // Usecase
    ..registerFactory(() => UploadBlog(blogRepository: getIt()))
    ..registerFactory(() => GetAllBlogs(blogRepository: getIt()))
    ..registerFactory(() => GetBlogsByUserId(blogRepository: getIt()))
    ..registerFactory(() => GetBlogsByKeyWord(blogRepository: getIt()))
    ..registerFactory(() => GetBlogLikeState(repository: getIt()))
    ..registerFactory(() => UpdateBlogLikeState(repository: getIt()))
    // Bloc
    ..registerLazySingleton(
      () => BlogBloc(uploadBlog: getIt(), getAllBlogs: getIt(), getBlogLikeState: getIt()),
    )
    ..registerFactory(() => ProfileBloc(getBlogsByUserId: getIt()))
    ..registerFactory(() => SearchBloc(getBlogsByKeyWord: getIt()))
    ..registerFactory(() => BlogDetailBloc(getBlogLikeState: getIt(), updateBlogLikeState: getIt()));
}

void _initStreams() {
  getIt.registerFactory<LoginStream>(() => LoginStream());
  getIt.registerFactory<SignupStream>(() => SignupStream());
  getIt.registerFactory<AddBlogStream>(() => AddBlogStream());
}
