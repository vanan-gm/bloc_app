import 'package:bloc_app/core/common/widgets/app_icon.dart';
import 'package:bloc_app/core/common/widgets/ripple_effect.dart';
import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/core/theme/app_colors.dart';
import 'package:bloc_app/generated/assets.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppConstants.paddingSmall,
        horizontal: AppConstants.paddingSmall,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('General', style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w700),),
          itemBox(Assets.iconsIcUser, "Edit Profile", (){}),
          itemBox(Assets.iconsIcSecure, "Change Password", (){}),
          itemBox(Assets.iconsIcLogout, "Logout", (){}),
          itemBox(Assets.iconsIcLanguage, "Change Language", (){}),
        ],
      ),
    );
  }

  Widget itemBox(String icon, String text, VoidCallback onTap){
    return RippleEffect(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppConstants.paddingSmall,
          vertical: AppConstants.paddingSmall,
        ),
        margin: EdgeInsets.symmetric(vertical: AppConstants.paddingSuperTiny),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.gradient1, width: 1.0),
          borderRadius: BorderRadius.circular(AppConstants.borderImage),
        ),
        child: Row(
          children: [
            AppIcon.asset(icon, color: AppColors.white,),
            Padding(
              padding: EdgeInsets.only(left: AppConstants.paddingMedium),
              child: Text(text, style: Theme.of(context).textTheme.bodyMedium,),
            ),
            Spacer(),
            AppIcon.asset(Assets.iconsIcRightArrow, color: AppColors.white,),
          ],
        ),
      ),
    );
  }
}
