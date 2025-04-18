import 'package:bloc_app/core/common/paths/app_path.dart';
import 'package:bloc_app/core/common/widgets/app_icon.dart';
import 'package:bloc_app/core/common/widgets/ripple_effect.dart';
import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/generated/assets.dart';
import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final VoidCallback? onClear;

  const SearchField({
    super.key,
    required this.hintText,
    required this.controller,
    this.onClear,
  });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if(widget.controller.text.isNotEmpty){
        suffixIcon = RippleEffect(
          onTap: (){
            widget.controller.text = "";
          },
          child: Container(
            margin: EdgeInsets.all(5.0),
            transform: Matrix4.translationValues(-10.0, 0.0, 0.0),
            child: AppIcon.asset(Assets.iconsIcClose),
          ),
        );
      }else{
        suffixIcon = null;
      }
      setState(() {});
    });
  }

  Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: _focusNode,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: Theme.of(context).textTheme.bodyMedium,
        suffixIcon: suffixIcon,
        suffixIconConstraints: const BoxConstraints(
          minHeight: 20,
          minWidth: 20,
        ),
        prefixIcon: AppIcon.asset(Assets.iconsIcSearch),
        prefixIconConstraints: const BoxConstraints(
          minHeight: 20,
          minWidth: 40,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: AppConstants.paddingTiny,
          horizontal: AppConstants.paddingSmall,
        ),
      ),
    );
  }

}
