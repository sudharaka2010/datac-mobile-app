import 'package:flutter/material.dart';
import '../widgets/glass_card.dart';
import 'login_screen.dart';
import 'dashboard_screen.dart';

class SignUpScreen extends StatefulWidget {
  static const route = '/signup';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final emailCtrl = TextEditingController();
  final nameCtrl = TextEditingController();
  final usernameCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final confirmCtrl = TextEditingController();

  bool hidePassword = true;
  bool hideConfirm = true;
  bool agree = true;

  @override
  void dispose() {
    emailCtrl.dispose();
    nameCtrl.dispose();
    usernameCtrl.dispose();
    passCtrl.dispose();
    confirmCtrl.dispose();
    super.dispose();
  }

  void _signup() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacementNamed(context, DashboardScreen.route);
    }
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
                    hasScrollBody: false, // ✅ centered & safe
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
                                        'Create account',
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w800,
                                          fontSize: 24,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        'Sign up to start collecting and managing data.',
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
                                        label: 'Email / Phone',
                                        hint: 'example@email.com',
                                        obscure: false,
                                        prefix: Icon(
                                          Icons.alternate_email_rounded,
                                          color: Colors.white.withValues(alpha: 0.60),
                                          size: 20,
                                        ),
                                        validator: (v) =>
                                            (v == null || v.trim().isEmpty)
                                                ? 'Required'
                                                : null,
                                      ),

                                      const SizedBox(height: 14),

                                      _input(
                                        controller: nameCtrl,
                                        label: 'Full name',
                                        hint: 'Your name',
                                        obscure: false,
                                        prefix: Icon(
                                          Icons.person_outline_rounded,
                                          color: Colors.white.withValues(alpha: 0.60),
                                          size: 20,
                                        ),
                                        validator: (v) =>
                                            (v == null || v.trim().isEmpty)
                                                ? 'Required'
                                                : null,
                                      ),

                                      const SizedBox(height: 14),

                                      _input(
                                        controller: usernameCtrl,
                                        label: 'Username',
                                        hint: 'username',
                                        obscure: false,
                                        prefix: Icon(
                                          Icons.badge_outlined,
                                          color: Colors.white.withValues(alpha: 0.60),
                                          size: 20,
                                        ),
                                        validator: (v) =>
                                            (v == null || v.trim().isEmpty)
                                                ? 'Required'
                                                : null,
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

                                      const SizedBox(height: 14),

                                      _input(
                                        controller: confirmCtrl,
                                        label: 'Confirm password',
                                        hint: '••••••••',
                                        obscure: hideConfirm,
                                        prefix: Icon(
                                          Icons.lock_outline_rounded,
                                          color: Colors.white.withValues(alpha: 0.60),
                                          size: 20,
                                        ),
                                        suffix: IconButton(
                                          onPressed: () => setState(
                                              () => hideConfirm = !hideConfirm),
                                          icon: Icon(
                                            hideConfirm
                                                ? Icons.visibility_off_rounded
                                                : Icons.visibility_rounded,
                                            color: Colors.white.withValues(alpha: 0.65),
                                            size: 20,
                                          ),
                                        ),
                                        validator: (v) {
                                          if (v == null || v.isEmpty) return 'Required';
                                          if (v != passCtrl.text) return 'Password not match';
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
                                              value: agree,
                                              onChanged: (v) =>
                                                  setState(() => agree = v ?? false),
                                              side: BorderSide(
                                                color: Colors.white.withValues(alpha: 0.55),
                                              ),
                                              activeColor: Colors.white,
                                              checkColor: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                              'I agree to the Terms & Privacy',
                                              style: TextStyle(
                                                fontFamily: 'Inter',
                                                color: Colors.white.withValues(alpha: 0.70),
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 16),

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
                                          onPressed: agree ? _signup : null,
                                          child: const Text(
                                            'Create account',
                                            style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14.5,
                                            ),
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 14),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Already have an account? ",
                                            style: TextStyle(
                                              fontFamily: 'Inter',
                                              color: Colors.white.withValues(alpha: 0.60),
                                              fontSize: 12,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () => Navigator.pushReplacementNamed(
                                              context,
                                              LoginScreen.route,
                                            ),
                                            child: const Text(
                                              "Log In",
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
