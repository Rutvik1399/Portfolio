import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/theme/app_colors.dart';
import '../../data/models/portfolio_models.dart';
import '../providers/portfolio_providers.dart';

/// A sleek, segmented switch to toggle between "Developer View" and "Functional View".
class ViewToggleSwitch extends ConsumerWidget {
  final bool compact;

  const ViewToggleSwitch({
    super.key,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentMode = ref.watch(viewModeProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final isDev = currentMode == ProfileViewMode.developer;

    return Semantics(
      label: 'Switch between Developer View and Functional View',
      button: true,
      child: Container(
        height: compact ? 38 : 46,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isDark
              ? const Color(0xFF141C2E)
              : const Color(0xFFE2E8F0),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: isDark
                ? (isDev
                    ? AppColors.cyanAccent.withOpacity(0.35)
                    : AppColors.odooPurpleAccent.withOpacity(0.35))
                : Colors.black.withOpacity(0.08),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: isDev
                  ? AppColors.cyanAccent.withOpacity(0.1)
                  : AppColors.odooPurple.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildOption(
              context: context,
              ref: ref,
              label: compact ? 'Developer' : 'Developer View',
              icon: FontAwesomeIcons.code,
              isSelected: isDev,
              activeColor: AppColors.cyanAccent,
              activeTextColor: Colors.black,
              targetMode: ProfileViewMode.developer,
              compact: compact,
            ),
            const SizedBox(width: 4),
            _buildOption(
              context: context,
              ref: ref,
              label: compact ? 'Functional' : 'Functional View',
              icon: FontAwesomeIcons.briefcase,
              isSelected: !isDev,
              activeColor: AppColors.odooPurple,
              activeTextColor: Colors.white,
              targetMode: ProfileViewMode.functional,
              compact: compact,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption({
    required BuildContext context,
    required WidgetRef ref,
    required String label,
    required IconData icon,
    required bool isSelected,
    required Color activeColor,
    required Color activeTextColor,
    required ProfileViewMode targetMode,
    required bool compact,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: () {
        ref.read(viewModeProvider.notifier).setMode(targetMode);
      },
      borderRadius: BorderRadius.circular(22),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 240),
        curve: Curves.easeInOutCubic,
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 9 : 18,
          vertical: compact ? 6 : 8,
        ),
        decoration: BoxDecoration(
          color: isSelected ? activeColor : Colors.transparent,
          borderRadius: BorderRadius.circular(22),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: activeColor.withOpacity(0.35),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: compact ? 13 : 15,
              color: isSelected
                  ? activeTextColor
                  : (isDark
                      ? AppColors.textDarkMuted
                      : AppColors.textLightSecondary),
            ),
            const SizedBox(width: 7),
            Text(
              label,
              style: TextStyle(
                fontSize: compact ? 12 : 13,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected
                    ? activeTextColor
                    : (isDark
                        ? AppColors.textDarkSecondary
                        : AppColors.textLightSecondary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
