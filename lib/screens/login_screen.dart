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

  final _emailNode = FocusNode();
  final _passNode = FocusNode();

  bool rememberMe = true;
  bool hidePassword = true;

  @override
  void dispose() {
    _emailNode.dispose();
    _passNode.dispose();
    emailCtrl.dispose();
    passCtrl.dispose();
    super.dispose();
  }

  void _login() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() ?? false) {
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
    // ✅ Pull typography from global theme
    final text = Theme.of(context).textTheme;

    // ✅ Your glass tokens
    final glassColor = const Color.fromRGBO(14, 18, 32, 1).withValues(alpha: 0.72);
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
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                  sliver: SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Brand
                        const Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            'DATAC',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w900,
                              fontSize: 34,
                              color: Colors.white,
                              letterSpacing: 0.2,
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
                                child: AutofillGroup(
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          'Welcome back',
                                          style: text.titleLarge?.copyWith(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 24,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          'Log in to continue your work and manage projects.',
                                          style: text.bodySmall?.copyWith(
                                            color: Colors.white.withValues(alpha: 0.65),
                                          ),
                                        ),

                                        const SizedBox(height: 18),

                                        // Email
                                        TextFormField(
                                          controller: emailCtrl,
                                          focusNode: _emailNode,
                                          keyboardType: TextInputType.emailAddress,
                                          textInputAction: TextInputAction.next,
                                          autofillHints: const [
                                            AutofillHints.email,
                                            AutofillHints.username,
                                          ],
                                          onFieldSubmitted: (_) => _passNode.requestFocus(),
                                          validator: (v) {
                                            final s = (v ?? '').trim();
                                            if (s.isEmpty) return 'Required';
                                            if (!s.contains('@')) return 'Enter a valid email';
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            labelText: 'Email',
                                            hintText: 'example@email.com',
                                            prefixIcon: Icon(
                                              Icons.alternate_email_rounded,
                                              color: Colors.white.withValues(alpha: 0.65),
                                            ),
                                          ),
                                        ),

                                        const SizedBox(height: 14),

                                        // Password
                                        TextFormField(
                                          controller: passCtrl,
                                          focusNode: _passNode,
                                          obscureText: hidePassword,
                                          textInputAction: TextInputAction.done,
                                          autofillHints: const [AutofillHints.password],
                                          onFieldSubmitted: (_) => _login(),
                                          validator: (v) {
                                            final s = v ?? '';
                                            if (s.isEmpty) return 'Required';
                                            if (s.length < 6) return 'Min 6 characters';
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            labelText: 'Password',
                                            hintText: '••••••••',
                                            prefixIcon: Icon(
                                              Icons.lock_outline_rounded,
                                              color: Colors.white.withValues(alpha: 0.65),
                                            ),
                                            suffixIcon: IconButton(
                                              tooltip: hidePassword ? 'Show password' : 'Hide password',
                                              onPressed: () => setState(() => hidePassword = !hidePassword),
                                              icon: Icon(
                                                hidePassword
                                                    ? Icons.visibility_off_rounded
                                                    : Icons.visibility_rounded,
                                                color: Colors.white.withValues(alpha: 0.70),
                                              ),
                                            ),
                                          ),
                                        ),

                                        const SizedBox(height: 12),

                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 18,
                                              height: 18,
                                              child: Checkbox(
                                                value: rememberMe,
                                                onChanged: (v) => setState(() => rememberMe = v ?? false),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              'Remember me',
                                              style: text.bodySmall?.copyWith(
                                                color: Colors.white.withValues(alpha: 0.70),
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
                                                style: text.bodySmall?.copyWith(
                                                  color: Colors.white.withValues(alpha: 0.70),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        const SizedBox(height: 18),

                                        // Primary button uses global ElevatedButtonTheme
                                        ElevatedButton(
                                          onPressed: _login,
                                          child: const Text('Log In'),
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
                                                style: text.bodySmall?.copyWith(
                                                  color: Colors.white.withValues(alpha: 0.55),
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

                                        // Secondary button uses global OutlinedButtonTheme
                                        OutlinedButton.icon(
                                          onPressed: _googleLogin,
                                          icon: Icon(
                                            Icons.g_mobiledata_rounded,
                                            size: 28,
                                            color: Colors.white.withValues(alpha: 0.90),
                                          ),
                                          label: const Text('Continue with Google'),
                                        ),

                                        const SizedBox(height: 14),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Don’t have an account? ",
                                              style: text.bodySmall?.copyWith(
                                                color: Colors.white.withValues(alpha: 0.60),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () => Navigator.pushNamed(context, SignUpScreen.route),
                                              child: const Text(
                                                "Sign Up",
                                                style: TextStyle(
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w800,
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
}
