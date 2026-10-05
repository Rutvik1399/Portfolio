import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/url_launcher_helper.dart';
import '../../../data/portfolio_data.dart';
import '../../providers/portfolio_providers.dart';
import '../../widgets/view_toggle_switch.dart';

/// Full-height sliding drawer for Mobile and Tablet viewports.
class MobileDrawer extends ConsumerWidget {
  final void Function(String sectionId) onNavTap;

  const MobileDrawer({
    super.key,
    required this.onNavTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final activeSection = ref.watch(activeSectionProvider);

    return Drawer(
      backgroundColor: isDark ? const Color(0xFF0F172A) : Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            // Drawer Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      gradient: AppColors.purpleCyanGradient,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        'RS',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          PortfolioData.fullName,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          PortfolioData.location,
                          style: TextStyle(
                            fontSize: 11,
                            color: isDark
                                ? AppColors.textDarkMuted
                                : AppColors.textLightSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),

            const Divider(),

            // Profile Toggle Mode inside drawer
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Center(
                child: ViewToggleSwitch(compact: true),
              ),
            ),

            const Divider(),

            // Nav List Items
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: AppConstants.navItems.map((item) {
                  final id = item['id']!;
                  final label = item['label']!;
                  final isActive = activeSection == id;

                  return ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 2),
                    leading: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isActive
                            ? AppColors.cyanAccent
                            : Colors.transparent,
                      ),
                    ),
                    title: Text(
                      label,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight:
                            isActive ? FontWeight.bold : FontWeight.w500,
                        color: isActive
                            ? (isDark
                                ? AppColors.cyanAccent
                                : AppColors.odooPurple)
                            : (isDark
                                ? AppColors.textDarkPrimary
                                : AppColors.textLightPrimary),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      onNavTap(id);
                    },
                  );
                }).toList(),
              ),
            ),

            const Divider(),

            // Resume Download & Contact Actions in Footer of Drawer
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(42),
                      side: BorderSide(
                        color: isDark
                            ? AppColors.cyanAccent.withOpacity(0.5)
                            : AppColors.odooPurple.withOpacity(0.5),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    icon: const Icon(FontAwesomeIcons.fileArrowDown, size: 14),
                    label: const Text('Download Dev Resume'),
                    onPressed: () => UrlLauncherHelper.downloadResume(
                        PortfolioData.devResumePath),
                  ),
                  const SizedBox(height: 8),
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(42),
                      side: BorderSide(
                        color: isDark
                            ? AppColors.odooPurpleAccent.withOpacity(0.5)
                            : AppColors.odooPurple.withOpacity(0.5),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    icon: const Icon(FontAwesomeIcons.fileArrowDown, size: 14),
                    label: const Text('Download Functional Resume'),
                    onPressed: () => UrlLauncherHelper.downloadResume(
                        PortfolioData.functionalResumePath),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
