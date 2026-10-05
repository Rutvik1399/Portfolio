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

/// Contact Section with verified form validation, mailto fallback,
/// direct communication cards, and clean copyright footer.
class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    final name = _nameController.text.trim();
    final senderEmail = _emailController.text.trim();
    final subject = _subjectController.text.trim().isNotEmpty
        ? _subjectController.text.trim()
        : 'Portfolio Inquiry from $name';
    final message = _messageController.text.trim();

    final fullBody = 'Sender Name: $name\n'
        'Sender Email: $senderEmail\n\n'
        'Message:\n$message';

    // If Formspree endpoint is configured, you can submit via HTTP POST
    // Otherwise open user default mail client with prefilled body
    await UrlLauncherHelper.sendEmail(
      recipient: PortfolioData.email,
      subject: subject,
      body: fullBody,
    );

    if (mounted) {
      setState(() => _isSubmitting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Opening email client with your prefilled inquiry...',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          backgroundColor: AppColors.odooPurple,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: Responsive.value<double>(
          context: context,
          mobile: 16,
          tablet: 24,
          desktop: 24,
        ),
        right: Responsive.value<double>(
          context: context,
          mobile: 16,
          tablet: 24,
          desktop: 24,
        ),
        top: Responsive.value<double>(
          context: context,
          mobile: AppConstants.sectionVerticalSpacingMobile,
          desktop: AppConstants.sectionVerticalSpacing,
        ),
        bottom: 32,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints:
              const BoxConstraints(maxWidth: AppConstants.maxContentWidth),
          child: Column(
            children: [
              const SectionHeader(
                badge: '09 // GET IN TOUCH',
                title: 'Start a Conversation',
                highlightedWord: 'Conversation',
                subtitle:
                    'Whether you are looking for an ERP Solution Architect, '
                    'a Senior Odoo Developer, or enterprise technical advisory, let\'s connect.',
              ),
              const SizedBox(height: 54),

              ResponsiveBuilder(
                builder: (context, isMobile, isTablet, isDesktop) {
                  final formCard = _buildContactForm(isDark);
                  final infoCard = _buildContactInfo(isDark);

                  if (isDesktop) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 5, child: infoCard),
                        const SizedBox(width: 32),
                        Expanded(flex: 6, child: formCard),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        infoCard,
                        const SizedBox(height: 24),
                        formCard,
                      ],
                    );
                  }
                },
              ),

              const SizedBox(height: 72),
              const Divider(),
              const SizedBox(height: 28),

              // Footer Bar
              _buildFooter(isDark),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 500.ms);
  }

  Widget _buildContactInfo(bool isDark) {
    return Column(
      children: [
        _buildInfoTile(
          icon: FontAwesomeIcons.envelope,
          title: 'Email Address',
          value: PortfolioData.email,
          actionLabel: 'Send Email',
          onAction: () =>
              UrlLauncherHelper.sendEmail(recipient: PortfolioData.email),
          isDark: isDark,
        ),
        const SizedBox(height: 16),
        _buildInfoTile(
          icon: FontAwesomeIcons.phone,
          title: 'Direct Phone',
          value: PortfolioData.phone,
          actionLabel: 'Call Now',
          onAction: () =>
              UrlLauncherHelper.callPhone(PortfolioData.phoneClean),
          isDark: isDark,
        ),
        const SizedBox(height: 16),
        _buildInfoTile(
          icon: FontAwesomeIcons.linkedinIn,
          title: 'LinkedIn Network',
          value: 'linkedin.com/in/rutvik',
          actionLabel: 'View Profile',
          onAction: () => UrlLauncherHelper.openUrl(PortfolioData.linkedin),
          isDark: isDark,
        ),
        const SizedBox(height: 16),
        _buildInfoTile(
          icon: FontAwesomeIcons.locationDot,
          title: 'Base Location',
          value: PortfolioData.location,
          actionLabel: 'India',
          onAction: () {},
          isDark: isDark,
        ),
      ],
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String value,
    required String actionLabel,
    required VoidCallback onAction,
    required bool isDark,
  }) {
    return GlassContainer(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      borderRadius: 14,
      onTap: onAction,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.cyanAccent.withOpacity(0.12)
                  : AppColors.odooPurple.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              size: 16,
              color: isDark ? AppColors.cyanAccent : AppColors.odooPurple,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? AppColors.textDarkMuted
                        : AppColors.textLightMuted,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            size: 20,
            color: isDark
                ? AppColors.textDarkMuted
                : AppColors.textLightSecondary,
          ),
        ],
      ),
    );
  }

  Widget _buildContactForm(bool isDark) {
    return GlassContainer(
      padding: const EdgeInsets.all(28),
      borderRadius: 20,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Send a Direct Message',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Text(
              'Fill out the form below to initiate an email thread directly.',
              style: TextStyle(
                fontSize: 13,
                color: isDark
                    ? AppColors.textDarkSecondary
                    : AppColors.textLightSecondary,
              ),
            ),
            const SizedBox(height: 24),

            // Name Field
            TextFormField(
              controller: _nameController,
              decoration: _inputDecoration('Your Full Name', Icons.person_outline, isDark),
              validator: (val) {
                if (val == null || val.trim().isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Email Field
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: _inputDecoration('Your Work Email', Icons.email_outlined, isDark),
              validator: (val) {
                if (val == null || val.trim().isEmpty) {
                  return 'Please enter your email';
                }
                if (!val.contains('@') || !val.contains('.')) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Subject Field
            TextFormField(
              controller: _subjectController,
              decoration: _inputDecoration('Subject / Project Scope', Icons.topic_outlined, isDark),
            ),
            const SizedBox(height: 16),

            // Message Field
            TextFormField(
              controller: _messageController,
              maxLines: 4,
              decoration: _inputDecoration(
                'Describe your ERP requirements or opportunity...',
                Icons.chat_outlined,
                isDark,
              ),
              validator: (val) {
                if (val == null || val.trim().isEmpty) {
                  return 'Please provide a brief message';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),

            // Submit Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDark
                      ? AppColors.cyanAccent
                      : AppColors.odooPurple,
                  foregroundColor: isDark ? Colors.black : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                icon: _isSubmitting
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(FontAwesomeIcons.paperPlane, size: 14),
                label: Text(
                  _isSubmitting ? 'Preparing Email...' : 'Send Message',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                onPressed: _isSubmitting ? null : _handleSubmit,
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, IconData icon, bool isDark) {
    return InputDecoration(
      prefixIcon: Icon(
        icon,
        size: 18,
        color: isDark ? AppColors.textDarkMuted : AppColors.textLightSecondary,
      ),
      hintText: hint,
      hintStyle: TextStyle(
        fontSize: 13,
        color: isDark ? AppColors.textDarkMuted : AppColors.textLightMuted,
      ),
      filled: true,
      fillColor: isDark ? const Color(0xFF131B2A) : const Color(0xFFF8FAFC),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: isDark ? Colors.white12 : Colors.black12,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: isDark ? Colors.white12 : Colors.black12,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: isDark ? AppColors.cyanAccent : AppColors.odooPurple,
          width: 1.5,
        ),
      ),
    );
  }

  Widget _buildFooter(bool isDark) {
    return ResponsiveBuilder(
      builder: (context, isMobile, isTablet, isDesktop) {
        if (isMobile) {
          return Column(
            children: [
              Text(
                PortfolioData.footerCopyright,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: isDark
                      ? AppColors.textDarkMuted
                      : AppColors.textLightMuted,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: AppColors.cyanAccent,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    PortfolioData.footerTag,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? AppColors.textDarkSecondary
                          : AppColors.textLightSecondary,
                    ),
                  ),
                ],
              ),
            ],
          );
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              PortfolioData.footerCopyright,
              style: TextStyle(
                fontSize: 12,
                color: isDark
                    ? AppColors.textDarkMuted
                    : AppColors.textLightMuted,
              ),
            ),
            Row(
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: AppColors.cyanAccent,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  PortfolioData.footerTag,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? AppColors.textDarkSecondary
                        : AppColors.textLightSecondary,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
