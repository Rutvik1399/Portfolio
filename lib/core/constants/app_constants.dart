/// Central application constants, breakpoints, and links.
class AppConstants {
  AppConstants._();

  // Responsive Breakpoints
  static const double mobileBreakpoint = 600.0;
  static const double tabletBreakpoint = 1024.0;
  static const double maxContentWidth = 1200.0;

  // Spacing & Layout
  static const double defaultPadding = 24.0;
  static const double sectionVerticalSpacing = 96.0;
  static const double sectionVerticalSpacingMobile = 64.0;

  // Section Identifiers for Navigation
  static const String sectionHome = 'home';
  static const String sectionAbout = 'about';
  static const String sectionExperience = 'experience';
  static const String sectionFlagship = 'flagship';
  static const String sectionSolutions = 'solutions';
  static const String sectionSkills = 'skills';
  static const String sectionStrengths = 'strengths';
  static const String sectionMarketplace = 'marketplace';
  static const String sectionProjects = 'projects';
  static const String sectionContact = 'contact';

  // Navigation Items
  static const List<Map<String, String>> navItems = [
    {'id': sectionHome, 'label': 'Home'},
    {'id': sectionAbout, 'label': 'About'},
    {'id': sectionExperience, 'label': 'Experience'},
    {'id': sectionFlagship, 'label': 'Flagship'},
    {'id': sectionSolutions, 'label': 'Solutions'},
    {'id': sectionSkills, 'label': 'Skills'},
    {'id': sectionStrengths, 'label': 'Strengths'},
    {'id': sectionMarketplace, 'label': 'Marketplace'},
    {'id': sectionProjects, 'label': 'Projects'},
    {'id': sectionContact, 'label': 'Contact'},
  ];

  // Resume Assets
  static const String devResumeAsset =
      'assets/resumes/Rutvik_Shah_Developer_Resume.pdf';
  static const String functionalResumeAsset =
      'assets/resumes/Rutvik_Shah_Functional_Resume.pdf';

  // Social & Contact Links
  static const String email = 'shahrutvik1399@gmail.com';
  static const String phone = '+91 7202080956';
  static const String phoneClean = '+917202080956';
  static const String linkedinUrl =
      'https://www.linkedin.com/in/rutvik-shah-898b34208?';
  static const String githubUrl = 'https://github.com/Rutvik1399';
  static const String odooAppsStoreUrl =
      'https://apps.odoo.com/apps/modules/browse?author=Rutvik%20Shah';

  // Formspree endpoint placeholder (fallback opens mailto)
  static const String formspreeEndpoint =
      ''; // e.g. 'https://formspree.io/f/xbjvkqlo'
}
