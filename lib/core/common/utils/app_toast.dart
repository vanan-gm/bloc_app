// toast_service.dart
import 'package:bloc_app/core/common/widgets/app_text.dart';
import 'package:bloc_app/core/constants/app_constants.dart';
import 'package:bloc_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

// =======================
// TOAST SERVICE
// =======================
class AppToast {
  static OverlayEntry? _currentToast;

  static void showToast({
    required BuildContext context,
    required String message,
    String? title,
    ToastType type = ToastType.info,
    ToastPosition position = ToastPosition.topCenter,
    Duration duration = AppConstants.toastDuration,
    bool showCloseButton = true,
  }) {
    // Remove existing toast if any
    _currentToast?.remove();

    _currentToast = OverlayEntry(
      builder:
          (context) => ToastWidget(
            message: message,
            title: title,
            type: type,
            position: position,
            duration: duration,
            showCloseButton: showCloseButton,
            onDismiss: () {
              _currentToast?.remove();
              _currentToast = null;
            },
          ),
    );

    Overlay.of(context).insert(_currentToast!);
  }

  static void dismiss() {
    _currentToast?.remove();
    _currentToast = null;
  }
}

enum ToastType { success, error, warning, info }

enum ToastPosition {
  topLeft,
  topRight,
  topCenter,
  bottomLeft,
  bottomRight,
  bottomCenter,
}

// =======================
// TOAST WIDGET
// =======================
class ToastWidget extends StatefulWidget {
  final String message;
  final String? title;
  final ToastType type;
  final ToastPosition position;
  final Duration duration;
  final bool showCloseButton;
  final VoidCallback onDismiss;

  const ToastWidget({
    super.key,
    required this.message,
    this.title,
    required this.type,
    required this.position,
    required this.duration,
    required this.showCloseButton,
    required this.onDismiss,
  });

  @override
  State<ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<ToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: AppConstants.animationCtrlDuration,
      vsync: this,
    );

    _slideAnimation = Tween<double>(
      begin: widget.position.toString().contains('Right') ? 1.0 : -1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();

    Future.delayed(widget.duration, () {
      if (mounted) _dismiss();
    });
  }

  void _dismiss() {
    _animationController.reverse().then((_) {
      widget.onDismiss();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.position.isTop ? AppConstants.getPadding(50) : null,
      bottom: widget.position.isBottom ? AppConstants.getPadding(50) : null,
      left: widget.position.isLeft ? AppConstants.getPadding(20) : null,
      right: widget.position.isRight ? AppConstants.getPadding(20) : null,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(_slideAnimation.value * 100, 0),
            child: Opacity(
              opacity: _fadeAnimation.value,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: AppConstants.containerBigHeight,
                    minWidth: AppConstants.containerMediumHeight,
                  ),
                  margin: EdgeInsets.all(AppConstants.paddingSuperTiny),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(
                      AppConstants.borderImage,
                    ),
                    border: Border(
                      left: BorderSide(color: widget.type.color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Icon
                      Container(
                        padding: EdgeInsets.all(AppConstants.paddingSmall),
                        child: Container(
                          width: AppConstants.containerSmallHeight,
                          height: AppConstants.containerSmallHeight,
                          decoration: BoxDecoration(
                            color: widget.type.color,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            widget.type.icon,
                            color: AppColors.white,
                            size: AppConstants.iconSmallSize,
                          ),
                        ),
                      ),

                      // Content
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: AppConstants.paddingSmall,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (widget.title != null)
                                AppText(
                                  text: widget.title!,
                                  style: Theme.of(context).textTheme.bodyMedium!
                                      .copyWith(color: AppColors.black),
                                ),
                              AppText.padding(
                                text: widget.message,
                                padding: EdgeInsets.only(
                                  top: AppConstants.paddingMicroSmall,
                                ),
                                style: Theme.of(context).textTheme.bodySmall!
                                    .copyWith(color: AppColors.black),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Close Button
                      if (widget.showCloseButton)
                        Padding(
                          padding: EdgeInsets.only(
                            top: AppConstants.paddingSmall,
                            right: AppConstants.paddingSuperTiny,
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.close,
                              size: AppConstants.iconSmallSize,
                              color: AppColors.grey,
                            ),
                            onPressed: _dismiss,
                            constraints: const BoxConstraints(),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// =======================
// EXTENSIONS
// =======================
extension ToastTypeExtension on ToastType {
  Color get color {
    switch (this) {
      case ToastType.success:
        return AppColors.green;
      case ToastType.error:
        return AppColors.red;
      case ToastType.warning:
        return AppColors.orange;
      case ToastType.info:
        return AppColors.blue;
    }
  }

  IconData get icon {
    switch (this) {
      case ToastType.success:
        return Icons.check;
      case ToastType.error:
        return Icons.close;
      case ToastType.warning:
        return Icons.warning;
      case ToastType.info:
        return Icons.info;
    }
  }
}

extension ToastPositionExtension on ToastPosition {
  bool get isTop =>
      this == ToastPosition.topLeft ||
      this == ToastPosition.topCenter ||
      this == ToastPosition.topRight;
  bool get isBottom =>
      this == ToastPosition.bottomLeft ||
      this == ToastPosition.bottomCenter ||
      this == ToastPosition.bottomRight;
  bool get isLeft =>
      this == ToastPosition.topLeft || this == ToastPosition.bottomLeft;
  bool get isRight =>
      this == ToastPosition.topRight || this == ToastPosition.bottomRight;
}
