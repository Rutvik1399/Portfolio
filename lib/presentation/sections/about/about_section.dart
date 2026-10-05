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

/// About section dynamically adapting narrative for Developer View vs Functional View,
/// plus Education, Spoken Languages, and domain highlight badges.
class AboutSection extends ConsumerWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewMode = ref.watch(viewModeProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final summary = viewMode.isDeveloper
        ? PortfolioData.devSummary
        : PortfolioData.functionalSummary;

    final highlights = viewMode.isDeveloper
        ? PortfolioData.devHighlights
        : PortfolioData.functionalHighlights;

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
          constraints: const BoxConstraints(
            maxWidth: AppConstants.maxContentWidth,
          ),
          child: Column(
            children: [
              const SectionHeader(
                badge: '01 // PROFESSIONAL BACKGROUND',
                title: 'Bridging Technical Engineering with ERP Strategy',
                highlightedWord: 'ERP Strategy',
                subtitle:
                    'Dynamic profile switching tailored to your evaluation criteria. '
                    'Explore technical implementation depth or enterprise functional solutions.',
              ),
              const SizedBox(height: 48),
              ResponsiveBuilder(
                builder: (context, isMobile, isTablet, isDesktop) {
                  return Column(
                    children: [
                      // Main Narrative Glass Card
                      GlassContainer(
                        padding: EdgeInsets.all(isMobile ? 18 : 32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              alignment: WrapAlignment.spaceBetween,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 12,
                              runSpacing: 10,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: viewMode.isDeveloper
                                        ? AppColors.devViewGradient
                                        : AppColors.functionalViewGradient,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        viewMode.isDeveloper
                                            ? FontAwesomeIcons.terminal
                                            : FontAwesomeIcons.briefcase,
                                        size: 12,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        viewMode.label.toUpperCase(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.8,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  '5+ YEARS INDUSTRY EXPERIENCE',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.0,
                                    color: isDark
                                        ? AppColors.cyanAccent
                                        : AppColors.odooPurple,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            // Dynamic Narrative Text with smooth switch
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: Text(
                                summary,
                                key: ValueKey(viewMode),
                                style: TextStyle(
                                  fontSize: isMobile ? 15 : 17,
                                  height: 1.75,
                                  fontWeight: FontWeight.w400,
                                  color: isDark
                                      ? AppColors.textDarkPrimary
                                      : AppColors.textLightPrimary,
                                ),
                              ),
                            ),

                            const SizedBox(height: 24),
                            const Divider(),
                            const SizedBox(height: 20),

                            // Dynamic Highlights
                            Text(
                              'CORE COMPETENCIES IN THIS VIEW:',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.1,
                                color: isDark
                                    ? AppColors.textDarkMuted
                                    : AppColors.textLightMuted,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: highlights.map((hl) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? const Color(0xFF1E293B)
                                        : const Color(0xFFF1F5F9),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: viewMode.isDeveloper
                                          ? AppColors.cyanAccent.withOpacity(
                                              0.3,
                                            )
                                          : AppColors.odooPurple.withOpacity(
                                              0.3,
                                            ),
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.check_circle_rounded,
                                        size: 14,
                                        color: viewMode.isDeveloper
                                            ? AppColors.cyanAccent
                                            : AppColors.odooPurpleLight,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        hl,
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: isDark
                                              ? AppColors.textDarkPrimary
                                              : AppColors.textLightPrimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Side by Side: Education & Languages Cards
                      if (isDesktop || isTablet)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _buildEducationCard(isDark)),
                            const SizedBox(width: 24),
                            Expanded(child: _buildLanguagesCard(isDark)),
                          ],
                        )
                      else
                        Column(
                          children: [
                            _buildEducationCard(isDark),
                            const SizedBox(height: 16),
                            _buildLanguagesCard(isDark),
                          ],
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 500.ms);
  }

  Widget _buildEducationCard(bool isDark) {
    final edu = PortfolioData.education.first;

    return GlassContainer(
      padding: const EdgeInsets.all(24),
      borderRadius: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.cyanAccent.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  FontAwesomeIcons.graduationCap,
                  size: 16,
                  color: AppColors.cyanAccent,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'EDUCATION',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            edu.degree,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Text(
            edu.institution,
            style: TextStyle(
              fontSize: 14,
              color: isDark
                  ? AppColors.textDarkSecondary
                  : AppColors.textLightSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 14,
            runSpacing: 6,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 13,
                    color: isDark
                        ? AppColors.textDarkMuted
                        : AppColors.textLightMuted,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    edu.period,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color:
                          isDark ? AppColors.cyanAccent : AppColors.odooPurple,
                    ),
                  ),
                ],
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
                    edu.location,
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
        ],
      ),
    );
  }

  Widget _buildLanguagesCard(bool isDark) {
    return GlassContainer(
      padding: const EdgeInsets.all(24),
      borderRadius: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.odooPurple.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  FontAwesomeIcons.language,
                  size: 16,
                  color: AppColors.odooPurpleLight,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'LANGUAGES',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 10,
            children: PortfolioData.languages.map((lang) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF1E293B)
                      : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isDark ? Colors.white12 : Colors.black12,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      lang.language,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      lang.proficiency,
                      style: TextStyle(
                        fontSize: 11,
                        color: isDark
                            ? AppColors.cyanAccent
                            : AppColors.odooPurple,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
