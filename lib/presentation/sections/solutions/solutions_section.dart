import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive_builder.dart';
import '../../../data/models/portfolio_models.dart';
import '../../../data/portfolio_data.dart';
import '../../providers/portfolio_providers.dart';
import '../../widgets/glass_container.dart';
import '../../widgets/section_header.dart';
import '../../widgets/view_toggle_switch.dart';

/// Key Solutions Section showcasing custom ERP modules and workflows,
/// filtering automatically based on the active Developer or Functional profile view.
class SolutionsSection extends ConsumerWidget {
  const SolutionsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewMode = ref.watch(viewModeProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final solutions = PortfolioData.solutions
        .where((s) => s.category == viewMode)
        .toList();

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
              SectionHeader(
                badge: '04 // CUSTOM MODULES & SOLUTIONS',
                title: viewMode.isDeveloper
                    ? 'Technical Engineering & Custom Engines'
                    : 'Business Processes & Domain Workflows',
                highlightedWord: viewMode.isDeveloper
                    ? 'Custom Engines'
                    : 'Domain Workflows',
                subtitle: viewMode.isDeveloper
                    ? 'Engineered to overcome native Odoo limitations: high-volume data ingestion, dynamic multi-tenant record rules, and dynamic report rendering.'
                    : 'Designed for strict operational control: inter-branch accounting, automotive valuation procedures, and seamless legacy migration.',
              ),
              const SizedBox(height: 28),

              // Filter switch indicator
              const Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 12,
                runSpacing: 8,
                children: [
                  Text(
                    'Viewing solutions for:',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                  ViewToggleSwitch(compact: true),
                ],
              ),

              const SizedBox(height: 48),

              // Solutions Grid
              ResponsiveBuilder(
                builder: (context, isMobile, isTablet, isDesktop) {
                  if (isDesktop) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: solutions.map((sol) {
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: _SolutionCard(
                              solution: sol,
                              isDark: isDark,
                              viewMode: viewMode,
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  } else if (isTablet) {
                    return Wrap(
                      spacing: 18,
                      runSpacing: 18,
                      alignment: WrapAlignment.center,
                      children: solutions.map((sol) {
                        return SizedBox(
                          width: 360,
                          child: _SolutionCard(
                            solution: sol,
                            isDark: isDark,
                            viewMode: viewMode,
                          ),
                        );
                      }).toList(),
                    );
                  } else {
                    return Column(
                      children: solutions.map((sol) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: _SolutionCard(
                            solution: sol,
                            isDark: isDark,
                            viewMode: viewMode,
                          ),
                        );
                      }).toList(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 500.ms);
  }
}

class _SolutionCard extends StatelessWidget {
  final SolutionItem solution;
  final bool isDark;
  final ProfileViewMode viewMode;

  const _SolutionCard({
    required this.solution,
    required this.isDark,
    required this.viewMode,
  });

  @override
  Widget build(BuildContext context) {
    final accentColor = viewMode.isDeveloper
        ? AppColors.cyanAccent
        : AppColors.odooPurpleLight;

    return GlassContainer(
      padding: const EdgeInsets.all(24),
      borderRadius: 18,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon and Category pill
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  solution.icon,
                  size: 20,
                  color: accentColor,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF1E293B)
                      : const Color(0xFFE2E8F0),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  viewMode.isDeveloper ? 'ENGINEERING' : 'WORKFLOW',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                    color: accentColor,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Title
          Text(
            solution.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),

          // Subtitle
          Text(
            solution.subtitle,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isDark
                  ? AppColors.textDarkMuted
                  : AppColors.textLightSecondary,
            ),
          ),

          const SizedBox(height: 14),

          // Description
          Text(
            solution.description,
            style: TextStyle(
              fontSize: 13,
              height: 1.6,
              color: isDark
                  ? AppColors.textDarkSecondary
                  : AppColors.textLightSecondary,
            ),
          ),

          const SizedBox(height: 18),
          const Divider(),
          const SizedBox(height: 14),

          // Key Highlights
          const Text(
            'KEY CAPABILITIES:',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 10),
          Column(
            children: solution.highlights.map((hl) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Icon(
                        Icons.check_circle_outline,
                        size: 13,
                        color: accentColor,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        hl,
                        style: TextStyle(
                          fontSize: 12,
                          height: 1.4,
                          color: isDark
                              ? AppColors.textDarkPrimary
                              : AppColors.textLightPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 16),

          // Badges
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: solution.badges.map((b) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF161F30)
                      : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: isDark ? Colors.white12 : Colors.black12,
                  ),
                ),
                child: Text(
                  b,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? AppColors.textDarkMuted
                        : AppColors.textLightSecondary,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
