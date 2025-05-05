import 'package:bloc_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ThreeDotsAnimation extends StatefulWidget {
  final Color color;
  final double size;
  final double bounceHeight;
  final Duration singleBounceDuration;
  final Duration staggerDelay;

  const ThreeDotsAnimation({
    super.key,
    this.color = AppColors.green,
    this.size = 10.0,
    this.bounceHeight = 10.0,
    this.singleBounceDuration = const Duration(milliseconds: 300),
    this.staggerDelay = const Duration(milliseconds: 150),
  });

  @override
  State<ThreeDotsAnimation> createState() => _ThreeDotsAnimationState();
}

class _ThreeDotsAnimationState extends State<ThreeDotsAnimation> with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();

    _controllers = List.generate(3, (_) {
      return AnimationController(
        vsync: this,
        duration: widget.singleBounceDuration,
      );
    });

    _animations = _controllers.map((controller) {
      return Tween<double>(begin: 0, end: -widget.bounceHeight)
          .chain(CurveTween(curve: Curves.easeInOut))
          .animate(controller);
    }).toList();

    _startStaggeredBounce();
  }

  void _startStaggeredBounce() {
    for (int i = 0; i < _controllers.length; i++) {
      Future.delayed(widget.staggerDelay * i, () {
        if (mounted) _loopBounce(_controllers[i]);
      });
    }
  }

  void _loopBounce(AnimationController controller) {
    void repeat() async {
      while (mounted) {
        await controller.forward();
        await controller.reverse();
      }
    }

    repeat();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.size * 2,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(3, (i) {
          return AnimatedBuilder(
            animation: _animations[i],
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _animations[i].value),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Dot(color: widget.color, size: widget.size),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  final Color color;
  final double size;

  const Dot({super.key, required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}