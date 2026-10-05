import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// A reusable glassmorphic container card with subtle hover lift and glow effects.
class GlassContainer extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final Color? customBorderColor;
  final Color? customBackgroundColor;
  final bool enableHover;
  final VoidCallback? onTap;
  final double? width;
  final double? height;

  const GlassContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24.0),
    this.margin,
    this.borderRadius = 16.0,
    this.customBorderColor,
    this.customBackgroundColor,
    this.enableHover = true,
    this.onTap,
    this.width,
    this.height,
  });

  @override
  State<GlassContainer> createState() => _GlassContainerState();
}

class _GlassContainerState extends State<GlassContainer> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final defaultBg = isDark
        ? (_isHovered
            ? const Color(0xFF1E293B)
            : const Color(0xFF141C2E).withOpacity(0.92))
        : (_isHovered
            ? Colors.white
            : const Color(0xFFFFFFFF).withOpacity(0.95));

    final defaultBorder = isDark
        ? (_isHovered
            ? AppColors.cyanAccent.withOpacity(0.4)
            : Colors.white.withOpacity(0.08))
        : (_isHovered
            ? AppColors.odooPurple.withOpacity(0.3)
            : Colors.black.withOpacity(0.06));

    final shadow = isDark
        ? [
            BoxShadow(
              color: _isHovered
                  ? AppColors.cyanAccent.withOpacity(0.12)
                  : Colors.black.withOpacity(0.3),
              blurRadius: _isHovered ? 24 : 12,
              offset: Offset(0, _isHovered ? 8 : 4),
            ),
          ]
        : [
            BoxShadow(
              color: _isHovered
                  ? AppColors.odooPurple.withOpacity(0.1)
                  : Colors.black.withOpacity(0.04),
              blurRadius: _isHovered ? 20 : 10,
              offset: Offset(0, _isHovered ? 8 : 2),
            ),
          ];

    Widget content = AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      width: widget.width,
      height: widget.height,
      margin: widget.margin,
      padding: widget.padding,
      transform: widget.enableHover && _isHovered
          ? (Matrix4.identity()..translate(0.0, -4.0, 0.0))
          : Matrix4.identity(),
      decoration: BoxDecoration(
        color: widget.customBackgroundColor ?? defaultBg,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: Border.all(
          color: widget.customBorderColor ?? defaultBorder,
          width: 1.2,
        ),
        boxShadow: shadow,
      ),
      child: widget.child,
    );

    if (widget.enableHover || widget.onTap != null) {
      content = MouseRegion(
        cursor: widget.onTap != null
            ? SystemMouseCursors.click
            : SystemMouseCursors.basic,
        onEnter: (_) {
          if (widget.enableHover) setState(() => _isHovered = true);
        },
        onExit: (_) {
          if (widget.enableHover) setState(() => _isHovered = false);
        },
        child: GestureDetector(
          onTap: widget.onTap,
          child: content,
        ),
      );
    }

    return content;
  }
}
