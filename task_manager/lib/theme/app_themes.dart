import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;
import 'app_colors.dart';

class AppThemes {
  // iOS Light Theme
  static ThemeData iOSLightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFF007AFF),
    scaffoldBackgroundColor: const Color(0xFFF2F2F7),
    
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF007AFF),
      secondary: Color(0xFFFF9500),
      surface: Color(0xFFFFFFFF),
      error: Color(0xFFFF3B30),
    ),
    
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFF2F2F7),
      foregroundColor: Color(0xFF000000),
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: Color(0xFF000000),
        fontSize: 34,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.37,
      ),
    ),
    
    cardTheme: CardThemeData(
      color: const Color(0xFFFFFFFF),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Color(0xFF000000)),
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xFF000000)),
      titleMedium: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Color(0xFF000000)),
      bodyLarge: TextStyle(fontSize: 17, color: Color(0xFF000000)),
      bodyMedium: TextStyle(fontSize: 15, color: Color(0xFF6C6C70)),
      bodySmall: TextStyle(fontSize: 13, color: Color(0xFF8E8E93)),
    ),
  );
  
  // iOS Dark Theme
  static ThemeData iOSDarkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF0A84FF),
    scaffoldBackgroundColor: const Color(0xFF000000),
    
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF0A84FF),
      secondary: Color(0xFFFF9F0A),
      surface: Color(0xFF1C1C1E),
      error: Color(0xFFFF453A),
    ),
    
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF000000),
      foregroundColor: Color(0xFFFFFFFF),
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 34,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.37,
      ),
    ),
    
    cardTheme: CardThemeData(
      color: const Color(0xFF1C1C1E),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 34, fontWeight: FontWeight.bold, color: Color(0xFFFFFFFF)),
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xFFFFFFFF)),
      titleMedium: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Color(0xFFFFFFFF)),
      bodyLarge: TextStyle(fontSize: 17, color: Color(0xFFFFFFFF)),
      bodyMedium: TextStyle(fontSize: 15, color: Color(0xFF8E8E93)),
      bodySmall: TextStyle(fontSize: 13, color: Color(0xFF8E8E93)),
    ),
  );
  
  // Android Light Theme (Material 3)
  static ThemeData androidLightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF6200EE),
      brightness: Brightness.light,
    ),
    
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFFFFFFF),
      foregroundColor: Color(0xFF000000),
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: Color(0xFF000000),
        fontSize: 24,
        fontWeight: FontWeight.w500,
      ),
    ),
    
    cardTheme: CardThemeData(
      color: const Color(0xFFFFFFFF),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
  
  // Android Dark Theme (Material 3)
  static ThemeData androidDarkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFBB86FC),
      brightness: Brightness.dark,
    ),
    
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF121212),
      foregroundColor: Color(0xFFFFFFFF),
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 24,
        fontWeight: FontWeight.w500,
      ),
    ),
    
    cardTheme: CardThemeData(
      color: const Color(0xFF2C2C2C),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
  
  // Get appropriate theme based on platform and mode
  static ThemeData getLightTheme() {
    final isIOS = !kIsWeb && Platform.isIOS;
    final colors = AppColors(isDark: false, isIOS: isIOS);
    final baseTheme = isIOS ? iOSLightTheme : androidLightTheme;
    
    return baseTheme.copyWith(
      cardTheme: baseTheme.cardTheme.copyWith(
        color: colors.cardBackground,
      ),
    );
  }
  
  static ThemeData getDarkTheme() {
    final isIOS = !kIsWeb && Platform.isIOS;
    final colors = AppColors(isDark: true, isIOS: isIOS);
    final baseTheme = isIOS ? iOSDarkTheme : androidDarkTheme;
    
    return baseTheme.copyWith(
      cardTheme: baseTheme.cardTheme.copyWith(
        color: colors.cardBackground,
      ),
    );
  }
}