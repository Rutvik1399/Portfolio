import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive_builder.dart';
import '../../../data/models/portfolio_models.dart';
import '../../../data/portfolio_data.dart';
import '../../providers/portfolio_providers.dart';
import '../../widgets/glass_container.dart';
import '../../widgets/section_header.dart';

/// Vertical animated timeline presenting work history with dynamic title and bullet mapping.
class ExperienceSection extends ConsumerWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewMode = ref.watch(viewModeProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const experiences = PortfolioData.experiences;

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
                badge: '02 // CAREER TIMELINE',
                title: 'Professional Track Record & Milestones',
                highlightedWord: 'Milestones',
                subtitle:
                    'Demonstrated leadership across high-scale enterprise Odoo deployments, '
                    'custom module development, and ERP consulting engagements.',
              ),
              const SizedBox(height: 54),

              // Timeline List
              Column(
                children: List.generate(experiences.length, (index) {
                  final exp = experiences[index];
                  final isLast = index == experiences.length - 1;

                  return _TimelineCard(
                    exp: exp,
                    viewMode: viewMode,
                    isDark: isDark,
                    isLast: isLast,
                    index: index,
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 500.ms);
  }
}

class _TimelineCard extends StatelessWidget {
  final ExperienceItem exp;
  final ProfileViewMode viewMode;
  final bool isDark;
  final bool isLast;
  final int index;

  const _TimelineCard({
    required this.exp,
    required this.viewMode,
    required this.isDark,
    required this.isLast,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final title = exp.getTitle(viewMode);
    final bullets = exp.getBullets(viewMode);

    return ResponsiveBuilder(
      builder: (context, isMobile, isTablet, isDesktop) {
        final nodeSize = isMobile ? 32.0 : 38.0;
        final spineLeft = isMobile ? 15.0 : 18.0;

        return Stack(
          children: [
            // Left continuous timeline spine
            if (!isLast)
              Positioned(
                top: 20,
                bottom: 0,
                left: spineLeft,
                child: Container(
                  width: 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        index == 0
                            ? AppColors.cyanAccent
                            : (isDark ? Colors.white24 : Colors.black12),
                        isDark ? Colors.white12 : Colors.black12,
                      ],
                    ),
                  ),
                ),
              ),

            // Timeline Node and Content Card
            Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 36),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: nodeSize,
                    height: nodeSize,
                    decoration: BoxDecoration(
                      gradient: index == 0
                          ? AppColors.purpleCyanGradient
                          : null,
                      color: index == 0
                          ? null
                          : (isDark
                              ? const Color(0xFF1E293B)
                              : const Color(0xFFE2E8F0)),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: index == 0
                            ? AppColors.cyanAccent
                            : (isDark ? Colors.white24 : Colors.black26),
                        width: 2,
                      ),
                      boxShadow: index == 0
                          ? [
                              BoxShadow(
                                color: AppColors.cyanAccent.withOpacity(0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : null,
                    ),
                    child: Center(
                      child: Icon(
                        index == 0
                            ? FontAwesomeIcons.bolt
                            : FontAwesomeIcons.clockRotateLeft,
                        size: isMobile ? 12 : 14,
                        color: index == 0
                            ? Colors.white
                            : (isDark ? Colors.white70 : Colors.black87),
                      ),
                    ),
                  ),
                  SizedBox(width: isMobile ? 12 : 20),

                  // Right Content Card
                  Expanded(
                    child: GlassContainer(
                      padding: EdgeInsets.all(isMobile ? 16 : 28),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Meta bar: Period, Company, Location
                          Wrap(
                            spacing: 12,
                            runSpacing: 8,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: (isDark
                                          ? AppColors.cyanAccent
                                          : AppColors.odooPurple)
                                      .withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  exp.period,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: isDark
                                        ? AppColors.cyanAccent
                                        : AppColors.odooPurple,
                                  ),
                                ),
                              ),
                              Text(
                                exp.company,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    size: 14,
                                    color: isDark
                                        ? AppColors.textDarkMuted
                                        : AppColors.textLightMuted,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    exp.location,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isDark
                                          ? AppColors.textDarkMuted
                                          : AppColors.textLightMuted,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          // Title dynamically matched to viewMode
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 250),
                            child: Text(
                              title,
                              key: ValueKey('${exp.company}_$title'),
                              style: TextStyle(
                                fontSize: isMobile ? 16 : 18,
                                fontWeight: FontWeight.w700,
                                color: isDark
                                    ? AppColors.textDarkPrimary
                                    : AppColors.textLightPrimary,
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),
                          const Divider(),
                          const SizedBox(height: 16),

                          // Bullets list
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 250),
                            child: Column(
                              key: ValueKey('${exp.company}_${viewMode.name}'),
                              children: bullets.map((bullet) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Icon(
                                          Icons.arrow_right,
                                          size: 18,
                                          color: viewMode.isDeveloper
                                              ? AppColors.cyanAccent
                                              : AppColors.odooPurpleLight,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          bullet,
                                          style: TextStyle(
                                            fontSize: 14,
                                            height: 1.55,
                                            color: isDark
                                                ? AppColors.textDarkSecondary
                                                : AppColors.textLightSecondary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),

                          const SizedBox(height: 14),

                          // Technologies / Skills tags
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: exp.technologies.map((tech) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? const Color(0xFF161F30)
                                      : const Color(0xFFF1F5F9),
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: isDark
                                        ? Colors.white12
                                        : Colors.black12,
                                  ),
                                ),
                                child: Text(
                                  tech,
                                  style: TextStyle(
                                    fontSize: 11,
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
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
