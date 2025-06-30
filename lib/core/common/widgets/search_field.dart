import 'dart:async';

import 'package:bloc_app/core/common/extensions/object_ext.dart';
import 'package:bloc_app/core/common/widgets/app_icon.dart';
import 'package:bloc_app/core/common/widgets/ripple_effect.dart';
import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/core/theme/app_colors.dart';
import 'package:bloc_app/generated/assets.dart';
import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final VoidCallback? onClear;
  final Color? borderColor;
  final bool useDebounce;
  final ValueChanged<String> onSubmit;

  const SearchField({
    super.key,
    required this.hintText,
    required this.controller,
    this.onClear,
    this.borderColor,
    this.useDebounce = true,
    required this.onSubmit,
  });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final FocusNode _focusNode = FocusNode();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (widget.controller.text.isNotEmpty) {
        suffixIcon = RippleEffect(
          onTap: () {
            widget.controller.text = "";
            if (widget.onClear.isNotNull) {
              widget.onClear!.call();
            }
          },
          child: Container(
            margin: EdgeInsets.all(5.0),
            transform: Matrix4.translationValues(-10.0, 0.0, 0.0),
            child: AppIcon.asset(Assets.iconsIcClose),
          ),
        );
      } else {
        suffixIcon = null;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _debounce!.cancel();
    super.dispose();
  }

  void _onSearchChanged(String keyword) async{
    if(keyword.length <= 3) return;
    if(_debounce != null){
      if(_debounce!.isActive) _debounce!.cancel();
    }
    _debounce = Timer(AppConstants.debounceDuration, (){
      widget.onSubmit.call(keyword);
    });
  }


  Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: _focusNode,
      style: Theme.of(context).textTheme.bodyMedium,
      onChanged: _onSearchChanged,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: Theme.of(context).textTheme.bodyMedium,
        suffixIcon: suffixIcon,
        border: customBorder(color: AppColors.borderColor),
        enabledBorder: customBorder(color: AppColors.borderColor),
        focusedBorder: customBorder(color: AppColors.gradient1),
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

  InputBorder customBorder({Color color = AppColors.borderColor}) =>
      OutlineInputBorder(
        borderSide: BorderSide(color: color, width: 1.0),
        borderRadius: BorderRadius.circular(AppConstants.borderButton),
      );
}
