import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive_builder.dart';
import '../../../data/models/portfolio_models.dart';
import '../../../data/portfolio_data.dart';
import '../../widgets/glass_container.dart';
import '../../widgets/section_header.dart';

/// Skills Section displaying verified technical and functional proficiencies grouped by domain.
/// Adheres strictly to genuine skills without artificial percentage gauges.
class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const groups = PortfolioData.skillGroups;

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
                badge: '05 // DOMAIN & TECHNICAL PROFICIENCIES',
                title: 'Core Technologies & Business Domains',
                highlightedWord: 'Core Technologies',
                subtitle:
                    'Demonstrated competencies spanning full-stack Odoo engineering, '
                    'enterprise databases, statutory tax compliance, and client onboarding.',
              ),
              const SizedBox(height: 54),

              // Responsive Grid of Skill Groups
              ResponsiveBuilder(
                builder: (context, isMobile, isTablet, isDesktop) {
                  final columnCount = isDesktop ? 3 : (isTablet ? 2 : 1);

                  return LayoutBuilder(
                    builder: (context, constraints) {
                      const spacing = 20.0;
                      final totalSpacing = spacing * (columnCount - 1);
                      final cardWidth =
                          (constraints.maxWidth - totalSpacing) / columnCount;

                      return Wrap(
                        spacing: spacing,
                        runSpacing: spacing,
                        children: groups.map((group) {
                          return SizedBox(
                            width: cardWidth,
                            child: _SkillGroupCard(
                              group: group,
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

class _SkillGroupCard extends StatelessWidget {
  final SkillGroup group;
  final bool isDark;

  const _SkillGroupCard({
    required this.group,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.all(22),
      borderRadius: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with icon
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.cyanAccent.withOpacity(0.12)
                      : AppColors.odooPurple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  group.icon,
                  size: 16,
                  color: isDark ? AppColors.cyanAccent : AppColors.odooPurple,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  group.categoryName,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Skill Chips
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: group.skills.map((skill) {
              return _SkillChip(
                skillName: skill,
                isDark: isDark,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _SkillChip extends StatefulWidget {
  final String skillName;
  final bool isDark;

  const _SkillChip({
    required this.skillName,
    required this.isDark,
  });

  @override
  State<_SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<_SkillChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: widget.isDark
              ? (_hovered
                  ? AppColors.cyanAccent.withOpacity(0.18)
                  : const Color(0xFF1E293B))
              : (_hovered
                  ? AppColors.odooPurple.withOpacity(0.12)
                  : const Color(0xFFF1F5F9)),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: widget.isDark
                ? (_hovered
                    ? AppColors.cyanAccent.withOpacity(0.6)
                    : Colors.white.withOpacity(0.08))
                : (_hovered
                    ? AppColors.odooPurple.withOpacity(0.4)
                    : Colors.black.withOpacity(0.08)),
            width: 1,
          ),
        ),
        child: Text(
          widget.skillName,
          style: TextStyle(
            fontSize: 12,
            fontWeight: _hovered ? FontWeight.w700 : FontWeight.w500,
            color: widget.isDark
                ? (_hovered
                    ? AppColors.cyanAccent
                    : AppColors.textDarkPrimary)
                : (_hovered
                    ? AppColors.odooPurple
                    : AppColors.textLightPrimary),
          ),
        ),
      ),
    );
  }
}
