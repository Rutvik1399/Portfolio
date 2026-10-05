import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive_builder.dart';
import '../../../data/models/portfolio_models.dart';
import '../../../data/portfolio_data.dart';
import '../../widgets/glass_container.dart';
import '../../widgets/section_header.dart';

/// Core Strengths section presenting the 4 pillars of engineering & leadership excellence.
class StrengthsSection extends StatelessWidget {
  const StrengthsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const strengths = PortfolioData.coreStrengths;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.value<double>(
          context: context,
          mobile: 16,
          tablet: 24,
          desktop: 24,
        ),
        vertical: Responsive.value<double>(
          context: context,
          mobile: AppConstants.sectionVerticalSpacingMobile,
          desktop: AppConstants.sectionVerticalSpacing,
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
          child: Column(
            children: [
              const SectionHeader(
                badge: '06 // LEADERSHIP & COMPETENCY',
                title: 'Core Professional Pillars',
                highlightedWord: 'Professional Pillars',
                subtitle:
                    'Synthesizing deep engineering craftsmanship, architectural infrastructure, '
                    'complex process optimization, and proactive engineering leadership.',
              ),
              const SizedBox(height: 54),

              // Responsive 4 Cards Layout (2x2 on desktop/tablet, 1 col on mobile)
              ResponsiveBuilder(
                builder: (context, isMobile, isTablet, isDesktop) {
                  final columnCount = isDesktop ? 2 : (isTablet ? 2 : 1);

                  return LayoutBuilder(
                    builder: (context, constraints) {
                      const spacing = 20.0;
                      final totalSpacing = spacing * (columnCount - 1);
                      final cardWidth =
                          (constraints.maxWidth - totalSpacing) / columnCount;

                      return Wrap(
                        spacing: spacing,
                        runSpacing: spacing,
                        children: strengths.map((strength) {
                          return SizedBox(
                            width: cardWidth,
                            child: _StrengthCard(
                              strength: strength,
                              isDark: isDark,
                            ),
                          );
                        }).toList(),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 500.ms);
  }
}

class _StrengthCard extends StatelessWidget {
  final CoreStrength strength;
  final bool isDark;

  const _StrengthCard({
    required this.strength,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.all(26),
      borderRadius: 18,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: AppColors.purpleCyanGradient,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.cyanAccent.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  strength.icon,
                  size: 18,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      strength.title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      strength.subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? AppColors.cyanAccent
                            : AppColors.odooPurple,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            strength.description,
            style: TextStyle(
              fontSize: 14,
              height: 1.6,
              color: isDark
                  ? AppColors.textDarkSecondary
                  : AppColors.textLightSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
