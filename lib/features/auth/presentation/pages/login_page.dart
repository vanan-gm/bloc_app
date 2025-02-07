import 'package:bloc_app/core/common/utils/show_custom_overlay.dart';
import 'package:bloc_app/core/common/widgets/loading_widget.dart';
import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/core/theme/app_colors.dart';
import 'package:bloc_app/core/theme/app_pallete.dart';
import 'package:bloc_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bloc_app/features/auth/presentation/pages/signup_page.dart';
import 'package:bloc_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:bloc_app/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:bloc_app/features/blog/presentation/pages/blog_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passWordCtrl = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailCtrl.dispose();
    _passWordCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
        child: SafeArea(
          child: Center(
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccessState) {
                  Navigator.of(context).pushAndRemoveUntil(
                    BlogPage.route(),
                    (route) => false,
                  );
                } else if (state is AuthFailureState) {
                  showCustomOverlay(context: context,
                      content: state.message,
                      isSuccessType: false);
                }
              },
              builder: (context, state) {
                if (state is AuthLoadingState) {
                  return const LoadingWidget();
                } else {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Sign In', style: TextStyle(
                            color: AppColors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.bold),),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppConstants.paddingSmall,
                            vertical: AppConstants.paddingSmall,
                          ),
                          child: AuthField(
                            hintText: 'Email', controller: _emailCtrl,),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppConstants.paddingSmall,
                            vertical: AppConstants.paddingSmall,
                          ),
                          child: AuthField(hintText: 'Password',
                            controller: _passWordCtrl,
                            isObscure: true,),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: AppConstants.paddingSmall,
                            horizontal: AppConstants.paddingSmall,
                          ),
                          child: AuthGradientButton(onPressed: () {
                            context.read<AuthBloc>().add(AuthLogin(
                                email: _emailCtrl.text.trim().toLowerCase(),
                                password: _passWordCtrl.text.trim().toLowerCase()));
                          }, text: 'Sign In',),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: AppConstants.paddingSmall),
                          child: RichText(
                            text: TextSpan(
                                text: 'Don\'t have an account? ',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .titleMedium,
                                children: [
                                  TextSpan(
                                      text: 'Sign Up', style: Theme
                                      .of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(color: AppPallete.gradient2,
                                      fontWeight: FontWeight.bold),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () =>
                                            Navigator.of(context).push(
                                                CupertinoPageRoute(builder: (
                                                    _) => const SignUpPage()))
                                  )
                                ]
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
