import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive_builder.dart';
import '../../../core/utils/url_launcher_helper.dart';
import '../../../data/portfolio_data.dart';
import '../../providers/portfolio_providers.dart';
import '../../widgets/view_toggle_switch.dart';

/// Hero Section with typewriter rotating title, location chip, dual-profile buttons,
/// social links, and an enterprise tech background glow.
class HeroSection extends ConsumerStatefulWidget {
  final VoidCallback onContactTap;

  const HeroSection({
    super.key,
    required this.onContactTap,
  });

  @override
  ConsumerState<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends ConsumerState<HeroSection> {
  int _currentTitleIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 3200), (timer) {
      if (mounted) {
        setState(() {
          _currentTitleIndex =
              (_currentTitleIndex + 1) % PortfolioData.rotatingTitles.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currentViewMode = ref.watch(viewModeProvider);

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
          mobile: 48,
          tablet: 72,
          desktop: 96,
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
          child: ResponsiveBuilder(
            builder: (context, isMobile, isTablet, isDesktop) {
              return Column(
                crossAxisAlignment: isMobile
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: [
                  // Top Chips: Available for Opportunities & Location
                  Wrap(
                    spacing: 12,
                    runSpacing: 10,
                    alignment:
                        isMobile ? WrapAlignment.center : WrapAlignment.start,
                    children: [
                      // Active status chip
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.emeraldAccent.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.emeraldAccent.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: AppColors.emeraldAccent,
                                shape: BoxShape.circle,
                              ),
                            )
                                .animate(onPlay: (c) => c.repeat(reverse: true))
                                .scale(
                                  duration: 1000.ms,
                                  begin: const Offset(0.8, 0.8),
                                  end: const Offset(1.2, 1.2),
                                ),
                            const SizedBox(width: 8),
                            const Flexible(
                              child: Text(
                                'AVAILABLE FOR ERP ARCHITECTURE & CONSULTING',
                                style: TextStyle(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.6,
                                  color: AppColors.emeraldAccent,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Location Chip
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: isDark
                              ? Colors.white.withOpacity(0.06)
                              : Colors.black.withOpacity(0.04),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isDark
                                ? Colors.white.withOpacity(0.1)
                                : Colors.black.withOpacity(0.08),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              FontAwesomeIcons.locationDot,
                              size: 11,
                              color: isDark
                                  ? AppColors.cyanAccent
                                  : AppColors.odooPurple,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              PortfolioData.location,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: isDark
                                    ? AppColors.textDarkSecondary
                                    : AppColors.textLightSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ).animate().fadeIn(duration: 400.ms).slideY(begin: -0.2),

                  const SizedBox(height: 24),

                  // Name Display
                  Text(
                    PortfolioData.fullName,
                    textAlign: isMobile ? TextAlign.center : TextAlign.start,
                    style: TextStyle(
                      fontSize: isMobile ? 36 : (isTablet ? 52 : 64),
                      fontWeight: FontWeight.w900,
                      letterSpacing: -1.0,
                      height: 1.1,
                      color: isDark
                          ? AppColors.textDarkPrimary
                          : AppColors.textLightPrimary,
                    ),
                  ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1),

                  const SizedBox(height: 16),

                  // Animated Rotating Subtitle (Typewriter / Carousel)
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: isMobile ? 54 : 48,
                    ),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      transitionBuilder: (child, animation) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0.0, 0.4),
                            end: Offset.zero,
                          ).animate(animation),
                          child: FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        );
                      },
                      child: Text(
                        PortfolioData.rotatingTitles[_currentTitleIndex],
                        key: ValueKey<int>(_currentTitleIndex),
                        textAlign:
                            isMobile ? TextAlign.center : TextAlign.start,
                        style: TextStyle(
                          fontSize: isMobile ? 22 : 30,
                          fontWeight: FontWeight.w700,
                          foreground: Paint()
                            ..shader = const LinearGradient(
                              colors: [
                                AppColors.cyanAccent,
                                AppColors.odooPurpleLight,
                              ],
                            ).createShader(
                                const Rect.fromLTWH(0, 0, 350, 40)),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Tagline
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 780),
                    child: Text(
                      PortfolioData.tagline,
                      textAlign: isMobile ? TextAlign.center : TextAlign.start,
                      style: TextStyle(
                        fontSize: isMobile ? 16 : 19,
                        height: 1.6,
                        fontWeight: FontWeight.w400,
                        color: isDark
                            ? AppColors.textDarkSecondary
                            : AppColors.textLightSecondary,
                      ),
                    ),
                  ).animate().fadeIn(delay: 200.ms, duration: 500.ms),

                  const SizedBox(height: 28),

                  // Prominent View Toggle in Hero
                  Wrap(
                    spacing: 16,
                    runSpacing: 12,
                    alignment:
                        isMobile ? WrapAlignment.center : WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        'EXPLORE PROFILE:',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                          color: isDark
                              ? AppColors.textDarkMuted
                              : AppColors.textLightMuted,
                        ),
                      ),
                      const ViewToggleSwitch(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: (currentViewMode.isDeveloper
                                  ? AppColors.cyanAccent
                                  : AppColors.odooPurple)
                              .withOpacity(0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          currentViewMode.badgeLabel,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                            color: currentViewMode.isDeveloper
                                ? AppColors.cyanAccent
                                : AppColors.odooPurpleLight,
                          ),
                        ),
                      ),
                    ],
                  ).animate().fadeIn(delay: 300.ms),

                  const SizedBox(height: 36),

                  // Action Buttons: Resumes & Contact
                  Wrap(
                    spacing: 16,
                    runSpacing: 14,
                    alignment:
                        isMobile ? WrapAlignment.center : WrapAlignment.start,
                    children: [
                      // Download Resume (Developer)
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.cyanAccent,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 16),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(FontAwesomeIcons.download, size: 14),
                        label: const Text(
                          'Resume (Developer)',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 14),
                        ),
                        onPressed: () => UrlLauncherHelper.downloadResume(
                            PortfolioData.devResumePath),
                      ),

                      // Download Resume (Functional)
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.odooPurple,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 16),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(FontAwesomeIcons.download, size: 14),
                        label: const Text(
                          'Resume (Functional)',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 14),
                        ),
                        onPressed: () => UrlLauncherHelper.downloadResume(
                            PortfolioData.functionalResumePath),
                      ),

                      // Contact Me Button
                      OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: isDark
                              ? AppColors.textDarkPrimary
                              : AppColors.textLightPrimary,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 16),
                          side: BorderSide(
                            color: isDark
                                ? Colors.white.withOpacity(0.2)
                                : Colors.black.withOpacity(0.2),
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(FontAwesomeIcons.paperPlane, size: 14),
                        label: const Text(
                          'Contact Me',
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 14),
                        ),
                        onPressed: widget.onContactTap,
                      ),
                    ],
                  ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.15),

                  const SizedBox(height: 36),

                  // Social Icons (Email, LinkedIn, Phone, GitHub)
                  Row(
                    mainAxisAlignment: isMobile
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.start,
                    children: [
                      _SocialIconButton(
                        icon: FontAwesomeIcons.envelope,
                        tooltip: PortfolioData.email,
                        onTap: () => UrlLauncherHelper.sendEmail(
                            recipient: PortfolioData.email),
                      ),
                      const SizedBox(width: 14),
                      _SocialIconButton(
                        icon: FontAwesomeIcons.linkedinIn,
                        tooltip: 'LinkedIn Profile',
                        onTap: () =>
                            UrlLauncherHelper.openUrl(PortfolioData.linkedin),
                      ),
                      const SizedBox(width: 14),
                      _SocialIconButton(
                        icon: FontAwesomeIcons.phone,
                        tooltip: PortfolioData.phone,
                        onTap: () =>
                            UrlLauncherHelper.callPhone(PortfolioData.phoneClean),
                      ),
                      const SizedBox(width: 14),
                      _SocialIconButton(
                        icon: FontAwesomeIcons.github,
                        tooltip: 'GitHub Profile',
                        onTap: () =>
                            UrlLauncherHelper.openUrl(PortfolioData.github),
                      ),
                    ],
                  ).animate().fadeIn(delay: 500.ms),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _SocialIconButton extends StatefulWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const _SocialIconButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  @override
  State<_SocialIconButton> createState() => _SocialIconButtonState();
}

class _SocialIconButtonState extends State<_SocialIconButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: Tooltip(
        message: widget.tooltip,
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 44,
            height: 44,
            transform: _hovered
                ? (Matrix4.identity()..translate(0.0, -3.0, 0.0))
                : Matrix4.identity(),
            decoration: BoxDecoration(
              color: isDark
                  ? (_hovered ? AppColors.cyanAccent : const Color(0xFF1E293B))
                  : (_hovered ? AppColors.odooPurple : const Color(0xFFF1F5F9)),
              shape: BoxShape.circle,
              border: Border.all(
                color: isDark
                    ? (_hovered
                        ? AppColors.cyanAccent
                        : Colors.white.withOpacity(0.1))
                    : (_hovered
                        ? AppColors.odooPurple
                        : Colors.black.withOpacity(0.08)),
                width: 1.2,
              ),
              boxShadow: _hovered
                  ? [
                      BoxShadow(
                        color: (isDark
                                ? AppColors.cyanAccent
                                : AppColors.odooPurple)
                            .withOpacity(0.35),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ]
                  : null,
            ),
            child: Center(
              child: Icon(
                widget.icon,
                size: 16,
                color: _hovered
                    ? (isDark ? Colors.black : Colors.white)
                    : (isDark
                        ? AppColors.textDarkSecondary
                        : AppColors.textLightSecondary),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
