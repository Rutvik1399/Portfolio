import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../providers/portfolio_providers.dart';
import '../sections/about/about_section.dart';
import '../sections/contact/contact_section.dart';
import '../sections/experience/experience_section.dart';
import '../sections/flagship/flagship_section.dart';
import '../sections/hero/hero_section.dart';
import '../sections/marketplace/marketplace_section.dart';
import '../sections/navbar/mobile_drawer.dart';
import '../sections/navbar/navbar_section.dart';
import '../sections/projects/projects_section.dart';
import '../sections/skills/skills_section.dart';
import '../sections/solutions/solutions_section.dart';
import '../sections/stats/stats_section.dart';
import '../sections/strengths/strengths_section.dart';
import '../widgets/custom_scroll_progress_bar.dart';

/// Single-page scroll layout coordinating all sections, scroll indicators,
/// anchor jump points, and mobile drawer.
class PortfolioPage extends ConsumerStatefulWidget {
  const PortfolioPage({super.key});

  @override
  ConsumerState<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends ConsumerState<PortfolioPage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Section Keys for smooth anchor scrolling
  final Map<String, GlobalKey> _sectionKeys = {
    AppConstants.sectionHome: GlobalKey(),
    AppConstants.sectionAbout: GlobalKey(),
    AppConstants.sectionExperience: GlobalKey(),
    AppConstants.sectionFlagship: GlobalKey(),
    AppConstants.sectionSolutions: GlobalKey(),
    AppConstants.sectionSkills: GlobalKey(),
    AppConstants.sectionStrengths: GlobalKey(),
    AppConstants.sectionMarketplace: GlobalKey(),
    AppConstants.sectionProjects: GlobalKey(),
    AppConstants.sectionContact: GlobalKey(),
  };

  bool _showBackToTop = false;

  double _lastScrollOffset = 0;
  double _lastReportedProgress = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;

    // Throttle scroll progress updates to avoid unnecessary micro-rebuilds
    final progress =
        maxScroll > 0 ? (currentScroll / maxScroll).clamp(0.0, 1.0) : 0.0;
    if ((progress - _lastReportedProgress).abs() >= 0.005 ||
        progress == 0.0 ||
        progress == 1.0) {
      _lastReportedProgress = progress;
      ref.read(scrollProgressProvider.notifier).state = progress;
    }

    // Show/hide Back to Top button
    if (currentScroll > 400 && !_showBackToTop) {
      setState(() => _showBackToTop = true);
    } else if (currentScroll <= 400 && _showBackToTop) {
      setState(() => _showBackToTop = false);
    }

    // Throttle section boundary checks to run only on significant scroll delta or boundaries
    if ((currentScroll - _lastScrollOffset).abs() >= 40 ||
        currentScroll <= 10 ||
        currentScroll >= maxScroll - 10) {
      _lastScrollOffset = currentScroll;
      _updateActiveSection();
    }
  }

  void _updateActiveSection() {
    String currentActive = AppConstants.sectionHome;

    for (final entry in _sectionKeys.entries) {
      final keyContext = entry.value.currentContext;
      if (keyContext != null) {
        final box = keyContext.findRenderObject() as RenderBox?;
        if (box != null && box.hasSize) {
          final position = box.localToGlobal(Offset.zero);
          // If section is within top half of viewport
          if (position.dy <= 200) {
            currentActive = entry.key;
          }
        }
      }
    }

    if (ref.read(activeSectionProvider) != currentActive) {
      ref.read(activeSectionProvider.notifier).state = currentActive;
    }
  }

  void _scrollToSection(String sectionId) {
    final key = _sectionKeys[sectionId];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
        alignment: 0.05,
      );
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      key: _scaffoldKey,
      drawer: MobileDrawer(
        onNavTap: _scrollToSection,
      ),
      body: Stack(
        children: [
          // Ambient Gradient Orbs in Background
          Positioned(
            top: -150,
            right: -100,
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    (isDark ? AppColors.odooPurple : AppColors.odooPurpleLight)
                        .withOpacity(isDark ? 0.18 : 0.08),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 400,
            left: -150,
            child: Container(
              width: 450,
              height: 450,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.cyanAccent.withOpacity(isDark ? 0.12 : 0.05),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Main Scroll View
          Column(
            children: [
              // Sticky Navbar
              NavbarSection(
                onNavTap: _scrollToSection,
                onOpenDrawer: () => _scaffoldKey.currentState?.openDrawer(),
              ),

              // Scrollable Body
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    children: [
                      // Section 0: Hero
                      Container(
                        key: _sectionKeys[AppConstants.sectionHome],
                        child: HeroSection(
                          onContactTap: () =>
                              _scrollToSection(AppConstants.sectionContact),
                        ),
                      ),

                      // Section: Stats Strip
                      const StatsSection(),

                      // Section 1: About
                      Container(
                        key: _sectionKeys[AppConstants.sectionAbout],
                        child: const AboutSection(),
                      ),

                      // Section 2: Experience
                      Container(
                        key: _sectionKeys[AppConstants.sectionExperience],
                        child: const ExperienceSection(),
                      ),

                      // Section 3: Flagship Product
                      Container(
                        key: _sectionKeys[AppConstants.sectionFlagship],
                        child: const FlagshipSection(),
                      ),

                      // Section 4: Key Solutions
                      Container(
                        key: _sectionKeys[AppConstants.sectionSolutions],
                        child: const SolutionsSection(),
                      ),

                      // Section 5: Skills
                      Container(
                        key: _sectionKeys[AppConstants.sectionSkills],
                        child: const SkillsSection(),
                      ),

                      // Section 6: Core Strengths
                      Container(
                        key: _sectionKeys[AppConstants.sectionStrengths],
                        child: const StrengthsSection(),
                      ),

                      // Section 7: Odoo Marketplace
                      Container(
                        key: _sectionKeys[AppConstants.sectionMarketplace],
                        child: const MarketplaceSection(),
                      ),

                      // Section 8: Personal Projects
                      Container(
                        key: _sectionKeys[AppConstants.sectionProjects],
                        child: const ProjectsSection(),
                      ),

                      // Section 9: Contact & Footer
                      Container(
                        key: _sectionKeys[AppConstants.sectionContact],
                        child: const ContactSection(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Top Progress Bar
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomScrollProgressBar(),
          ),

          // Floating Back To Top Button
          if (_showBackToTop)
            Positioned(
              bottom: 24,
              right: 24,
              child: FloatingActionButton.small(
                backgroundColor: isDark
                    ? AppColors.surfaceDarkCard
                    : AppColors.surfaceLight,
                foregroundColor: isDark
                    ? AppColors.cyanAccent
                    : AppColors.odooPurple,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: isDark
                        ? AppColors.cyanAccent.withOpacity(0.3)
                        : AppColors.odooPurple.withOpacity(0.2),
                  ),
                ),
                onPressed: _scrollToTop,
                tooltip: 'Back to Top',
                child: const Icon(FontAwesomeIcons.arrowUp, size: 14),
              ),
            ),
        ],
      ),
    );
  }
}
