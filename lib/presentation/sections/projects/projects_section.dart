import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive_builder.dart';
import '../../../data/portfolio_data.dart';
import '../../providers/portfolio_providers.dart';
import '../../widgets/glass_container.dart';
import '../../widgets/section_header.dart';

/// Personal Project Section highlighting "New Vision Design"
/// dynamically displaying technical architecture or functional specifications.
class ProjectsSection extends ConsumerWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewMode = ref.watch(viewModeProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final description = viewMode.isDeveloper
        ? PortfolioData.projectDevDescription
        : PortfolioData.projectFunctionalDescription;

    final highlights = viewMode.isDeveloper
        ? PortfolioData.projectDevTech
        : PortfolioData.projectFunctionalHighlights;

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
                badge: '08 // FEATURED INITIATIVE',
                title: 'Featured Independent Project',
                highlightedWord: 'Independent Project',
                subtitle:
                    'Applying modern Odoo architecture and service portal concepts '
                    'to residential construction and homeowner service lifecycles.',
              ),
              const SizedBox(height: 48),

              // Project Card
              ResponsiveBuilder(
                builder: (context, isMobile, isTablet, isDesktop) {
                  return GlassContainer(
                    padding: EdgeInsets.all(isMobile ? 18 : 32),
                    borderRadius: 22,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (isMobile) ...[
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  gradient: AppColors.purpleCyanGradient,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  FontAwesomeIcons.houseLaptop,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Expanded(
                                child: Text(
                                  PortfolioData.projectName,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? Colors.white.withOpacity(0.08)
                                      : Colors.black.withOpacity(0.06),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text(
                                  viewMode.label.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 9.5,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.8,
                                    color: isDark
                                        ? AppColors.textDarkMuted
                                        : AppColors.textLightSecondary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            PortfolioData.projectSubtitle,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: isDark
                                  ? AppColors.cyanAccent
                                  : AppColors.odooPurple,
                            ),
                          ),
                        ] else ...[
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  gradient: AppColors.purpleCyanGradient,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  FontAwesomeIcons.houseLaptop,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      PortfolioData.projectName,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    Text(
                                      PortfolioData.projectSubtitle,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: isDark
                                            ? AppColors.cyanAccent
                                            : AppColors.odooPurple,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? Colors.white.withOpacity(0.08)
                                      : Colors.black.withOpacity(0.06),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  viewMode.label.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.8,
                                    color: isDark
                                        ? AppColors.textDarkMuted
                                        : AppColors.textLightSecondary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],

                        const SizedBox(height: 20),

                        // Narrative
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          child: Text(
                            description,
                            key: ValueKey(viewMode),
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.65,
                              color: isDark
                                  ? AppColors.textDarkSecondary
                                  : AppColors.textLightSecondary,
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),
                        const Divider(),
                        const SizedBox(height: 20),

                        // Tags & Badges
                        Text(
                          viewMode.isDeveloper
                              ? 'TECHNOLOGY STACK & ALGORITHMS:'
                              : 'FUNCTIONAL CAPABILITIES & PORTAL SPECS:',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                            color: isDark
                                ? AppColors.textDarkMuted
                                : AppColors.textLightMuted,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: highlights.map((tag) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? const Color(0xFF161F30)
                                    : const Color(0xFFF1F5F9),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: viewMode.isDeveloper
                                      ? AppColors.cyanAccent.withOpacity(0.3)
                                      : AppColors.odooPurple.withOpacity(0.3),
                                ),
                              ),
                              child: Text(
                                tag,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: isDark
                                      ? AppColors.textDarkPrimary
                                      : AppColors.textLightPrimary,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
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
