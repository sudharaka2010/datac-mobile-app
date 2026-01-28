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

  final _emailNode = FocusNode();
  final _nameNode = FocusNode();
  final _userNode = FocusNode();
  final _passNode = FocusNode();
  final _confirmNode = FocusNode();

  bool hidePassword = true;
  bool hideConfirm = true;
  bool agree = true;

  @override
  void dispose() {
    _emailNode.dispose();
    _nameNode.dispose();
    _userNode.dispose();
    _passNode.dispose();
    _confirmNode.dispose();

    emailCtrl.dispose();
    nameCtrl.dispose();
    usernameCtrl.dispose();
    passCtrl.dispose();
    confirmCtrl.dispose();
    super.dispose();
  }

  void _signup() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.pushReplacementNamed(context, DashboardScreen.route);
    }
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    final glassColor = const Color.fromRGBO(14, 18, 32, 1).withValues(alpha: 0.72);
    final borderColor = Colors.white.withValues(alpha: 0.10);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/bg_login.jpg',
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
          Container(color: Colors.black.withValues(alpha: 0.08)),
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
                                          'Create account',
                                          style: text.titleLarge?.copyWith(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 24,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          'Sign up to start collecting and managing data.',
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
                                          autofillHints: const [AutofillHints.email],
                                          onFieldSubmitted: (_) => _nameNode.requestFocus(),
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

                                        // Full name
                                        TextFormField(
                                          controller: nameCtrl,
                                          focusNode: _nameNode,
                                          textInputAction: TextInputAction.next,
                                          autofillHints: const [AutofillHints.name],
                                          onFieldSubmitted: (_) => _userNode.requestFocus(),
                                          validator: (v) {
                                            final s = (v ?? '').trim();
                                            if (s.isEmpty) return 'Required';
                                            if (s.length < 3) return 'Enter your name';
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            labelText: 'Full name',
                                            hintText: 'Your name',
                                            prefixIcon: Icon(
                                              Icons.person_outline_rounded,
                                              color: Colors.white.withValues(alpha: 0.65),
                                            ),
                                          ),
                                        ),

                                        const SizedBox(height: 14),

                                        // Username
                                        TextFormField(
                                          controller: usernameCtrl,
                                          focusNode: _userNode,
                                          textInputAction: TextInputAction.next,
                                          autofillHints: const [AutofillHints.username],
                                          onFieldSubmitted: (_) => _passNode.requestFocus(),
                                          validator: (v) {
                                            final s = (v ?? '').trim();
                                            if (s.isEmpty) return 'Required';
                                            final ok = RegExp(r'^[a-zA-Z0-9._]{3,20}$').hasMatch(s);
                                            if (!ok) return '3–20 chars (letters, numbers, . _)';
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            labelText: 'Username',
                                            hintText: 'username',
                                            prefixIcon: Icon(
                                              Icons.badge_outlined,
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
                                          textInputAction: TextInputAction.next,
                                          autofillHints: const [AutofillHints.newPassword],
                                          onFieldSubmitted: (_) => _confirmNode.requestFocus(),
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

                                        const SizedBox(height: 14),

                                        // Confirm password
                                        TextFormField(
                                          controller: confirmCtrl,
                                          focusNode: _confirmNode,
                                          obscureText: hideConfirm,
                                          textInputAction: TextInputAction.done,
                                          autofillHints: const [AutofillHints.newPassword],
                                          onFieldSubmitted: (_) => agree ? _signup() : null,
                                          validator: (v) {
                                            final s = v ?? '';
                                            if (s.isEmpty) return 'Required';
                                            if (s != passCtrl.text) return 'Passwords do not match';
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            labelText: 'Confirm password',
                                            hintText: '••••••••',
                                            prefixIcon: Icon(
                                              Icons.lock_outline_rounded,
                                              color: Colors.white.withValues(alpha: 0.65),
                                            ),
                                            suffixIcon: IconButton(
                                              tooltip: hideConfirm ? 'Show password' : 'Hide password',
                                              onPressed: () => setState(() => hideConfirm = !hideConfirm),
                                              icon: Icon(
                                                hideConfirm
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
                                                value: agree,
                                                onChanged: (v) => setState(() => agree = v ?? false),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Text(
                                                'I agree to the Terms & Privacy',
                                                style: text.bodySmall?.copyWith(
                                                  color: Colors.white.withValues(alpha: 0.70),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        if (!agree) ...[
                                          const SizedBox(height: 6),
                                          Text(
                                            'Please accept Terms & Privacy to continue.',
                                            style: text.bodySmall?.copyWith(
                                              color: Colors.white.withValues(alpha: 0.55),
                                              fontSize: 11.5,
                                            ),
                                          ),
                                        ],

                                        const SizedBox(height: 16),

                                        ElevatedButton(
                                          onPressed: agree ? _signup : null,
                                          child: const Text('Create account'),
                                        ),

                                        const SizedBox(height: 14),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Already have an account? ",
                                              style: text.bodySmall?.copyWith(
                                                color: Colors.white.withValues(alpha: 0.60),
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
