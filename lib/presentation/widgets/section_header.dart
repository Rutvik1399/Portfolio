import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

/// Reusable enterprise-tech section header with badge, title, and subtitle.
class SectionHeader extends StatelessWidget {
  final String badge;
  final String title;
  final String? highlightedWord;
  final String subtitle;
  final bool isCentered;

  const SectionHeader({
    super.key,
    required this.badge,
    required this.title,
    this.highlightedWord,
    required this.subtitle,
    this.isCentered = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final alignment =
        isCentered ? CrossAxisAlignment.center : CrossAxisAlignment.start;
    final textAlignment = isCentered ? TextAlign.center : TextAlign.start;

    return Column(
      crossAxisAlignment: alignment,
      children: [
        // Category Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: isDark
                ? AppColors.odooPurple.withOpacity(0.2)
                : AppColors.odooPurple.withOpacity(0.08),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isDark
                  ? AppColors.cyanAccent.withOpacity(0.3)
                  : AppColors.odooPurple.withOpacity(0.25),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: AppColors.cyanAccent,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  badge.toUpperCase(),
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.1,
                    color: isDark ? AppColors.cyanAccent : AppColors.odooPurple,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Main Title
        _buildTitle(context, isDark, textAlignment),
        const SizedBox(height: 12),

        // Subtitle Description
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Text(
            subtitle,
            textAlign: textAlignment,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: isDark
                  ? AppColors.textDarkSecondary
                  : AppColors.textLightSecondary,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTitle(
      BuildContext context, bool isDark, TextAlign textAlignment) {
    final theme = Theme.of(context);
    final isMobile = MediaQuery.sizeOf(context).width < 600;
    final baseStyle = (theme.textTheme.displaySmall ??
            const TextStyle(fontSize: 32))
        .copyWith(
      fontWeight: FontWeight.w800,
      letterSpacing: -0.5,
      fontSize: isMobile ? 26 : null,
    );

    if (highlightedWord == null || !title.contains(highlightedWord!)) {
      return Text(
        title,
        textAlign: textAlignment,
        style: baseStyle,
      );
    }

    final parts = title.split(highlightedWord!);
    return RichText(
      textAlign: textAlignment,
      text: TextSpan(
        style: baseStyle.copyWith(
          color: isDark
              ? AppColors.textDarkPrimary
              : AppColors.textLightPrimary,
        ),
        children: [
          TextSpan(text: parts[0]),
          TextSpan(
            text: highlightedWord,
            style: TextStyle(
              foreground: Paint()
                ..shader = const LinearGradient(
                  colors: [AppColors.cyanAccent, AppColors.odooPurpleLight],
                ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
            ),
          ),
          if (parts.length > 1) TextSpan(text: parts[1]),
        ],
      ),
    );
  }
}
