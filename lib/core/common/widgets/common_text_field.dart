import 'package:bloc_app/core/common/widgets/ripple_effect.dart';
import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CommonTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isPasswordType;
  final Stream<String>? stream;
  final Function(String)? onChange;
  final Color? borderColor;
  final int? linesLimit;
  final EdgeInsets? contentPadding;

  const CommonTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isPasswordType = false,
    this.stream,
    this.onChange,
    this.borderColor,
    this.linesLimit = 1,
    this.contentPadding,
  });

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _passwordVisible = false;
  late String? _hintText;

  @override
  void initState() {
    super.initState();
    _hintText = widget.hintText;

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _hintText = '';
        setState(() {});
      } else if (widget.controller.text.isEmpty == true) {
        _hintText = widget.hintText;
        setState(() {});
      }
    });
  }

  Widget? _suffixIcon() =>
      widget.isPasswordType
          ? Padding(
            padding: EdgeInsets.only(right: AppConstants.paddingSmall),
            child: RippleEffect(
              onTap: () {
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
              radius: AppConstants.borderRound,
              child: Icon(
                _passwordVisible ? Icons.visibility : Icons.visibility_off,
              ),
            ),
          )
          : null;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: widget.stream,
      builder: (context, snapshot) {
        return Column(
          children: [
            TextFormField(
              controller: widget.controller,
              focusNode: _focusNode,
              onChanged: widget.onChange,
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: widget.linesLimit,
              decoration: InputDecoration(
                hintText: _hintText,
                hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.whiteColor.withValues(alpha: .6),
                ),
                contentPadding: widget.contentPadding,
                errorBorder: customBorder(
                  color:
                      snapshot.error != null
                          ? AppColors.red
                          : widget.borderColor ?? AppColors.borderColor,
                ),
                border: customBorder(),
                focusedBorder: customBorder(
                  color:
                      snapshot.error != null
                          ? AppColors.red
                          : widget.borderColor ?? AppColors.gradient1,
                ),
                enabledBorder: customBorder(
                  color:
                      snapshot.error != null
                          ? AppColors.red
                          : widget.borderColor ?? AppColors.borderColor,
                ),
                suffixIcon: _suffixIcon(),
                suffixIconConstraints: const BoxConstraints(
                  minHeight: 20,
                  minWidth: 20,
                ),
              ),
              obscureText: widget.isPasswordType ? !_passwordVisible : false,
            ),
            if (snapshot.error != null)
              SizedBox(height: AppConstants.paddingTiny),
            if (snapshot.error != null)
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: AppConstants.paddingTiny),
                    child: const Icon(
                      Icons.error_outline,
                      color: AppColors.red,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      snapshot.error.toString(),
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.copyWith(color: AppColors.red),
                    ),
                  ),
                ],
              ),
          ],
        );
      },
    );
  }

  InputBorder customBorder({Color color = AppColors.borderColor}) =>
      OutlineInputBorder(
        borderSide: BorderSide(color: color, width: 2),
        borderRadius: BorderRadius.circular(10.0),
      );
}
