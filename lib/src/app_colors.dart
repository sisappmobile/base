// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import "package:base/src/base_preferences.dart";
import "package:base/src/extensions.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class AppColors {
  static const String THEME_MODE = "THEME_MODE";

  static Brightness brightness() {
    ThemeMode mode = themeMode();

    if (mode == ThemeMode.light) {
      return Brightness.light;
    } else if (mode == ThemeMode.dark) {
      return Brightness.dark;
    } else {
      if (Get.context != null) {
        return MediaQuery.of(Get.context!).platformBrightness;
      }

      return Brightness.light;
    }
  }

  static Brightness brightnessInverse() {
    if (darkMode()) {
      return Brightness.light;
    } else {
      return Brightness.dark;
    }
  }

  static bool darkMode() {
    return brightness() == Brightness.dark;
  }

  static ThemeMode themeMode() {
    int value = BasePreferences.getInstance().getInt(THEME_MODE) ?? 0;

    if (value == 1) {
      return ThemeMode.light;
    } else if (value == 2) {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }

  static Color primary() {
    if (darkMode()) {
      return darkColorScheme.primary;
    } else {
      return lightColorScheme.primary;
    }
  }

  static Color onPrimary() {
    if (darkMode()) {
      return darkColorScheme.onPrimary;
    } else {
      return lightColorScheme.onPrimary;
    }
  }

  static Color primaryContainer() {
    if (darkMode()) {
      return darkColorScheme.primaryContainer;
    } else {
      return lightColorScheme.primaryContainer;
    }
  }

  static Color onPrimaryContainer() {
    if (darkMode()) {
      return darkColorScheme.onPrimaryContainer;
    } else {
      return lightColorScheme.onPrimaryContainer;
    }
  }

  static Color secondary() {
    if (darkMode()) {
      return darkColorScheme.secondary;
    } else {
      return lightColorScheme.secondary;
    }
  }

  static Color onSecondary() {
    if (darkMode()) {
      return darkColorScheme.onSecondary;
    } else {
      return lightColorScheme.onSecondary;
    }
  }

  static Color secondaryContainer() {
    if (darkMode()) {
      return darkColorScheme.secondaryContainer;
    } else {
      return lightColorScheme.secondaryContainer;
    }
  }

  static Color onSecondaryContainer() {
    if (darkMode()) {
      return darkColorScheme.onSecondaryContainer;
    } else {
      return lightColorScheme.onSecondaryContainer;
    }
  }

  static Color tertiary() {
    if (darkMode()) {
      return darkColorScheme.tertiary;
    } else {
      return lightColorScheme.tertiary;
    }
  }

  static Color onTertiary() {
    if (darkMode()) {
      return darkColorScheme.onTertiary;
    } else {
      return lightColorScheme.onTertiary;
    }
  }

  static Color tertiaryContainer() {
    if (darkMode()) {
      return darkColorScheme.tertiaryContainer;
    } else {
      return lightColorScheme.tertiaryContainer;
    }
  }

  static Color onTertiaryContainer() {
    if (darkMode()) {
      return darkColorScheme.onTertiaryContainer;
    } else {
      return lightColorScheme.onTertiaryContainer;
    }
  }

  static Color error() {
    if (darkMode()) {
      return darkColorScheme.error;
    } else {
      return lightColorScheme.error;
    }
  }

  static Color errorContainer() {
    if (darkMode()) {
      return darkColorScheme.errorContainer;
    } else {
      return lightColorScheme.errorContainer;
    }
  }

  static Color onError() {
    if (darkMode()) {
      return darkColorScheme.onError;
    } else {
      return lightColorScheme.onError;
    }
  }

  static Color onErrorContainer() {
    if (darkMode()) {
      return darkColorScheme.onErrorContainer;
    } else {
      return lightColorScheme.onErrorContainer;
    }
  }

  static Color background() {
    if (darkMode()) {
      return darkColorScheme.surface;
    } else {
      return lightColorScheme.surface;
    }
  }

  static Color onBackground() {
    if (darkMode()) {
      return darkColorScheme.onSurface;
    } else {
      return lightColorScheme.onSurface;
    }
  }

  static Color surface() {
    if (darkMode()) {
      return darkColorScheme.surface;
    } else {
      return lightColorScheme.surface;
    }
  }

  static Color onSurface() {
    if (darkMode()) {
      return darkColorScheme.onSurface;
    } else {
      return lightColorScheme.onSurface;
    }
  }

  static Color surfaceVariant() {
    if (darkMode()) {
      return darkColorScheme.surfaceContainerHighest;
    } else {
      return lightColorScheme.surfaceContainerHighest;
    }
  }

  static Color onSurfaceVariant() {
    if (darkMode()) {
      return darkColorScheme.onSurfaceVariant;
    } else {
      return lightColorScheme.onSurfaceVariant;
    }
  }

  static Color outline() {
    if (darkMode()) {
      return darkColorScheme.outline;
    } else {
      return lightColorScheme.outline;
    }
  }

  static Color onInverseSurface() {
    if (darkMode()) {
      return darkColorScheme.onInverseSurface;
    } else {
      return lightColorScheme.onInverseSurface;
    }
  }

  static Color inverseSurface() {
    if (darkMode()) {
      return darkColorScheme.inverseSurface;
    } else {
      return lightColorScheme.inverseSurface;
    }
  }

  static Color inversePrimary() {
    if (darkMode()) {
      return darkColorScheme.inversePrimary;
    } else {
      return lightColorScheme.inversePrimary;
    }
  }

  static Color shadow() {
    if (darkMode()) {
      return darkColorScheme.shadow;
    } else {
      return lightColorScheme.shadow;
    }
  }

  static Color surfaceTint() {
    if (darkMode()) {
      return darkColorScheme.surfaceTint;
    } else {
      return lightColorScheme.surfaceTint;
    }
  }

  static Color outlineVariant() {
    if (darkMode()) {
      return darkColorScheme.outlineVariant;
    } else {
      return lightColorScheme.outlineVariant;
    }
  }

  static Color scrim() {
    if (darkMode()) {
      return darkColorScheme.scrim;
    } else {
      return lightColorScheme.scrim;
    }
  }

  static Color success() {
    if (darkMode()) {
      return Colors.green.shade100;
    } else {
      return Colors.green.shade700;
    }
  }

  static Color onSuccess() {
    if (darkMode()) {
      return Colors.green.shade900;
    } else {
      return Colors.white;
    }
  }

  static Color successContainer() {
    if (darkMode()) {
      return Colors.green.shade700;
    } else {
      return Colors.green.shade100;
    }
  }

  static Color onSuccessContainer() {
    if (darkMode()) {
      return Colors.white;
    } else {
      return Colors.green.shade900;
    }
  }

  static Color warning() {
    if (darkMode()) {
      return Colors.orange.shade100;
    } else {
      return Colors.orange.shade700;
    }
  }

  static Color onWarning() {
    if (darkMode()) {
      return Colors.orange.shade900;
    } else {
      return Colors.orange.shade100;
    }
  }

  static Color warningContainer() {
    if (darkMode()) {
      return Colors.orange.shade700;
    } else {
      return Colors.orange.shade100;
    }
  }

  static Color onWarningContainer() {
    if (darkMode()) {
      return Colors.orange.shade100;
    } else {
      return Colors.orange.shade900;
    }
  }

  static Color backgroundSurface() {
    if (darkMode()) {
      return darkColorScheme.surface.darken(50);
    } else {
      return lightColorScheme.surface.darken(5);
    }
  }

  static Color material(MaterialColor materialColor) {
    if (darkMode()) {
      return materialColor.shade100;
    } else {
      return materialColor.shade700;
    }
  }

  static Color onMaterial(MaterialColor materialColor) {
    if (darkMode()) {
      return materialColor.shade900;
    } else {
      return materialColor.shade50;
    }
  }

  static Color materialContainer(MaterialColor materialColor) {
    if (darkMode()) {
      return materialColor.shade700;
    } else {
      return materialColor.shade100;
    }
  }

  static Color onMaterialContainer(MaterialColor materialColor) {
    if (darkMode()) {
      return materialColor.shade50;
    } else {
      return materialColor.shade900;
    }
  }

  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFFBB1614),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFFFDAD5),
    onPrimaryContainer: Color(0xFF410001),
    secondary: Color(0xFF695F00),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFFF9E534),
    onSecondaryContainer: Color(0xFF201C00),
    tertiary: Color(0xFF1160A4),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFD3E4FF),
    onTertiaryContainer: Color(0xFF001C38),
    error: Color(0xFFBA1A1A),
    errorContainer: Color(0xFFFFDAD6),
    onError: Color(0xFFFFFFFF),
    onErrorContainer: Color(0xFF410002),
    surface: Color(0xFFFFFBFF),
    onSurface: Color(0xFF201A19),
    surfaceContainerHighest: Color(0xFFF5DDDA),
    onSurfaceVariant: Color(0xFF534341),
    outline: Color(0xFF857370),
    onInverseSurface: Color(0xFFFBEEEC),
    inverseSurface: Color(0xFF362F2E),
    inversePrimary: Color(0xFFFFB4A9),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFFBB1614),
    outlineVariant: Color(0xFFD8C2BE),
    scrim: Color(0xFF000000),
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFFFFB4A9),
    onPrimary: Color(0xFF690002),
    primaryContainer: Color(0xFF930005),
    onPrimaryContainer: Color(0xFFFFDAD5),
    secondary: Color(0xFFDBC90A),
    onSecondary: Color(0xFF363100),
    secondaryContainer: Color(0xFF4F4800),
    onSecondaryContainer: Color(0xFFF9E534),
    tertiary: Color(0xFFA1C9FF),
    onTertiary: Color(0xFF00325B),
    tertiaryContainer: Color(0xFF004880),
    onTertiaryContainer: Color(0xFFD3E4FF),
    error: Color(0xFFFFB4AB),
    errorContainer: Color(0xFF93000A),
    onError: Color(0xFF690005),
    onErrorContainer: Color(0xFFFFDAD6),
    surface: Color(0xFF201A19),
    onSurface: Color(0xFFEDE0DE),
    surfaceContainerHighest: Color(0xFF534341),
    onSurfaceVariant: Color(0xFFD8C2BE),
    outline: Color(0xFFA08C89),
    onInverseSurface: Color(0xFF201A19),
    inverseSurface: Color(0xFFEDE0DE),
    inversePrimary: Color(0xFFBB1614),
    shadow: Color(0xFF000000),
    surfaceTint: Color(0xFFFFB4A9),
    outlineVariant: Color(0xFF534341),
    scrim: Color(0xFF000000),
  );
}
