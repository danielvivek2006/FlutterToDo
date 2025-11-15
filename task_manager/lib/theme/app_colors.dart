import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;

class AppColors {
  final bool isDark;
  final bool isIOS;
  
  AppColors({required this.isDark, required this.isIOS});
  
  // Background Colors
  Color get background {
    if (isIOS) {
      return isDark ? const Color(0xFF000000) : const Color(0xFFF2F2F7);
    } else {
      return isDark ? const Color(0xFF121212) : const Color(0xFFFFFFFF);
    }
  }
  
  Color get secondaryBackground {
    if (isIOS) {
      return isDark ? const Color(0xFF1C1C1E) : const Color(0xFFFFFFFF);
    } else {
      return isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF5F5F5);
    }
  }
  
  Color get cardBackground {
    if (isIOS) {
      return isDark ? const Color(0xFF1C1C1E) : const Color(0xFFFFFFFF);
    } else {
      return isDark ? const Color(0xFF2C2C2C) : const Color(0xFFFFFFFF);
    }
  }
  
  // Primary Colors
  Color get primary {
    if (isIOS) {
      return const Color(0xFF007AFF);
    } else {
      return isDark ? const Color(0xFFBB86FC) : const Color(0xFF6200EE);
    }
  }
  
  Color get primaryVariant {
    if (isIOS) {
      return const Color(0xFF0051D5);
    } else {
      return isDark ? const Color(0xFF985EFF) : const Color(0xFF3700B3);
    }
  }
  
  // Text Colors
  Color get textPrimary {
    return isDark ? const Color(0xFFFFFFFF) : const Color(0xFF000000);
  }
  
  Color get textSecondary {
    if (isIOS) {
      return isDark ? const Color(0xFF8E8E93) : const Color(0xFF6C6C70);
    } else {
      return isDark ? const Color(0xFFB3B3B3) : const Color(0xFF5F5F5F);
    }
  }
  
  Color get textTertiary {
    return isDark ? const Color(0xFF666666) : const Color(0xFF999999);
  }
  
  // Accent Colors
  Color get accent {
    if (isIOS) {
      return const Color(0xFFFF9500);
    } else {
      return isDark ? const Color(0xFF03DAC6) : const Color(0xFF018786);
    }
  }
  
  Color get success {
    return isDark ? const Color(0xFF34C759) : const Color(0xFF34C759);
  }
  
  Color get error {
    return isDark ? const Color(0xFFFF453A) : const Color(0xFFFF3B30);
  }
  
  Color get warning {
    return const Color(0xFFFF9500);
  }
  
  // Separator Colors
  Color get separator {
    if (isIOS) {
      return isDark 
          ? const Color(0xFF38383A) 
          : const Color(0xFFC6C6C8);
    } else {
      return isDark 
          ? const Color(0xFF3D3D3D) 
          : const Color(0xFFE0E0E0);
    }
  }
  
  // Border Colors
  Color get border {
    return isDark 
        ? const Color(0xFF38383A) 
        : const Color(0xFFD1D1D6);
  }
  
  // Checkbox/Radio Colors
  Color get checkboxBorder {
    if (isIOS) {
      return isDark ? const Color(0xFF48484A) : const Color(0xFFC7C7CC);
    } else {
      return isDark ? const Color(0xFF666666) : const Color(0xFFBDBDBD);
    }
  }
  
  Color get checkboxFilled {
    return primary;
  }
  
  // Progress/Slider Colors
  Color get progressBackground {
    return isDark ? const Color(0xFF3A3A3C) : const Color(0xFFE5E5EA);
  }
  
  Color get progressForeground {
    if (isIOS) {
      return const Color(0xFFFF9500);
    } else {
      return primary;
    }
  }
  
  // Tab Bar Colors
  Color get tabBarBackground {
    if (isIOS) {
      return isDark 
          ? const Color(0xFF1C1C1E).withOpacity(0.9) 
          : const Color(0xFFF9F9F9).withOpacity(0.9);
    } else {
      return isDark ? const Color(0xFF1E1E1E) : const Color(0xFFFFFFFF);
    }
  }
  
  Color get tabBarIcon {
    return isDark ? const Color(0xFF8E8E93) : const Color(0xFF999999);
  }
  
  Color get tabBarIconActive {
    return primary;
  }
  
  // Input Colors
  Color get inputBackground {
    if (isIOS) {
      return isDark ? const Color(0xFF1C1C1E) : const Color(0xFFF2F2F7);
    } else {
      return isDark ? const Color(0xFF2C2C2C) : const Color(0xFFF5F5F5);
    }
  }
  
  Color get inputBorder {
    return isDark ? const Color(0xFF38383A) : const Color(0xFFD1D1D6);
  }
  
  // Modal/Sheet Colors
  Color get modalBackground {
    if (isIOS) {
      return isDark ? const Color(0xFF1C1C1E) : const Color(0xFFFFFFFF);
    } else {
      return isDark ? const Color(0xFF2C2C2C) : const Color(0xFFFFFFFF);
    }
  }
  
  Color get overlay {
    return isDark 
        ? Colors.black.withOpacity(0.6) 
        : Colors.black.withOpacity(0.4);
  }
  
  // Shadow Colors
  Color get shadow {
    return isDark 
        ? Colors.black.withOpacity(0.3) 
        : Colors.black.withOpacity(0.1);
  }
}

// Extension for easy access
extension AppColorsExtension on BuildContext {
  AppColors get colors {
    final isDark = Theme.of(this).brightness == Brightness.dark;
    final isIOS = !kIsWeb && Platform.isIOS;
    return AppColors(isDark: isDark, isIOS: isIOS);
  }
}