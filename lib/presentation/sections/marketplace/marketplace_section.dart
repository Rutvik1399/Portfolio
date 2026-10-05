import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive_builder.dart';
import '../../../core/utils/url_launcher_helper.dart';
import '../../../data/portfolio_data.dart';
import '../../widgets/glass_container.dart';
import '../../widgets/section_header.dart';

/// Odoo Marketplace Section highlighting open community contributions
/// and published enterprise modules on the official Odoo Apps Store.
class MarketplaceSection extends StatelessWidget {
  const MarketplaceSection({super.key});

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
                badge: '07 // COMMUNITY & ECOSYSTEM',
                title: 'Odoo Apps Store Publisher',
                highlightedWord: 'Apps Store',
                subtitle:
                    'Contributing reusable, battle-tested solutions to the global Odoo community, '
                    'translating everyday ERP challenges into standardized community modules.',
              ),
              const SizedBox(height: 48),

              // Feature Card
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
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AppColors.odooPurple.withOpacity(0.18),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: AppColors.odooPurpleLight
                                        .withOpacity(0.4),
                                  ),
                                ),
                                child: const Icon(
                                  FontAwesomeIcons.cubes,
                                  size: 22,
                                  color: AppColors.odooPurpleLight,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      PortfolioData.marketplaceTitle,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 3),
                                      decoration: BoxDecoration(
                                        color: AppColors.emeraldAccent
                                            .withOpacity(0.12),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: AppColors.emeraldAccent
                                              .withOpacity(0.4),
                                        ),
                                      ),
                                      child: const Text(
                                        'VERIFIED PUBLISHER',
                                        style: TextStyle(
                                          fontSize: 9.5,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.8,
                                          color: AppColors.emeraldAccent,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Text(
                            PortfolioData.marketplaceSubtitle,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: isDark
                                  ? AppColors.cyanAccent
                                  : AppColors.odooPurple,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            PortfolioData.marketplaceDescription,
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.6,
                              color: isDark
                                  ? AppColors.textDarkSecondary
                                  : AppColors.textLightSecondary,
                            ),
                          ),
                        ] else ...[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: AppColors.odooPurple.withOpacity(0.18),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: AppColors.odooPurpleLight
                                        .withOpacity(0.4),
                                  ),
                                ),
                                child: const Icon(
                                  FontAwesomeIcons.cubes,
                                  size: 28,
                                  color: AppColors.odooPurpleLight,
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Wrap(
                                      spacing: 12,
                                      runSpacing: 6,
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: [
                                        const Text(
                                          PortfolioData.marketplaceTitle,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: AppColors.emeraldAccent
                                                .withOpacity(0.12),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                              color: AppColors.emeraldAccent
                                                  .withOpacity(0.4),
                                            ),
                                          ),
                                          child: const Text(
                                            'VERIFIED PUBLISHER',
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 0.8,
                                              color: AppColors.emeraldAccent,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      PortfolioData.marketplaceSubtitle,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: isDark
                                            ? AppColors.cyanAccent
                                            : AppColors.odooPurple,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      PortfolioData.marketplaceDescription,
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
                              ),
                            ],
                          ),
                        ],

                        const SizedBox(height: 24),
                        const Divider(),
                        const SizedBox(height: 20),

                        // Bullet Highlights
                        Wrap(
                          spacing: 16,
                          runSpacing: 14,
                          children: PortfolioData.marketplaceHighlights.map((hl) {
                            return SizedBox(
                              width: isDesktop
                                  ? 520
                                  : (isTablet ? 320 : double.infinity),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Icon(
                                      FontAwesomeIcons.circleCheck,
                                      size: 14,
                                      color: isDark
                                          ? AppColors.cyanAccent
                                          : AppColors.odooPurple,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      hl,
                                      style: TextStyle(
                                        fontSize: 13,
                                        height: 1.5,
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

                        const SizedBox(height: 32),

                        // Button to Odoo Apps Store
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.odooPurple,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 14),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          icon: const Icon(FontAwesomeIcons.arrowUpRightFromSquare,
                              size: 13),
                          label: const Text(
                            'View on Odoo Apps Store',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          onPressed: () => UrlLauncherHelper.openUrl(
                              PortfolioData.odooAppsUrl),
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
