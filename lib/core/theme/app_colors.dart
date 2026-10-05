import 'package:flutter/material.dart';

/// Centralized color palette for Rutvik Shah's Portfolio.
/// Designed around an "Enterprise-Tech / ERP" aesthetic combining
/// Odoo's signature purple (#714B67) with modern cyan/teal highlights.
class AppColors {
  AppColors._();

  // Primary Brand Colors
  static const Color odooPurple = Color(0xFF714B67);
  static const Color odooPurpleLight = Color(0xFF8E6383);
  static const Color odooPurpleDark = Color(0xFF52334A);
  static const Color odooPurpleAccent = Color(0xFFA26F96);

  // Modern Accent Highlights (Fintech / High-Tech ERP feel)
  static const Color cyanAccent = Color(0xFF00D2D3);
  static const Color cyanAccentLight = Color(0xFF54EAEA);
  static const Color tealAccent = Color(0xFF0EA5E9);
  static const Color emeraldAccent = Color(0xFF10B981);
  static const Color amberAccent = Color(0xFFF59E0B);
  static const Color indigoAccent = Color(0xFF6366F1);

  // Dark Theme Colors
  static const Color bgDark = Color(0xFF0B0F19);
  static const Color bgDarkSecondary = Color(0xFF111827);
  static const Color surfaceDark = Color(0xFF161F30);
  static const Color surfaceDarkCard = Color(0xFF1E293B);
  static const Color borderDark = Color(0x1FFFFFFF);
  static const Color borderDarkGlow = Color(0x3300D2D3);

  static const Color textDarkPrimary = Color(0xFFF8FAFC);
  static const Color textDarkSecondary = Color(0xFF94A3B8);
  static const Color textDarkMuted = Color(0xFF64748B);

  // Light Theme Colors
  static const Color bgLight = Color(0xFFF8FAFC);
  static const Color bgLightSecondary = Color(0xFFEEF2F6);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceLightCard = Color(0xFFF1F5F9);
  static const Color borderLight = Color(0x14000000);
  static const Color borderLightGlow = Color(0x2B714B67);

  static const Color textLightPrimary = Color(0xFF0F172A);
  static const Color textLightSecondary = Color(0xFF475569);
  static const Color textLightMuted = Color(0xFF94A3B8);

  // Gradients
  static const LinearGradient purpleCyanGradient = LinearGradient(
    colors: [odooPurple, cyanAccent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroGlowGradient = LinearGradient(
    colors: [
      Color(0x33714B67),
      Color(0x2200D2D3),
      Colors.transparent,
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient cardDarkGradient = LinearGradient(
    colors: [
      Color(0xCC1E293B),
      Color(0x99111827),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardLightGradient = LinearGradient(
    colors: [
      Color(0xFAFFFFFF),
      Color(0xF0F8FAFC),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient devViewGradient = LinearGradient(
    colors: [Color(0xFF00D2D3), Color(0xFF0284C7)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient functionalViewGradient = LinearGradient(
    colors: [Color(0xFF8E6383), Color(0xFF714B67)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
