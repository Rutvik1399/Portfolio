import 'package:flutter/material.dart';

/// Active profile view mode for the portfolio.
enum ProfileViewMode {
  developer,
  functional;

  bool get isDeveloper => this == ProfileViewMode.developer;
  bool get isFunctional => this == ProfileViewMode.functional;

  String get label {
    switch (this) {
      case ProfileViewMode.developer:
        return 'Developer View';
      case ProfileViewMode.functional:
        return 'Functional View';
    }
  }

  String get badgeLabel {
    switch (this) {
      case ProfileViewMode.developer:
        return 'TECHNICAL ARCHITECT';
      case ProfileViewMode.functional:
        return 'SOLUTION ARCHITECT';
    }
  }
}

/// Model for animated statistics counters.
class StatItem {
  final double value;
  final String suffix;
  final String label;
  final String subtitle;
  final IconData icon;

  const StatItem({
    required this.value,
    required this.suffix,
    required this.label,
    required this.subtitle,
    required this.icon,
  });
}

/// Model for work experience entries.
class ExperienceItem {
  final String company;
  final String period;
  final String location;
  final String devTitle;
  final String functionalTitle;
  final List<String> devBullets;
  final List<String> functionalBullets;
  final List<String> technologies;

  const ExperienceItem({
    required this.company,
    required this.period,
    required this.location,
    required this.devTitle,
    required this.functionalTitle,
    required this.devBullets,
    required this.functionalBullets,
    required this.technologies,
  });

  String getTitle(ProfileViewMode mode) =>
      mode.isDeveloper ? devTitle : functionalTitle;

  List<String> getBullets(ProfileViewMode mode) =>
      mode.isDeveloper ? devBullets : functionalBullets;
}

/// Model for Key Solutions showcase.
class SolutionItem {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final ProfileViewMode category;
  final List<String> badges;
  final List<String> highlights;
  final IconData icon;

  const SolutionItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.category,
    required this.badges,
    required this.highlights,
    required this.icon,
  });
}

/// Model for Skill category groups.
class SkillGroup {
  final String categoryName;
  final IconData icon;
  final List<String> skills;

  const SkillGroup({
    required this.categoryName,
    required this.icon,
    required this.skills,
  });
}

/// Model for Core Strengths.
class CoreStrength {
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;

  const CoreStrength({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
  });
}

/// Model for Flagship ERP Architecture Steps.
class FlagshipStep {
  final int step;
  final String title;
  final String subtitle;
  final String devNote;
  final String functionalNote;
  final IconData icon;

  const FlagshipStep({
    required this.step,
    required this.title,
    required this.subtitle,
    required this.devNote,
    required this.functionalNote,
    required this.icon,
  });
}

/// Model for Education credentials.
class EducationItem {
  final String degree;
  final String institution;
  final String location;
  final String period;

  const EducationItem({
    required this.degree,
    required this.institution,
    required this.location,
    required this.period,
  });
}

/// Model for Spoken Languages.
class LanguageItem {
  final String language;
  final String proficiency;

  const LanguageItem({
    required this.language,
    required this.proficiency,
  });
}
