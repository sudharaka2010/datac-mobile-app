import 'package:flutter/material.dart';
import 'glass_card.dart';

// Screens (routes)
import '../screens/dashboard_screen.dart';
import '../screens/new_project_screen.dart';
import '../screens/upload_resource_screen.dart';
import '../screens/view_project_screen.dart';
import '../screens/account_settings_screen.dart';
import '../screens/login_screen.dart';

class DatacDrawer extends StatelessWidget {
  const DatacDrawer({super.key});

  // ✅ Drawer glass tone (matches your app)
  static const _glassBase = Color.fromRGBO(14, 18, 32, 1);

  // ✅ Brand token (NOW USED)
  static const _brand = Color.fromRGBO(48, 50, 61, 1);

  @override
  Widget build(BuildContext context) {
    final currentRoute = ModalRoute.of(context)?.settings.name;

    return Drawer(
      backgroundColor: Colors.black,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
          child: Column(
            children: [
              // ✅ Glass header
              GlassCard(
                glassColor: _glassBase.withValues(alpha: 0.72),
                borderColor: Colors.white.withValues(alpha: 0.10),
                radius: 22,
                blur: 14,
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
                child: Row(
                  children: [
                    // ✅ Brand icon bubble (uses _brand)
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: _brand.withValues(alpha: 0.85),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 16,
                            offset: const Offset(0, 10),
                            color: Colors.black.withValues(alpha: 0.25),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.auto_graph_rounded,
                        color: Colors.white.withValues(alpha: 0.95),
                      ),
                    ),
                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'DATAC',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                              color: Colors.white,
                              letterSpacing: 0.2,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Data collection & insights',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 12.5,
                              color: Colors.white.withValues(alpha: 0.65),
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Icon(
                      Icons.chevron_right_rounded,
                      color: Colors.white.withValues(alpha: 0.55),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              // ✅ Menu items
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _sectionLabel('Main'),

                    _drawerTile(
                      context,
                      currentRoute: currentRoute,
                      route: DashboardScreen.route,
                      icon: Icons.dashboard_rounded,
                      title: 'Dashboard',
                      subtitle: 'Overview & quick actions',
                    ),

                    _drawerTile(
                      context,
                      currentRoute: currentRoute,
                      route: NewProjectScreen.route,
                      icon: Icons.create_new_folder_rounded,
                      title: 'New Project',
                      subtitle: 'Create a workspace',
                    ),

                    _drawerTile(
                      context,
                      currentRoute: currentRoute,
                      route: UploadResourceScreen.route,
                      icon: Icons.cloud_upload_rounded,
                      title: 'Upload Resource',
                      subtitle: 'Add files & datasets',
                    ),

                    _drawerTile(
                      context,
                      currentRoute: currentRoute,
                      route: ViewProjectScreen.route,
                      icon: Icons.search_rounded,
                      title: 'View Projects',
                      subtitle: 'Search & open',
                    ),

                    const SizedBox(height: 10),
                    _sectionLabel('Settings'),

                    _drawerTile(
                      context,
                      currentRoute: currentRoute,
                      route: AccountSettingsScreen.route,
                      icon: Icons.settings_rounded,
                      title: 'Account Settings',
                      subtitle: 'Security & preferences',
                    ),

                    const SizedBox(height: 10),
                  ],
                ),
              ),

              // ✅ Bottom actions (Logout)
              GlassCard(
                glassColor: _glassBase.withValues(alpha: 0.55),
                borderColor: Colors.white.withValues(alpha: 0.10),
                radius: 18,
                blur: 14,
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Signed in (demo)',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12.5,
                          color: Colors.white.withValues(alpha: 0.70),
                        ),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        Navigator.pop(context); // close drawer
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          LoginScreen.route,
                          (_) => false,
                        );
                      },
                      icon: Icon(
                        Icons.logout_rounded,
                        size: 18,
                        color: Colors.redAccent.withValues(alpha: 0.90),
                      ),
                      label: Text(
                        'Logout',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          color: Colors.redAccent.withValues(alpha: 0.90),
                        ),
                      ),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        minimumSize: const Size(10, 10),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 6),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 11,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.8,
          color: Colors.white.withValues(alpha: 0.45),
        ),
      ),
    );
  }

  Widget _drawerTile(
    BuildContext context, {
    required String? currentRoute,
    required String route,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final isActive = currentRoute == route;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Material(
          color: isActive
              ? Colors.white.withValues(alpha: 0.10)
              : Colors.white.withValues(alpha: 0.06),
          child: InkWell(
            onTap: () {
              Navigator.pop(context); // close drawer
              if (currentRoute == route) return;

              // ✅ Clean navigation: replace current page with selected
              Navigator.pushReplacementNamed(context, route);
            },
            child: Container(
              padding: const EdgeInsets.fromLTRB(12, 12, 10, 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: isActive
                      ? Colors.white.withValues(alpha: 0.18)
                      : Colors.white.withValues(alpha: 0.10),
                ),
              ),
              child: Row(
                children: [
                  // ✅ Active brand accent line (uses _brand)
                  Container(
                    width: 3,
                    height: 44,
                    decoration: BoxDecoration(
                      color: isActive
                          ? _brand.withValues(alpha: 0.95)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  const SizedBox(width: 9),

                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: isActive
                          ? _brand.withValues(alpha: 0.35)
                          : Colors.white.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.10),
                      ),
                    ),
                    child: Icon(
                      icon,
                      color: Colors.white.withValues(alpha: isActive ? 1.0 : 0.86),
                      size: 22,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                title,
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white.withValues(
                                    alpha: isActive ? 1.0 : 0.95,
                                  ),
                                ),
                              ),
                            ),

                            // ✅ Active dot (uses _brand)
                            if (isActive)
                              Container(
                                width: 7,
                                height: 7,
                                decoration: BoxDecoration(
                                  color: _brand.withValues(alpha: 0.95),
                                  shape: BoxShape.circle,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12.2,
                            height: 1.15,
                            color: Colors.white.withValues(alpha: 0.62),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Icon(
                    Icons.chevron_right_rounded,
                    color: Colors.white.withValues(alpha: 0.45),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
