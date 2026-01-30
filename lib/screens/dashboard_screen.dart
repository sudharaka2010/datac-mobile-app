// lib/screens/dashboard_screen.dart
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import '../widgets/datac_drawer.dart';

import 'new_project_screen.dart';
import 'upload_resource_screen.dart';
import 'view_project_screen.dart';
import 'account_settings_screen.dart';

class DashboardScreen extends StatelessWidget {
  static const route = '/dashboard';
  const DashboardScreen({super.key});

  // ===== Design tokens (match your reference) =====
  static const Color _pageBg = Color(0xFF1E2A33);
  static const Color _selectCardColor = Color(0xDC394451); // #394451DC
  static const double _selectCardRadius = 30;

  // Action cards (approx from your screenshot)
  static const Color _cardNew = Color(0xFFFFB6A6);
  static const Color _cardView = Color(0xFF6FE3E6);
  static const Color _cardUpdate = Color(0xFFECCFB0);

  // NOTE:
  // Your HTML shows the right image panel uses a Base64 JPEG.
  // Putting the FULL base64 string inside this file is huge.
  // Best practice: save that image as an asset and use Image.asset(...).
  //
  // ✅ Do this:
  // 1) Create: assets/images/new_project.jpg
  // 2) Add in pubspec.yaml:
  //    assets:
  //      - assets/images/new_project.jpg
  //
  // If you still want base64: paste it into _newProjectImageBase64 and it will work.
  static const String _newProjectImageAsset = 'assets/images/new_project.jpg';

  // (Optional) If you insist base64, paste ONLY the base64 part (after "base64,")
  // into this string:
  static const String _newProjectImageBase64 = ''; // <- paste here if needed

  Uint8List? _decodeBase64Image(String b64) {
    if (b64.trim().isEmpty) return null;
    try {
      return base64Decode(b64);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final newProjectBytes = _decodeBase64Image(_newProjectImageBase64);

    return Scaffold(
      drawer: const DatacDrawer(),
      backgroundColor: _pageBg,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(18, 10, 18, 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _topHeader(context),
              const SizedBox(height: 18),

              const Text(
                'Select project',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),

              _selectProjectRow(),
              const SizedBox(height: 18),

              const Text(
                'Create,View & Update a Project',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),

              // Action cards
              _actionCard(
                context,
                color: _cardNew,
                iconBg: const Color(0xFFF6C24D),
                icon: Icons.add,
                title: 'New\nProject',
                bullets: const [
                  'Collect any type of data',
                  'Organize resources in one place',
                  'Start tracking instantly',
                ],
                // Right image panel: EXACT size from your CSS
                imagePanel: _RightImagePanel(
                  width: 182,
                  height: 135,
                  radius: 30,
                  // Use base64 if provided, else asset
                  child: newProjectBytes != null
                      ? Image.memory(newProjectBytes, fit: BoxFit.cover)
                      : Image.asset(_newProjectImageAsset, fit: BoxFit.cover),
                ),
                onTap: () => Navigator.pushNamed(context, NewProjectScreen.route),
              ),
              const SizedBox(height: 16),

              _actionCard(
                context,
                color: _cardView,
                iconBg: const Color(0xFF2CBFC2),
                icon: Icons.remove_red_eye_outlined,
                title: 'View\nProjects',
                bullets: const [
                  'Collect any type of data',
                  'Organize resources in one place',
                  'Start tracking instantly',
                ],
                // Put your own asset here (recommended)
                imagePanel: const _RightImagePanel(
                  width: 182,
                  height: 135,
                  radius: 30,
                  child: _ImagePlaceholder(),
                ),
                onTap: () => Navigator.pushNamed(context, ViewProjectScreen.route),
              ),
              const SizedBox(height: 16),

              _actionCard(
                context,
                color: _cardUpdate,
                iconBg: const Color(0xFF25C2A0),
                icon: Icons.refresh,
                title: 'Update\nProjects',
                bullets: const [
                  'Collect any type of data',
                  'Organize resources in one place',
                  'Start tracking instantly',
                ],
                imagePanel: const _RightImagePanel(
                  width: 182,
                  height: 135,
                  radius: 30,
                  child: _ImagePlaceholder(),
                ),
                onTap: () => Navigator.pushNamed(context, ViewProjectScreen.route),
              ),

              const SizedBox(height: 18),

              // Optional bottom quick bar (matches your phone screenshot idea)
              _bottomQuickBar(context),
            ],
          ),
        ),
      ),
    );
  }

  // ===== Header =====
  Widget _topHeader(BuildContext context) {
    return Row(
      children: [
        // Avatar bubble
        Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.10),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.person,
            color: Colors.white.withValues(alpha: 0.85),
          ),
        ),
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
              const SizedBox(height: 3),
              const Text(
                'Sudharaka',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  height: 1.05,
                ),
              ),
            ],
          ),
        ),

        _roundIconButton(
          tooltip: 'Search',
          icon: Icons.search,
          onTap: () {
            // TODO: open search screen/dialog later
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Search coming soon')),
            );
          },
        ),
        const SizedBox(width: 10),
        _roundIconButton(
          tooltip: 'Notifications',
          icon: Icons.notifications_none_rounded,
          onTap: () {
            // TODO: open notifications later
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Notifications coming soon')),
            );
          },
          showDot: true,
        ),
      ],
    );
  }

  Widget _roundIconButton({
    required String tooltip,
    required IconData icon,
    required VoidCallback onTap,
    bool showDot = false,
  }) {
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
              color: Colors.white.withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white.withValues(alpha: 0.9)),
          ),
        ),
        if (showDot)
          Positioned(
            right: 6,
            top: 6,
            child: Container(
              width: 7,
              height: 7,
              decoration: const BoxDecoration(
                color: Color(0xFF8BFF7B),
                shape: BoxShape.circle,
              ),
            ),
          ),
      ],
    );
  }

  // ===== Select project row (116x117, radius 30, bg #394451DC) =====
  Widget _selectProjectRow() {
    final items = <_SelectItem>[
      _SelectItem(
        iconBg: const Color(0xFFC8F25C),
        icon: Icons.account_balance_outlined,
        count: '1155 Data',
        label: 'Banks',
      ),
      _SelectItem(
        iconBg: const Color(0xFF7BFFD6),
        icon: Icons.receipt_long_rounded,
        count: '200 Data',
        label: 'Accounts',
      ),
      _SelectItem(
        iconBg: const Color(0xFF7CC8FF),
        icon: Icons.handyman_rounded,
        count: '90 Data',
        label: 'Services',
      ),
      _SelectItem(
        iconBg: const Color(0xFFFF74B8),
        icon: Icons.admin_panel_settings_outlined,
        count: '420 Data',
        label: 'Audit',
      ),
    ];

    return SizedBox(
      height: 117,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, i) => _selectCard(items[i]),
      ),
    );
  }

  Widget _selectCard(_SelectItem item) {
    return Container(
      width: 116,
      height: 117,
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        color: _selectCardColor,
        borderRadius: BorderRadius.circular(_selectCardRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: item.iconBg,
              shape: BoxShape.circle,
            ),
            child: Icon(item.icon, size: 20, color: Colors.black.withValues(alpha: 0.85)),
          ),
          const Spacer(),
          Text(
            item.count,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.white.withValues(alpha: 0.55),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            item.label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              height: 1.05,
            ),
          ),
        ],
      ),
    );
  }

  // ===== Action card (fixes your S23 Ultra overflow) =====
  Widget _actionCard(
    BuildContext context, {
    required Color color,
    required Color iconBg,
    required IconData icon,
    required String title,
    required List<String> bullets,
    required Widget imagePanel,
    required VoidCallback onTap,
  }) {
    // Same main size as your CSS: 373 x 147 (we keep height exactly 147)
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: onTap,
      child: Container(
        height: 147,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.fromLTRB(16, 14, 12, 12),
        child: Row(
          children: [
            // LEFT content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // top row (icon + title)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
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

                  // BULLETS (this is where your overflow happened)
                  // ✅ Fix: make each bullet maxLines=2 and keep spacing tight.
                  ...bullets.map(
                    (t) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        '- $t',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.black.withValues(alpha: 0.75),
                          height: 1.15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            // RIGHT image panel (182 x 135, radius 30)
            imagePanel,
          ],
        ),
      ),
    );
  }

  // Optional bottom quick bar (Upload / Settings)
  Widget _bottomQuickBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Expanded(
            child: _quickButton(
              icon: Icons.cloud_upload_outlined,
              label: 'Upload',
              onTap: () => Navigator.pushNamed(context, UploadResourceScreen.route),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _quickButton(
              icon: Icons.settings_rounded,
              label: 'Settings',
              onTap: () => Navigator.pushNamed(context, AccountSettingsScreen.route),
            ),
          ),
        ],
      ),
    );
  }

  Widget _quickButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        height: 54,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(18),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white.withValues(alpha: 0.9)),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===== Models & helpers =====
class _SelectItem {
  final Color iconBg;
  final IconData icon;
  final String count;
  final String label;

  _SelectItem({
    required this.iconBg,
    required this.icon,
    required this.count,
    required this.label,
  });
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

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withValues(alpha: 0.30),
      child: Center(
        child: Icon(
          Icons.image_outlined,
          color: Colors.black.withValues(alpha: 0.45),
          size: 26,
        ),
      ),
    );
  }
}
