import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive_builder.dart';
import '../../../data/portfolio_data.dart';
import '../../providers/portfolio_providers.dart';
import '../../widgets/custom_paint_erp_diagram.dart';
import '../../widgets/glass_container.dart';
import '../../widgets/section_header.dart';

/// Flagship Product Section featuring the Automobile Dealership ERP
/// with a Flutter-drawn CustomPainter flow diagram and architectural breakdown.
class FlagshipSection extends ConsumerWidget {
  const FlagshipSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewMode = ref.watch(viewModeProvider);
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
                badge: '03 // FLAGSHIP PRODUCT ARCHITECTURE',
                title: 'Automobile Dealership ERP Suite',
                highlightedWord: 'Dealership ERP',
                subtitle:
                    'Engineered from scratch to orchestrate high-volume dealership groups across multiple showrooms, '
                    'integrating showroom sales pipelines, financier holds, gatepasses, GST accounting, and direct banking APIs.',
              ),
              const SizedBox(height: 48),

              // Large Case Study Glass Card
              GlassContainer(
                padding: EdgeInsets.all(Responsive.isMobile(context) ? 18 : 28),
                borderRadius: 24,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Bar: Enterprise badges
                    Wrap(
                      spacing: 10,
                      runSpacing: 8,
                      children: PortfolioData.flagshipBadges.map((badge) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: isDark
                                ? AppColors.odooPurple.withOpacity(0.2)
                                : AppColors.odooPurple.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isDark
                                  ? AppColors.cyanAccent.withOpacity(0.3)
                                  : AppColors.odooPurple.withOpacity(0.2),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                FontAwesomeIcons.shieldHalved,
                                size: 11,
                                color: isDark
                                    ? AppColors.cyanAccent
                                    : AppColors.odooPurple,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                badge,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
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

                    const SizedBox(height: 24),

                    // Overview description
                    Text(
                      PortfolioData.flagshipDescription,
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.65,
                        color: isDark
                            ? AppColors.textDarkSecondary
                            : AppColors.textLightSecondary,
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Architecture Flow Diagram Subheader
                    Wrap(
                      spacing: 12,
                      runSpacing: 6,
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              FontAwesomeIcons.diagramProject,
                              size: 16,
                              color: isDark
                                  ? AppColors.cyanAccent
                                  : AppColors.odooPurple,
                            ),
                            const SizedBox(width: 10),
                            const Flexible(
                              child: Text(
                                'INTERACTIVE DEALERSHIP LIFECYCLE',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Click any stage to inspect',
                          style: TextStyle(
                            fontSize: 11,
                            color: isDark
                                ? AppColors.textDarkMuted
                                : AppColors.textLightMuted,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // CustomPainter Engine
                    CustomPaintErpDiagram(viewMode: viewMode),

                    const SizedBox(height: 32),
                    const Divider(),
                    const SizedBox(height: 24),

                    // Dual Technical & Business Architecture Deep Dive Cards
                    ResponsiveBuilder(
                      builder: (context, isMobile, isTablet, isDesktop) {
                        final card1 = _buildDeepDiveCard(
                          context: context,
                          isDark: isDark,
                          title: 'Technical Implementation Details',
                          icon: FontAwesomeIcons.codeBranch,
                          accentColor: AppColors.cyanAccent,
                          points: [
                            'High-throughput PostgreSQL schema with partitioned tables for multi-branch sales data.',
                            'Optimized Odoo ORM methods with bulk write operations to minimize lock contention.',
                            'Automated webhook receivers for asynchronous ICICI bank credit notifications with SHA-256 payload verification.',
                            'Fail-safe rollback mechanisms for vehicle booking cancellations and token refunds.',
                          ],
                        );

                        final card2 = _buildDeepDiveCard(
                          context: context,
                          isDark: isDark,
                          title: 'Business & Functional Impact',
                          icon: FontAwesomeIcons.chartPie,
                          accentColor: AppColors.odooPurpleLight,
                          points: [
                            'Reduced end-of-month financial closing time across 4 dealership groups from 7 days to 4 hours.',
                            'Zero unallocated bank deposits through automated ICICI bank reconciliation matching.',
                            'Eliminated duplicate vehicle allocation errors between concurrent branch sales consultants.',
                            '100% statutory compliance with GSTR-1, GSTR-3B, and Indian E-Way Bill mandates.',
                          ],
                        );

                        if (isDesktop) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: card1),
                              const SizedBox(width: 20),
                              Expanded(child: card2),
                            ],
                          );
                        } else {
                          return Column(
                            children: [
                              card1,
                              const SizedBox(height: 16),
                              card2,
                            ],
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 500.ms);
  }

  Widget _buildDeepDiveCard({
    required BuildContext context,
    required bool isDark,
    required String title,
    required IconData icon,
    required Color accentColor,
    required List<String> points,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF131B2A) : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: accentColor.withOpacity(0.25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: accentColor),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Column(
            children: points.map((p) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 6),
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        color: accentColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        p,
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.5,
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
        ],
      ),
    );
  }
}
