import 'package:flutter/material.dart';

import '../widgets/datac_drawer.dart';
import 'new_project_screen.dart';
import 'view_project_screen.dart';
// import 'upload_resource_screen.dart'; // optional if you want later
import 'account_settings_screen.dart';

class DashboardScreen extends StatelessWidget {
  static const route = '/dashboard';
  const DashboardScreen({super.key});

  // =========================
  // ✅ IMAGE PLACES (4 images)
  // =========================
  // 1) Background
  static const String _bgImage = 'assets/images/bg_dark.png';

  // 2) Profile image (top-left)
  static const String _profileImage = 'assets/images/profile.jpg';

  // 3) Card images (right side panels)
  static const String _newProjectImg = 'assets/images/new_project.jpg';
  static const String _viewProjectsImg = 'assets/images/view_projects.jpg';
  static const String _updateProjectsImg = 'assets/images/update_projects.png';

  // Tokens (match your style)
  static const Color _pageBg = Color(0xFF101820);
  static const Color _selectCardBg = Color(0xDC394451); // #394451DC
  static const double _r30 = 30;

  @override
  Widget build(BuildContext context) {
    // ✅ Helps prevent overflow when user device text size is bigger
    // (keeps the card content stable on S23 Ultra too)
    final media = MediaQuery.of(context);
    final safeBottom = media.padding.bottom;

    return MediaQuery(
      data: media.copyWith(
        // clamp text scaling a bit to avoid overflow on small areas
        textScaler: media.textScaler.clamp(minScaleFactor: 1.0, maxScaleFactor: 1.10),
      ),
      child: Scaffold(
        drawer: const DatacDrawer(),
        extendBodyBehindAppBar: true,
        backgroundColor: _pageBg,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            // Background
            Image.asset(_bgImage, fit: BoxFit.cover),
            Container(color: Colors.black.withValues(alpha: 0.35)),

            SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.fromLTRB(18, 10, 18, 18 + safeBottom),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // =========================
                    // Header Row (profile + icons)
                    // =========================
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _ProfileAvatar(imagePath: _profileImage),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome!',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white.withValues(alpha: 0.55),
                                ),
                              ),
                              const SizedBox(height: 2),
                              const Text(
                                'Sudharaka',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),

                        _CircleIconButton(
                          icon: Icons.search_rounded,
                          onTap: () {
                            // TODO: search later
                          },
                        ),
                        const SizedBox(width: 10),
                        _CircleIconButton(
                          icon: Icons.notifications_none_rounded,
                          showDot: true,
                          onTap: () {
                            // TODO: notifications later
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    const Text(
                      'Select project',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // =========================
                    // Select project horizontal cards
                    // =========================
                    SizedBox(
                      height: 130,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        children: const [
                          _SelectProjectCard(
                            icon: Icons.account_balance_rounded,
                            iconBg: Color(0xFFC7F54B),
                            countText: '1155 Data',
                            title: 'Banks',
                          ),
                          SizedBox(width: 12),
                          _SelectProjectCard(
                            icon: Icons.receipt_long_rounded,
                            iconBg: Color(0xFF62F3D4),
                            countText: '200 Data',
                            title: 'Accounts',
                          ),
                          SizedBox(width: 12),
                          _SelectProjectCard(
                            icon: Icons.build_rounded,
                            iconBg: Color(0xFF7CC6FF),
                            countText: '90 Data',
                            title: 'Services',
                          ),
                          SizedBox(width: 12),
                          _SelectProjectCard(
                            icon: Icons.admin_panel_settings_rounded,
                            iconBg: Color(0xFFFF6DAA),
                            countText: '420 Data',
                            title: 'Audit',
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    const Text(
                      'Create, View & Update a Project',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // =========================
                    // Action Cards (3)
                    // =========================
                    _ActionCard(
                      bgColor: const Color(0xFFFFB6A6),
                      icon: Icons.add_rounded,
                      iconBg: const Color(0xFFF6C55A),
                      title: 'New\nProject',
                      bullets: const [
                        'Collect any type of data',
                        'Organize resources in one place',
                        'Start tracking instantly',
                      ],
                      imagePath: _newProjectImg,
                      onTap: () => Navigator.pushNamed(context, NewProjectScreen.route),
                    ),

                    const SizedBox(height: 14),

                    _ActionCard(
                      bgColor: const Color(0xFF72E2E6),
                      icon: Icons.remove_red_eye_rounded,
                      iconBg: const Color(0xFF53C9CC),
                      title: 'View\nProjects',
                      bullets: const [
                        'Collect any type of data',
                        'Organize resources in one place',
                        'Start tracking instantly',
                      ],
                      imagePath: _viewProjectsImg,
                      onTap: () => Navigator.pushNamed(context, ViewProjectScreen.route),
                    ),

                    const SizedBox(height: 14),

                    _ActionCard(
                      bgColor: const Color(0xFFEBD0B6),
                      icon: Icons.refresh_rounded,
                      iconBg: const Color(0xFF63D1A8),
                      title: 'Update\nProjects',
                      bullets: const [
                        'Collect any type of data',
                        'Organize resources in one place',
                        'Start tracking instantly',
                      ],
                      imagePath: _updateProjectsImg,
                      onTap: () => Navigator.pushNamed(context, AccountSettingsScreen.route),
                    ),

                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =========================
// Widgets
// =========================

class _ProfileAvatar extends StatelessWidget {
  final String imagePath;
  const _ProfileAvatar({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      ),
      child: ClipOval(
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) {
            // fallback if image missing
            return Container(
              color: Colors.white.withValues(alpha: 0.10),
              child: const Icon(Icons.person, color: Colors.white),
            );
          },
        ),
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool showDot;

  const _CircleIconButton({
    required this.icon,
    required this.onTap,
    this.showDot = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(999),
          onTap: onTap,
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.10),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
            ),
            child: Icon(icon, color: Colors.white.withValues(alpha: 0.92)),
          ),
        ),
        if (showDot)
          Positioned(
            right: 10,
            top: 10,
            child: Container(
              width: 7,
              height: 7,
              decoration: const BoxDecoration(
                color: Color(0xFF6CFF6C),
                shape: BoxShape.circle,
              ),
            ),
          ),
      ],
    );
  }
}

class _SelectProjectCard extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final String countText;
  final String title;

  const _SelectProjectCard({
    required this.icon,
    required this.iconBg,
    required this.countText,
    required this.title,
  });

  static const Color _selectCardBg = Color(0xDC394451); // #394451DC

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 116,
      height: 117,
      decoration: BoxDecoration(
        color: _selectCardBg,
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconBg,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.black, size: 20),
          ),
          const Spacer(),
          Text(
            countText,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.white.withValues(alpha: 0.50),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final Color bgColor;
  final IconData icon;
  final Color iconBg;
  final String title;
  final List<String> bullets;
  final String imagePath;
  final VoidCallback onTap;

  const _ActionCard({
    required this.bgColor,
    required this.icon,
    required this.iconBg,
    required this.title,
    required this.bullets,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // ✅ fixed card height like your Figma (373x147)
    // If you want it more responsive, you can use constraints instead.
    const double cardH = 147;

    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: onTap,
      child: Container(
        height: cardH,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
        child: Row(
          children: [
            // LEFT SIDE (icon + title + bullets)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: iconBg,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(icon, color: Colors.black, size: 22),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                            height: 1.1,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // ✅ OVERFLOW FIX:
                  // - Use Expanded
                  // - Each bullet is maxLines 1 with ellipsis
                  // - No red overflow even on S23 Ultra / larger fonts
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: bullets.map((t) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            '– $t',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12.2,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                              height: 1.15,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            // RIGHT IMAGE PANEL (182x135, radius 30)
            _RightImagePanel(
              width: 182,
              height: 135,
              radius: 30,
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  // fallback if missing image
                  return Container(
                    color: Colors.black.withValues(alpha: 0.06),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.image_outlined,
                      size: 34,
                      color: Colors.black.withValues(alpha: 0.35),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RightImagePanel extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  final Widget child;

  const _RightImagePanel({
    required this.width,
    required this.height,
    required this.radius,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: SizedBox(
        width: width,
        height: height,
        child: child,
      ),
    );
  }
}
