import 'package:flutter/material.dart';

// Screens
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/new_project_screen.dart';
import 'screens/upload_resource_screen.dart';
import 'screens/view_project_screen.dart';
import 'screens/account_settings_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const DATACApp());
}

class DATACApp extends StatelessWidget {
  const DATACApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DATAC',
      debugShowCheckedModeBanner: false,

      // ✅ Modern default theme (neutral, works with glass UI)
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        fontFamily: 'Inter',
        scaffoldBackgroundColor: Colors.black,
      ),

      // ✅ Start with Login
      initialRoute: LoginScreen.route,

      // ✅ Centralized routing
      routes: {
        LoginScreen.route: (_) => const LoginScreen(),
        SignUpScreen.route: (_) => const SignUpScreen(),
        DashboardScreen.route: (_) => const DashboardScreen(),
        NewProjectScreen.route: (_) => const NewProjectScreen(),
        UploadResourceScreen.route: (_) => const UploadResourceScreen(),
        ViewProjectScreen.route: (_) => const ViewProjectScreen(),
        AccountSettingsScreen.route: (_) => const AccountSettingsScreen(),
      },

      // ✅ Fallback route (prevents crashes if route name is wrong)
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      ),
    );
  }
}
