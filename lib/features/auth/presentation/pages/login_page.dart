import 'package:bloc_app/core/common/extesions/localization_ext.dart';
import 'package:bloc_app/core/common/utils/show_custom_overlay.dart';
import 'package:bloc_app/core/common/widgets/loading_widget.dart';
import 'package:bloc_app/core/common/widgets/common_text_field.dart';
import 'package:bloc_app/core/common/widgets/common_gradient_button.dart';
import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/core/theme/app_pallete.dart';
import 'package:bloc_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bloc_app/features/auth/presentation/pages/signup_page.dart';
import 'package:bloc_app/features/auth/presentation/streams/login_stream.dart';
import 'package:bloc_app/features/blog/presentation/pages/master_page.dart';
import 'package:bloc_app/init_dependencies.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  static route() => CupertinoPageRoute(builder: (context) => const LoginPage());
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passWordCtrl = TextEditingController();
  final loginStream = getIt<LoginStream>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _emailCtrl.dispose();
    _passWordCtrl.dispose();
    loginStream.dispose();
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
                  Navigator.of(
                    context,
                  ).pushAndRemoveUntil(MasterPage.route(), (route) => false);
                } else if (state is AuthFailureState) {
                  if (state.message.isNotEmpty &&
                      state.message != AppConstants.userNotLoggedIn) {
                    showCustomOverlay(
                      context: context,
                      content: state.message,
                      isSuccessType: false,
                    );
                  }
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
                        Text(
                          context.translate.signIn,
                          style: Theme.of(context).textTheme.displayLarge!
                              .copyWith(fontWeight: FontWeight.w700),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppConstants.paddingSmall,
                            vertical: AppConstants.paddingSmall,
                          ),
                          child: CommonTextField(
                            hintText: 'Email',
                            controller: _emailCtrl,
                            stream: loginStream.emailS,
                            onChange: loginStream.emailChange,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppConstants.paddingSmall,
                            vertical: AppConstants.paddingSmall,
                          ),
                          child: CommonTextField(
                            hintText: context.translate.password,
                            controller: _passWordCtrl,
                            stream: loginStream.passwordS,
                            onChange: loginStream.passwordChange,
                            isPasswordType: true,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: AppConstants.paddingSmall,
                            horizontal: AppConstants.paddingSmall,
                          ),
                          child: CommonGradientButton(
                            onPressed: () {
                              context.read<AuthBloc>().add(
                                LoginEvent(
                                  email: _emailCtrl.text.trim().toLowerCase(),
                                  password:
                                      _passWordCtrl.text.trim().toLowerCase(),
                                ),
                              );
                            },
                            text: context.translate.signIn,
                            stream: loginStream.submitS,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: AppConstants.paddingSmall,
                          ),
                          child: RichText(
                            text: TextSpan(
                              text: '${context.translate.dontHaveAnAccount}? ',
                              style: Theme.of(context).textTheme.bodyMedium,
                              children: [
                                TextSpan(
                                  text: context.translate.signUp,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium!.copyWith(
                                    color: AppPallete.gradient2,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer:
                                      TapGestureRecognizer()
                                        ..onTap =
                                            () => Navigator.of(
                                              context,
                                            ).push(SignUpPage.route()),
                                ),
                              ],
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
