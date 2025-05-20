import 'package:bloc_app/core/common/widgets/common_gradient_button.dart';
import 'package:bloc_app/core/common/widgets/common_text_field.dart';
import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/core/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  static route() => CupertinoPageRoute(builder: (_) => ChangePasswordPage());

  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _passwordCtrl = TextEditingController();
  final TextEditingController _confirmCtrl = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Change Password",
          style: Theme.of(
            context,
          ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        forceMaterialTransparency: true,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppConstants.paddingSmall,
              vertical: AppConstants.paddingSmall,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          "Your new password must be different from previous password",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: AppConstants.paddingMediumSmall,
                          ),
                          child: CommonTextField(
                            controller: _passwordCtrl,
                            hintText: "New password",
                            isPasswordType: true,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: AppConstants.paddingMediumSmall,
                          ),
                          child: CommonTextField(
                            controller: _confirmCtrl,
                            hintText: "Confirm password",
                            isPasswordType: true,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: AppConstants.paddingMediumSmall,
                          ),
                          child: Text(
                            "The new password must satisfy the password policy.",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: AppConstants.paddingSmall,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildCondition(
                                "The password must have at least 08 characters.",
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: AppConstants.paddingTiny,
                                ),
                                child: buildCondition(
                                  "The password must contain at least 1 special character, such as @, &, %, TM,…",
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: AppConstants.paddingTiny,
                                ),
                                child: buildCondition(
                                  "The password must contain at least 3 different kinds of characters, such as uppercase letters, lowercase letter, numeric digits, and punctuation marks.",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                CommonGradientButton(onPressed: () {}, text: "Change Password"),
              ],
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
          padding: EdgeInsets.only(top: AppConstants.paddingTiny),
          child: dot,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: AppConstants.paddingSmall),
            child: Text(
              content,
              style: Theme.of(context).textTheme.bodyLarge,
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
