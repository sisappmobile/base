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

  static late ColorScheme lightColorScheme;
  static late ColorScheme darkColorScheme;
}
