import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// Counter widget that smoothly animates from 0 to the target value.
class AnimatedCounter extends StatefulWidget {
  final double value;
  final String suffix;
  final TextStyle? textStyle;
  final Duration duration;

  const AnimatedCounter({
    super.key,
    required this.value,
    this.suffix = '',
    this.textStyle,
    this.duration = const Duration(milliseconds: 1800),
  });

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutExpo,
    );
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant AnimatedCounter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isFloat = widget.value % 1 != 0;
    final defaultStyle = widget.textStyle ??
        Theme.of(context).textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w800,
              color: AppColors.cyanAccent,
            );

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final current = _animation.value * widget.value;
        final formattedNumber = isFloat
            ? current.toStringAsFixed(1)
            : current.toInt().toString();

        return Text(
          '$formattedNumber${widget.suffix}',
          style: defaultStyle,
        );
      },
    );
  }
}
