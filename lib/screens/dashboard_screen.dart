import 'package:flutter/material.dart';
import '../widgets/datac_drawer.dart';
import 'new_project_screen.dart';
import 'upload_resource_screen.dart';
import 'view_project_screen.dart';
import 'account_settings_screen.dart';

class DashboardScreen extends StatelessWidget {
  static const route = '/dashboard';
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const titleColor = Color.fromRGBO(48, 50, 61, 1);

    return Scaffold(
      drawer: const DatacDrawer(),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'DATAC',
          style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w800),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/bg_dark.png', fit: BoxFit.cover),

          // soft overlay for readability
          Container(color: Colors.black.withValues(alpha: 0.35)),

          // bottom gradient for depth
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.45,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.25),
                    Colors.black.withValues(alpha: 0.55),
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 14, 18, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ✅ Header glass card
                  _headerCard(titleColor),

                  const SizedBox(height: 18),

                  // Section title row
                  Row(
                    children: [
                      const Text(
                        'Quick Actions',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () => Navigator.pushNamed(
                          context,
                          AccountSettingsScreen.route,
                        ),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white.withValues(alpha: 0.85),
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(10, 10),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          'Settings',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // ✅ Responsive grid (phone 2 cols, tablet 3 cols)
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, c) {
                        final w = c.maxWidth;
                        final crossAxisCount = w >= 600 ? 3 : 2;

                        return GridView.count(
                          crossAxisCount: crossAxisCount,
                          mainAxisSpacing: 14,
                          crossAxisSpacing: 14,
                          childAspectRatio: 1.05,
                          children: [
                            _actionTile(
                              context,
                              icon: Icons.folder_open_rounded,
                              title: 'New Project',
                              subtitle: 'Create a new workspace',
                              route: NewProjectScreen.route,
                            ),
                            _actionTile(
                              context,
                              icon: Icons.cloud_upload_rounded,
                              title: 'Upload Resource',
                              subtitle: 'Add files & datasets',
                              route: UploadResourceScreen.route,
                            ),
                            _actionTile(
                              context,
                              icon: Icons.search_rounded,
                              title: 'View Projects',
                              subtitle: 'Search & open',
                              route: ViewProjectScreen.route,
                            ),
                            _actionTile(
                              context,
                              icon: Icons.edit_note_rounded,
                              title: 'Edit Project',
                              subtitle: 'Update details',
                              route: ViewProjectScreen.route,
                            ),
                            _actionTile(
                              context,
                              icon: Icons.delete_outline_rounded,
                              title: 'Delete Project',
                              subtitle: 'Remove old work',
                              route: ViewProjectScreen.route,
                              danger: true,
                            ),
                            _actionTile(
                              context,
                              icon: Icons.tune_rounded,
                              title: 'Project Settings',
                              subtitle: 'Permissions & options',
                              route: ViewProjectScreen.route,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------- UI PARTS ----------

  Widget _headerCard(Color titleColor) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome 👋',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Manage projects, upload resources, and track your collected data.',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 12.5,
              height: 1.25,
              color: Colors.white.withValues(alpha: 0.75),
            ),
          ),
          const SizedBox(height: 14),

          // quick stats row
          Row(
            children: [
              _statChip('Projects', '08'),
              const SizedBox(width: 10),
              _statChip('Uploads', '24'),
              const SizedBox(width: 10),
              _statChip('Insights', '12'),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  'DATAC',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w800,
                    color: titleColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statChip(String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.18),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 11,
                color: Colors.white.withValues(alpha: 0.65),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required String route,
    bool danger = false,
  }) {
    final iconBg = danger
        ? Colors.red.withValues(alpha: 0.18)
        : Colors.white.withValues(alpha: 0.12);

    final iconColor = danger ? Colors.redAccent : Colors.white;

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // icon row
            Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: iconBg,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
                  ),
                  child: Icon(icon, color: iconColor, size: 22),
                ),
                const Spacer(),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
                  color: Colors.white.withValues(alpha: 0.55),
                ),
              ],
            ),

            const Spacer(),

            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 14.5,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 11.5,
                color: Colors.white.withValues(alpha: 0.70),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
