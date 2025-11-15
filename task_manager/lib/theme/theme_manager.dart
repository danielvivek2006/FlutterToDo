import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManager extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeManager() {
    loadThemeMode();
  }

  ThemeMode getThemeMode() => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    _saveThemeMode(isDark);
    notifyListeners();
  }

  Future<void> loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('isDarkTheme') ?? false;
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  Future<void> _saveThemeMode(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkTheme', isDark);
  }
}