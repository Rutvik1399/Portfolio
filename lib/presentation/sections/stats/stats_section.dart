import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive_builder.dart';
import '../../../data/portfolio_data.dart';
import '../../widgets/animated_counter.dart';
import '../../widgets/glass_container.dart';

/// Stats strip featuring animated count-up metrics for experience, groups, users, and compliance.
class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.value<double>(
          context: context,
          mobile: 16,
          tablet: 24,
          desktop: 24,
        ),
        vertical: 36,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
          child: ResponsiveBuilder(
            builder: (context, isMobile, isTablet, isDesktop) {
              const stats = PortfolioData.stats;

              if (isDesktop) {
                return Row(
                  children: stats.map((stat) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: _StatCard(stat: stat, isDark: isDark),
                      ),
                    );
                  }).toList(),
                );
              } else if (isTablet) {
                return Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  alignment: WrapAlignment.center,
                  children: stats.map((stat) {
                    return SizedBox(
                      width: 280,
                      child: _StatCard(stat: stat, isDark: isDark),
                    );
                  }).toList(),
                );
              } else {
                return Column(
                  children: stats.map((stat) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _StatCard(stat: stat, isDark: isDark),
                    );
                  }).toList(),
                );
              }
            },
          ),
        ),
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1);
  }
}

class _StatCard extends StatelessWidget {
  final dynamic stat;
  final bool isDark;

  const _StatCard({
    required this.stat,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
      borderRadius: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AnimatedCounter(
                value: stat.value,
                suffix: stat.suffix,
                textStyle: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: isDark ? AppColors.cyanAccent : AppColors.odooPurple,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: (isDark ? AppColors.cyanAccent : AppColors.odooPurple)
                      .withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  stat.icon,
                  size: 16,
                  color: isDark ? AppColors.cyanAccent : AppColors.odooPurple,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            stat.label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: isDark
                  ? AppColors.textDarkPrimary
                  : AppColors.textLightPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            stat.subtitle,
            style: TextStyle(
              fontSize: 12,
              color: isDark
                  ? AppColors.textDarkMuted
                  : AppColors.textLightSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
