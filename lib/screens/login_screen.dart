import 'package:flutter/material.dart';
import '../widgets/glass_card.dart';
import 'dashboard_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  static const route = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  bool rememberMe = true;
  bool hidePassword = true;

  @override
  void dispose() {
    emailCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacementNamed(context, DashboardScreen.route);
    }
  }

  void _googleLogin() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Google login (demo)')),
    );
  }

  @override
  Widget build(BuildContext context) {
    const datacColor = Color.fromRGBO(48, 50, 61, 1);

    final glassColor =
        const Color.fromRGBO(14, 18, 32, 1).withValues(alpha: 0.72);
    final borderColor = Colors.white.withValues(alpha: 0.10);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background
          Image.asset(
            'assets/images/bg_login.jpg',
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),

          // Soft overlay
          Container(color: Colors.black.withValues(alpha: 0.08)),

          // Bottom gradient
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.48,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.35),
                    Colors.black.withValues(alpha: 0.55),
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                  sliver: SliverFillRemaining(
                    hasScrollBody: false, // ✅ IMPORTANT: keeps centered & responsive
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Top-right brand
                        const Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            'DATAC',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w800,
                              fontSize: 34,
                              color: datacColor,
                            ),
                          ),
                        ),

                        const SizedBox(height: 14),

                        // Center card
                        Expanded(
                          child: Center(
                            child: SizedBox(
                              width: 340,
                              child: GlassCard(
                                glassColor: glassColor,
                                borderColor: borderColor,
                                radius: 22,
                                blur: 14,
                                padding: const EdgeInsets.fromLTRB(22, 22, 22, 18),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      const Text(
                                        'Welcome back',
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w800,
                                          fontSize: 24,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        'Log in to continue your work and manage projects.',
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          color: Colors.white.withValues(alpha: 0.65),
                                          fontSize: 12.8,
                                          height: 1.3,
                                        ),
                                      ),

                                      const SizedBox(height: 18),

                                      _input(
                                        controller: emailCtrl,
                                        label: 'Email / Username',
                                        hint: 'example@email.com',
                                        obscure: false,
                                        prefix: Icon(
                                          Icons.alternate_email_rounded,
                                          color: Colors.white.withValues(alpha: 0.60),
                                          size: 20,
                                        ),
                                        validator: (v) {
                                          if (v == null || v.trim().isEmpty) {
                                            return 'Required';
                                          }
                                          return null;
                                        },
                                      ),

                                      const SizedBox(height: 14),

                                      _input(
                                        controller: passCtrl,
                                        label: 'Password',
                                        hint: '••••••••',
                                        obscure: hidePassword,
                                        prefix: Icon(
                                          Icons.lock_outline_rounded,
                                          color: Colors.white.withValues(alpha: 0.60),
                                          size: 20,
                                        ),
                                        suffix: IconButton(
                                          onPressed: () => setState(
                                              () => hidePassword = !hidePassword),
                                          icon: Icon(
                                            hidePassword
                                                ? Icons.visibility_off_rounded
                                                : Icons.visibility_rounded,
                                            color: Colors.white.withValues(alpha: 0.65),
                                            size: 20,
                                          ),
                                        ),
                                        validator: (v) {
                                          if (v == null || v.isEmpty) return 'Required';
                                          if (v.length < 4) return 'Min 4 characters';
                                          return null;
                                        },
                                      ),

                                      const SizedBox(height: 12),

                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 18,
                                            height: 18,
                                            child: Checkbox(
                                              value: rememberMe,
                                              onChanged: (v) =>
                                                  setState(() => rememberMe = v ?? false),
                                              side: BorderSide(
                                                color: Colors.white.withValues(alpha: 0.55),
                                              ),
                                              activeColor: Colors.white,
                                              checkColor: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            'Remember me',
                                            style: TextStyle(
                                              fontFamily: 'Inter',
                                              color: Colors.white.withValues(alpha: 0.70),
                                              fontSize: 12,
                                            ),
                                          ),
                                          const Spacer(),
                                          TextButton(
                                            onPressed: () {},
                                            style: TextButton.styleFrom(
                                              padding: EdgeInsets.zero,
                                              minimumSize: const Size(10, 10),
                                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                            ),
                                            child: Text(
                                              'Forgot password?',
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                color: Colors.white.withValues(alpha: 0.70),
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 18),

                                      SizedBox(
                                        height: 54,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            elevation: 0,
                                            backgroundColor:
                                                Colors.white.withValues(alpha: 0.92),
                                            foregroundColor: datacColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(16),
                                            ),
                                          ),
                                          onPressed: _login,
                                          child: const Text(
                                            'Log In',
                                            style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14.5,
                                            ),
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 12),

                                      Row(
                                        children: [
                                          Expanded(
                                            child: Divider(
                                              color: Colors.white.withValues(alpha: 0.15),
                                              height: 1,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10),
                                            child: Text(
                                              'or',
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                color: Colors.white.withValues(alpha: 0.55),
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Divider(
                                              color: Colors.white.withValues(alpha: 0.15),
                                              height: 1,
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 12),

                                      SizedBox(
                                        height: 52,
                                        child: OutlinedButton.icon(
                                          onPressed: _googleLogin,
                                          style: OutlinedButton.styleFrom(
                                            foregroundColor: Colors.white,
                                            side: BorderSide(
                                              color: Colors.white.withValues(alpha: 0.18),
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(16),
                                            ),
                                          ),
                                          icon: Icon(
                                            Icons.g_mobiledata_rounded,
                                            color: Colors.white.withValues(alpha: 0.85),
                                            size: 28,
                                          ),
                                          label: const Text(
                                            'Continue with Google',
                                            style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 14),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Don’t have an account? ",
                                            style: TextStyle(
                                              fontFamily: 'Inter',
                                              color: Colors.white.withValues(alpha: 0.60),
                                              fontSize: 12,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () => Navigator.pushNamed(
                                              context,
                                              SignUpScreen.route,
                                            ),
                                            child: const Text(
                                              "Sign Up",
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white,
                                                fontSize: 12,
                                                decoration: TextDecoration.underline,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _input({
    required TextEditingController controller,
    required String label,
    required String hint,
    required bool obscure,
    required String? Function(String?) validator,
    Widget? prefix,
    Widget? suffix,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: validator,
      style: const TextStyle(
        fontFamily: 'Inter',
        color: Colors.white,
        fontSize: 13.2,
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
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
        prefixIcon: prefix,
        suffixIcon: suffix,
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.06),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.12)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.35)),
        ),
      ),
    );
  }
}
