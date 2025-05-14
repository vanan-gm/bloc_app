import 'package:bloc_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:bloc_app/core/theme/theme.dart';
import 'package:bloc_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bloc_app/features/auth/presentation/pages/login_page.dart';
import 'package:bloc_app/features/blog/presentation/bloc/blog_bloc/blog_bloc.dart';
import 'package:bloc_app/features/blog/presentation/bloc/detail_bloc/blog_detail_bloc.dart';
import 'package:bloc_app/features/blog/presentation/bloc/favorite_bloc/favorite_bloc.dart';
import 'package:bloc_app/features/blog/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'package:bloc_app/features/blog/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:bloc_app/features/blog/presentation/pages/master_page.dart';
import 'package:bloc_app/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await initDependencies();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => getIt<AppUserCubit>()),
    BlocProvider(create: (_) => getIt<AuthBloc>()),
    BlocProvider(create: (_) => getIt<BlogBloc>()),
    BlocProvider(create: (_) => getIt<SearchBloc>()),
    BlocProvider(create: (_) => getIt<ProfileBloc>()),
    BlocProvider(create: (_) => getIt<BlogDetailBloc>()),
    BlocProvider(create: (_) => getIt<FavoriteBlogBloc>()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(CheckUserLoggedInEvent());
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Bloc App',
          theme: AppTheme.darkThemeMode,
          home: BlocSelector<AppUserCubit, AppUserState, bool>(
            selector: (state){
              return state is AppUserLoggedInState;
            },
            builder: (context, isLoggedIn){
              if(isLoggedIn){
                return const MasterPage();
              }else{
                return const LoginPage();
              }
            },
          ),
        );
      },
    );
  }
}
