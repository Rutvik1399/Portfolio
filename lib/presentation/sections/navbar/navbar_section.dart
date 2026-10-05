import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive_builder.dart';
import '../../providers/portfolio_providers.dart';
import '../../widgets/view_toggle_switch.dart';

/// Sticky glass navbar with animated active link indicator, view switch, theme toggle,
/// and mobile drawer trigger.
class NavbarSection extends ConsumerWidget implements PreferredSizeWidget {
  final void Function(String sectionId) onNavTap;
  final VoidCallback onOpenDrawer;

  const NavbarSection({
    super.key,
    required this.onNavTap,
    required this.onOpenDrawer,
  });

  @override
  Size get preferredSize => const Size.fromHeight(72);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final activeSection = ref.watch(activeSectionProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 72,
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.value<double>(
          context: context,
          mobile: 14,
          tablet: 20,
          desktop: 24,
        ),
      ),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF0B0F19).withOpacity(0.85)
            : const Color(0xFFFFFFFF).withOpacity(0.88),
        border: Border(
          bottom: BorderSide(
            color: isDark
                ? Colors.white.withOpacity(0.08)
                : Colors.black.withOpacity(0.06),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.25 : 0.05),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppConstants.maxContentWidth,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWideDesktop = constraints.maxWidth >= 1060;
              final isTablet = constraints.maxWidth >= 600 && constraints.maxWidth < 1060;

              return Row(
                children: [
                  // Brand Logo / Monogram
                  InkWell(
                    onTap: () => onNavTap(AppConstants.sectionHome),
                    borderRadius: BorderRadius.circular(8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            gradient: AppColors.purpleCyanGradient,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.cyanAccent.withOpacity(0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              'RS',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'RUTVIK SHAH',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 14.5,
                                letterSpacing: 0.6,
                              ),
                            ),
                            Text(
                              'ODOO ARCHITECT',
                              style: TextStyle(
                                fontSize: 9.5,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.1,
                                color: isDark
                                    ? AppColors.cyanAccent
                                    : AppColors.odooPurple,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  // Desktop Navigation Links
                  if (isWideDesktop) ...[
                    Flexible(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const ClampingScrollPhysics(),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: AppConstants.navItems.map((item) {
                            final id = item['id']!;
                            final label = item['label']!;
                            final isActive = activeSection == id;

                            return _NavLinkItem(
                              label: label,
                              isActive: isActive,
                              isDark: isDark,
                              onTap: () => onNavTap(id),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),

                    // View Mode Toggle (Dev vs Functional)
                    const ViewToggleSwitch(compact: true),
                    const SizedBox(width: 8),

                    // Theme Toggle Button
                    _ThemeToggleButton(
                      isDark: themeMode == ThemeMode.dark,
                      onToggle: () => ref.read(themeModeProvider.notifier).toggle(),
                    ),
                  ] else if (isTablet) ...[
                    // Tablet Layout
                    const ViewToggleSwitch(compact: true),
                    const SizedBox(width: 6),

                    _ThemeToggleButton(
                      isDark: themeMode == ThemeMode.dark,
                      onToggle: () => ref.read(themeModeProvider.notifier).toggle(),
                    ),
                    const SizedBox(width: 4),

                    IconButton(
                      icon: const Icon(Icons.menu_rounded, size: 28),
                      tooltip: 'Open Menu',
                      onPressed: onOpenDrawer,
                    ),
                  ] else ...[
                    // Mobile Layout (< 600px, down to 320px)
                    _ThemeToggleButton(
                      isDark: themeMode == ThemeMode.dark,
                      onToggle: () => ref.read(themeModeProvider.notifier).toggle(),
                    ),
                    const SizedBox(width: 4),

                    IconButton(
                      icon: const Icon(Icons.menu_rounded, size: 26),
                      tooltip: 'Open Menu',
                      onPressed: onOpenDrawer,
                    ),
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _NavLinkItem extends StatefulWidget {
  final String label;
  final bool isActive;
  final bool isDark;
  final VoidCallback onTap;

  const _NavLinkItem({
    required this.label,
    required this.isActive,
    required this.isDark,
    required this.onTap,
  });

  @override
  State<_NavLinkItem> createState() => _NavLinkItemState();
}

class _NavLinkItemState extends State<_NavLinkItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final activeOrHover = widget.isActive || _hovered;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: widget.isActive ? FontWeight.w700 : FontWeight.w500,
                  color: activeOrHover
                      ? (widget.isDark
                          ? AppColors.cyanAccent
                          : AppColors.odooPurple)
                      : (widget.isDark
                          ? AppColors.textDarkSecondary
                          : AppColors.textLightSecondary),
                ),
              ),
              const SizedBox(height: 4),
              // Animated underline
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2,
                width: activeOrHover ? 20 : 0,
                decoration: BoxDecoration(
                  gradient: AppColors.purpleCyanGradient,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ThemeToggleButton extends StatelessWidget {
  final bool isDark;
  final VoidCallback onToggle;

  const _ThemeToggleButton({required this.isDark, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, anim) =>
            RotationTransition(turns: anim, child: child),
        child: Icon(
          isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
          key: ValueKey(isDark),
          size: 20,
          color: isDark ? AppColors.cyanAccent : AppColors.odooPurple,
        ),
      ),
      tooltip: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
      onPressed: onToggle,
    );
  }
}
