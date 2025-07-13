import 'package:bloc_app/core/common/extensions/buildcontext_ext.dart';
import 'package:bloc_app/core/common/extensions/object_ext.dart';
import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CommonGradientButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Stream<bool>? stream;

  const CommonGradientButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.stream,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        return Container(
          decoration: buttonDecoration(snapshot, context),
          child: ElevatedButton(
            onPressed: stream.isNotNull ? getOnPressed(snapshot) : null,
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(400, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7.0),
              ),
              backgroundColor: AppColors.transparent,
              shadowColor: AppColors.transparent,
            ),
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w700,
                color:
                    snapshot.isNotNull
                        ? getTextBtnColor(snapshot, context)
                        : AppColors.black,
              ),
            ),
          ),
        );
      },
    );
  }

  Color getTextBtnColor(AsyncSnapshot<bool> snapshot, BuildContext context) {
    if ((snapshot.hasError ||
            snapshot.data == false ||
            snapshot.connectionState == ConnectionState.waiting) &&
        context.isLightMode) {
      return AppColors.black;
    }
    return AppColors.white;
  }

  Decoration buttonDecoration(
    AsyncSnapshot<bool> snapshot,
    BuildContext context,
  ) => BoxDecoration(
    gradient: stream.isNotNull ? getGradientFromSnapshot(snapshot) : null,
    color: stream.isNotNull ? getColorFromSnapshot(snapshot, context) : null,
    borderRadius: BorderRadius.circular(AppConstants.borderImage),
  );

  Gradient get gGradientColor => const LinearGradient(
    colors: [AppColors.gradient1, AppColors.gradient2],
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
  );

  Color gColor(BuildContext context) =>
      context.isLightMode ? AppColors.black : AppColors.grey;

  Gradient? getGradientFromSnapshot(AsyncSnapshot<bool> snapshot) {
    if (snapshot.hasError || snapshot.data != true) return null;
    return gGradientColor;
  }

  VoidCallback? getOnPressed(AsyncSnapshot<bool> snapshot) {
    if (snapshot.hasError || snapshot.data != true) return null;
    return onPressed;
  }

  Color? getColorFromSnapshot(
    AsyncSnapshot<bool> snapshot,
    BuildContext context,
  ) {
    if (snapshot.connectionState == ConnectionState.waiting ||
        snapshot.hasError ||
        snapshot.data != true) {
      return null;
    }
    return gColor(context);
  }
}
