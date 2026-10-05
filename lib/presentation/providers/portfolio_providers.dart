import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/portfolio_models.dart';

// Keys for SharedPreferences
const String _kViewModePrefKey = 'rutvik_portfolio_view_mode';
const String _kThemeModePrefKey = 'rutvik_portfolio_theme_mode';

/// View Mode State Notifier (Developer vs Functional)
class ViewModeNotifier extends StateNotifier<ProfileViewMode> {
  ViewModeNotifier() : super(ProfileViewMode.developer) {
    _loadFromPrefs();
  }

  Future<void> _loadFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final saved = prefs.getString(_kViewModePrefKey);
      if (saved == ProfileViewMode.functional.name) {
        state = ProfileViewMode.functional;
      } else {
        state = ProfileViewMode.developer;
      }
    } catch (_) {}
  }

  Future<void> toggle() async {
    final next = state == ProfileViewMode.developer
        ? ProfileViewMode.functional
        : ProfileViewMode.developer;
    setMode(next);
  }

  Future<void> setMode(ProfileViewMode mode) async {
    if (state == mode) return;
    state = mode;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_kViewModePrefKey, mode.name);
    } catch (_) {}
  }
}

final viewModeProvider =
    StateNotifierProvider<ViewModeNotifier, ProfileViewMode>((ref) {
  return ViewModeNotifier();
});

/// Theme Mode State Notifier (Dark vs Light)
class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  ThemeModeNotifier() : super(ThemeMode.dark) {
    _loadFromPrefs();
  }

  Future<void> _loadFromPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final saved = prefs.getString(_kThemeModePrefKey);
      if (saved == 'light') {
        state = ThemeMode.light;
      } else {
        state = ThemeMode.dark;
      }
    } catch (_) {}
  }

  Future<void> toggle() async {
    final next = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    setTheme(next);
  }

  Future<void> setTheme(ThemeMode mode) async {
    if (state == mode) return;
    state = mode;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          _kThemeModePrefKey, mode == ThemeMode.light ? 'light' : 'dark');
    } catch (_) {}
  }
}

final themeModeProvider =
    StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  return ThemeModeNotifier();
});

/// Current active section ID in view (for navbar active underline)
final activeSectionProvider = StateProvider<String>((ref) => 'home');

/// Scroll progress (0.0 to 1.0) for the top progress bar
final scrollProgressProvider = StateProvider<double>((ref) => 0.0);
