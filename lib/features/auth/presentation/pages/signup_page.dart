import 'package:bloc_app/core/common/extensions/buildcontext_ext.dart';
import 'package:bloc_app/core/common/extensions/localization_ext.dart';
import 'package:bloc_app/core/common/extensions/widget_ext.dart';
import 'package:bloc_app/core/common/utils/app_toast.dart';
import 'package:bloc_app/core/common/widgets/common_gradient_button.dart';
import 'package:bloc_app/core/common/widgets/common_text_field.dart';
import 'package:bloc_app/core/common/widgets/loading_widget.dart';
import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/core/theme/app_colors.dart';
import 'package:bloc_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bloc_app/features/auth/presentation/streams/signup_stream.dart';
import 'package:bloc_app/features/blog/presentation/pages/master_page.dart';
import 'package:bloc_app/init_dependencies.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  static route() =>
      CupertinoPageRoute(builder: (context) => const SignUpPage());
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passWordCtrl = TextEditingController();
  final TextEditingController _passWordConfirmCtrl = TextEditingController();
  final signUpStream = getIt<SignupStream>();

  @override
  void dispose() {
    super.dispose();
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passWordCtrl.dispose();
    _passWordConfirmCtrl.dispose();
    signUpStream.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthSuccessState) {
                    AppToast.showToast(
                      context: context,
                      title: "Success!",
                      message: context.translate.createAccountSuccessfully,
                      type: ToastType.success,
                    );
                    Navigator.of(
                      context,
                    ).pushAndRemoveUntil(MasterPage.route(), (route) => false);
                  } else if (state is AuthFailureState) {
                    AppToast.showToast(
                      context: context,
                      title: "Failure",
                      message: state.message,
                      type: ToastType.error,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoadingState) {
                    return const LoadingWidget();
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Sign Up',
                          style: Theme.of(
                            context,
                          ).textTheme.displayLarge!.copyWith(
                            fontWeight: FontWeight.w700,
                            color:
                                context.isLightMode
                                    ? AppColors.black
                                    : AppColors.white,
                          ),
                        ).useScaleAnimation(),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppConstants.paddingSmall,
                            vertical: AppConstants.paddingSmall,
                          ),
                          child: CommonTextField(
                            hintText: 'Name',
                            controller: _nameCtrl,
                            stream: signUpStream.nameS,
                            onChange: signUpStream.nameChange,
                          ).useFadeAnimation(
                            duration: AppConstants.fadeDuration200,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppConstants.paddingSmall,
                            vertical: AppConstants.paddingSmall,
                          ),
                          child: CommonTextField(
                            hintText: 'Email',
                            controller: _emailCtrl,
                            stream: signUpStream.emailS,
                            onChange: signUpStream.emailChange,
                          ).useFadeAnimation(
                            duration: AppConstants.fadeDuration400,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppConstants.paddingSmall,
                            vertical: AppConstants.paddingSmall,
                          ),
                          child: CommonTextField(
                            hintText: 'Password',
                            controller: _passWordCtrl,
                            isPasswordType: true,
                            stream: signUpStream.passwordS,
                            onChange: signUpStream.passwordChange,
                          ).useFadeAnimation(
                            duration: AppConstants.fadeDuration600,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppConstants.paddingSmall,
                            vertical: AppConstants.paddingSmall,
                          ),
                          child: CommonTextField(
                            hintText: 'Password Confirm',
                            controller: _passWordConfirmCtrl,
                            isPasswordType: true,
                            stream: signUpStream.passwordConfirmS,
                            onChange: (value) {
                              signUpStream.passwordConfirmChange({
                                "password": _passWordCtrl.text.trim(),
                                "password_confirm":
                                    _passWordConfirmCtrl.text.trim(),
                              });
                            },
                          ).useFadeAnimation(
                            duration: AppConstants.fadeDuration800,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: AppConstants.paddingSmall,
                            horizontal: AppConstants.paddingSmall,
                          ),
                          child: CommonGradientButton(
                            stream: signUpStream.submitS,
                            onPressed: () {
                              context.read<AuthBloc>().add(
                                SignUpEvent(
                                  name: _nameCtrl.text.trim().toLowerCase(),
                                  email: _emailCtrl.text.trim().toLowerCase(),
                                  password: _passWordCtrl.text.trim(),
                                ),
                              );
                            },
                            text: 'Sign Up',
                          ).useFadeAnimation(
                            duration: AppConstants.fadeDuration400,
                            offset: AppConstants.offsetUp50,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: AppConstants.paddingMedium,
                          ),
                          child: RichText(
                            text: TextSpan(
                              text:
                                  "${context.translate.alreadyHaveAnAccount}? ",
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium!.copyWith(
                                color:
                                    context.isLightMode
                                        ? AppColors.black
                                        : AppColors.white,
                              ),
                              children: [
                                TextSpan(
                                  text: context.translate.signIn,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium!.copyWith(
                                    color: AppColors.gradient2,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer:
                                      TapGestureRecognizer()
                                        ..onTap =
                                            () =>
                                                Navigator.of(
                                                  context,
                                                ).maybePop(),
                                ),
                              ],
                            ),
                          ).useFadeAnimation(
                            duration: AppConstants.fadeDuration600,
                            offset: AppConstants.offsetUp50,
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
