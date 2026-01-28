import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ✅ Screens
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/new_project_screen.dart';
import 'screens/upload_resource_screen.dart';
import 'screens/view_project_screen.dart';
import 'screens/account_settings_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Makes the app draw behind system bars (modern edge-to-edge look)
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  // ✅ Ensures status/navigation bars match your dark UI (Android + iOS)
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light, // Android status bar icons
    statusBarBrightness: Brightness.dark, // iOS status bar style
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.light,
  ));

  runApp(const DATACApp());
}

/// ✅ Root app widget:
/// - Sets global theme (fonts, colors, shapes)
/// - Defines navigation routes
/// - Ensures a consistent Google Material 3 + iOS-like polished feel
class DATACApp extends StatelessWidget {
  const DATACApp({super.key});

  // ✅ Design tokens (single source of truth)
  // Keep these consistent for a premium look across all screens.
  static const Color _bg = Color(0xFF000000);       // Full-screen background
  static const Color _surface = Color(0xFF0E1220);  // Surface tone (cards/sheets)
  static const Color _brand = Color(0xFF30323D);    // DATAC brand grey
  static const Color _accent = Color(0xFF6C8BFF);   // Subtle modern accent
  static const double _radius = 16.0;              // Standard button radius

  @override
  Widget build(BuildContext context) {
    // ✅ Material 3 compliant color scheme
    // NOTE: Do NOT use `background/onBackground` (deprecated in new Flutter M3)
    final ColorScheme colorScheme = const ColorScheme.dark(
      primary: _accent,
      secondary: Color(0xFF9FA8DA),
      surface: _surface,
      onSurface: Colors.white,
      error: Color(0xFFFF5A5F),
      onError: Colors.white,
    );

    return MaterialApp(
      title: 'DATAC',
      debugShowCheckedModeBanner: false,

      // ✅ Global theme: makes UI consistent everywhere
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: colorScheme,
        fontFamily: 'Inter',

        // ✅ The real page background (your screens use images + overlays on top)
        scaffoldBackgroundColor: _bg,

        // ✅ Modern ripple (feels like Google apps)
        splashFactory: InkSparkle.splashFactory,

        // ✅ AppBar defaults (transparent, matches your glass/hero backgrounds)
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          centerTitle: false,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            fontFamily: 'Inter',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),

        // ✅ Typography system (consistent sizes & weights)
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.6,
            height: 1.05,
            color: Colors.white,
          ),
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.2,
            color: Colors.white,
          ),
          titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            height: 1.4,
            color: Colors.white,
          ),
          bodySmall: TextStyle(
            fontSize: 12.5,
            height: 1.35,
            color: Colors.white70,
          ),
          labelLarge: TextStyle(
            fontSize: 14.5,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),

        // ✅ Buttons: one style everywhere (clean + premium)
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Colors.white.withValues(alpha: 0.92),
            foregroundColor: _brand,
            minimumSize: const Size.fromHeight(52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_radius),
            ),
            textStyle: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              fontSize: 14.5,
            ),
          ).copyWith(
            overlayColor: WidgetStatePropertyAll(
              Colors.black.withValues(alpha: 0.06),
            ),
          ),
        ),

        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            minimumSize: const Size.fromHeight(52),
            side: BorderSide(color: Colors.white.withValues(alpha: 0.18)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_radius),
            ),
            textStyle: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
            ),
          ).copyWith(
            overlayColor: WidgetStatePropertyAll(
              Colors.white.withValues(alpha: 0.06),
            ),
          ),
        ),

        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white.withValues(alpha: 0.85),
            textStyle: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        // ✅ Inputs: consistent styling for all TextFormFields
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white.withValues(alpha: 0.06),
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          floatingLabelBehavior: FloatingLabelBehavior.always,

          labelStyle: TextStyle(
            fontFamily: 'Inter',
            color: Colors.white.withValues(alpha: 0.70),
            fontSize: 12.5,
          ),
          hintStyle: TextStyle(
            fontFamily: 'Inter',
            color: Colors.white.withValues(alpha: 0.40),
            fontSize: 12.8,
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.12)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.35)),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.red.withValues(alpha: 0.60)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.red.withValues(alpha: 0.85)),
          ),
        ),

        // ✅ Checkbox polish (matches your Login/Signup)
        checkboxTheme: CheckboxThemeData(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          side: BorderSide(color: Colors.white.withValues(alpha: 0.55)),
          checkColor: const WidgetStatePropertyAll(Colors.black),
          fillColor: const WidgetStatePropertyAll(Colors.white),
        ),

        // ✅ SnackBar styling (your demo Google login uses SnackBar)
        snackBarTheme: SnackBarThemeData(
          backgroundColor: const Color(0xFF111427),
          contentTextStyle: const TextStyle(
            fontFamily: 'Inter',
            color: Colors.white,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          behavior: SnackBarBehavior.floating,
        ),
      ),

      // ✅ First screen shown when the app launches
      initialRoute: LoginScreen.route,

      // ✅ Named routes: clean navigation without boilerplate
      routes: {
        LoginScreen.route: (_) => const LoginScreen(),
        SignUpScreen.route: (_) => const SignUpScreen(),
        DashboardScreen.route: (_) => const DashboardScreen(),
        NewProjectScreen.route: (_) => const NewProjectScreen(),
        UploadResourceScreen.route: (_) => const UploadResourceScreen(),
        ViewProjectScreen.route: (_) => const ViewProjectScreen(),
        AccountSettingsScreen.route: (_) => const AccountSettingsScreen(),
      },

      // ✅ Prevents crash if a route name is wrong
      onUnknownRoute: (_) => MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
    );
  }
}
