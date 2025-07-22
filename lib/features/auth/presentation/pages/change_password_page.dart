import 'package:bloc_app/core/common/extensions/localization_ext.dart';
import 'package:bloc_app/core/common/utils/app_toast.dart';
import 'package:bloc_app/core/common/widgets/app_button.dart';
import 'package:bloc_app/core/common/widgets/common_text_field.dart';
import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/core/theme/app_colors.dart';
import 'package:bloc_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bloc_app/features/auth/presentation/streams/change_password_stream.dart';
import 'package:bloc_app/init_dependencies.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordPage extends StatefulWidget {
  static route() => CupertinoPageRoute(builder: (_) => ChangePasswordPage());

  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _passwordCtrl = TextEditingController();
  final TextEditingController _confirmCtrl = TextEditingController();
  final changePassStream = getIt<ChangePasswordStream>();
  final ValueNotifier<bool> _isLoading = ValueNotifier(false);

  @override
  void dispose() {
    super.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    changePassStream.dispose();
    _isLoading.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            context.translate.changePassword,
            style: Theme.of(
              context,
            ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
          forceMaterialTransparency: true,
        ),
        body: SafeArea(
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthLoadingState) {
                _isLoading.value = true;
              } else if (state is AuthFailureState) {
                _isLoading.value = false;
                AppToast.showToast(
                  context: context,
                  title: "Failure!",
                  message: context.translate.failedToChangePassword,
                  type: ToastType.error,
                );
              } else if (state is AuthChangedPasswordState) {
                _isLoading.value = false;
                AppToast.showToast(
                  context: context,
                  title: "Success!",
                  message: context.translate.changePasswordSuccessMessage,
                  type: ToastType.success,
                );
                Navigator.of(context).pop();
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppConstants.paddingSmall,
                vertical: AppConstants.paddingSmall,
              ),
              child: ValueListenableBuilder(
                valueListenable: _isLoading,
                builder: (context, isLoading, _) {
                  return IgnorePointer(
                    ignoring: isLoading,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  context.translate.changePasswordDescription1,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: AppConstants.paddingMediumSmall,
                                  ),
                                  child: CommonTextField(
                                    controller: _passwordCtrl,
                                    hintText: context.translate.newPassword,
                                    isPasswordType: true,
                                    stream: changePassStream.passwordS,
                                    onChange: changePassStream.passwordChange,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: AppConstants.paddingMediumSmall,
                                  ),
                                  child: CommonTextField(
                                    controller: _confirmCtrl,
                                    hintText: context.translate.confirmPassword,
                                    isPasswordType: true,
                                    stream: changePassStream.passwordConfirmS,
                                    onChange: (value) {
                                      changePassStream.passwordConfirmChange({
                                        "password": _passwordCtrl.text.trim(),
                                        "password_confirm":
                                            _confirmCtrl.text.trim(),
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: AppConstants.paddingMediumSmall,
                                  ),
                                  child: Text(
                                    context
                                        .translate
                                        .changePasswordDescription2,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: AppConstants.paddingSmall,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      buildCondition(
                                        context
                                            .translate
                                            .changePasswordDescription3,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: AppConstants.paddingTiny,
                                        ),
                                        child: buildCondition(
                                          context
                                              .translate
                                              .changePasswordDescription4,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: AppConstants.paddingTiny,
                                        ),
                                        child: buildCondition(
                                          context
                                              .translate
                                              .changePasswordDescription5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        AppButton.child(
                          stream: changePassStream.submitS,
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            context.read<AuthBloc>().add(
                              ChangePasswordEvent(
                                newPassword: _passwordCtrl.text.trim(),
                                confirmPassword: _confirmCtrl.text.trim(),
                              ),
                            );
                          },
                          child:
                              isLoading
                                  ? SizedBox(
                                    width: 25,
                                    height: 25,
                                    child: CircularProgressIndicator(
                                      color: AppColors.white,
                                      strokeWidth: 2.0,
                                    ),
                                  )
                                  : Text(
                                    context.translate.confirmChange,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(fontWeight: FontWeight.w700),
                                  ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildCondition(String content) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: AppConstants.paddingSuperTiny * 1.5),
          child: dot,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: AppConstants.paddingSmall),
            child: Text(
              content,
              style: Theme.of(context).textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
            ),
          ),
        ),
      ],
    );
  }

  Widget get dot => Container(
    width: 7,
    height: 7,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: AppColors.gradient1,
    ),
  );
}
